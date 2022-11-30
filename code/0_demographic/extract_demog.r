

library(tidyverse)
library(here)
library(jsonlite)

#INPUT_PATH <- here("data/raw_data/anonymized_All.csv")
#OUTPUT_PATH <- here("data/processed_data/demog_All.csv")

# take raw_df 
# take culture string "US" or "CN"
extract_demog <- function(raw_df, culture_string){
  demog_fields <- c("demog_country_born_current_grew_up", 
                    "demog_oversea_experience",
                    "demog_conditional_year_abroad_regions",
                    "demog_language",
                    "demog_conditional_language_target_fluency",
                    "demog_age_gender_ethnic",
                    "demo-objses")
  
  if (culture_string == "US") {
    demog_fields <- c(demog_fields, c("demog_language_cn",
                                      "demog_conditional_language_cn_fluency",
                                      "demog_language_vi",
                                      "demog_conditional_language_vn_fluency"))
  } else if (culture_string == "CN") {
    demog_fields <- c(demog_fields, c("demog_language_en",
                                      "demog_conditional_language_en_fluency",
                                      "demog_language_vi",
                                      "demog_conditional_language_vn_fluency"))
  } else if (culture_string == "VN") {
    demog_fields <- c(demog_fields, c("demog_language_en",
                                      "demog_conditional_language_en_fluency",
                                      "demog_language_cn",
                                      "demog_conditional_language_cn_fluency"))
  } else {
    stop("culture_string has to be US / CN / VN")
  }

  # non dropdown demog 
  demog <- raw_df %>%
    filter(variable_type %in% demog_fields) %>% 
    select(subject, trial_type, variable_type, responses) %>%
    filter(trial_type != "demog-dropdown") %>% 
    group_by(subject) %>%
    mutate(responses = map(responses, ~ fromJSON(.) %>% as.data.frame())) %>%
    unnest(responses) %>%
    select(-variable_type) %>%
    group_by(subject) %>%
    mutate_at(vars(-group_cols()), function(x) {
      lapply((list(as.character(x))), function(x) unique(x[!is.na(x)]))
    }) %>%
    distinct() %>%
    mutate_at(vars(-group_cols()), as.character) %>%
    rename(oversea_exp_regions = which_regions) %>% #mutate which_regions into overseas regions
    pivot_longer(
      cols = -c(subject, trial_type),
      names_to = "demog_question",
      values_to = "demog_response"
    ) %>%
    mutate(
      demog_response = as.character(demog_response),
    ) %>%
    select(-trial_type)

  demog_dropdown <- raw_df %>%
    filter(variable_type %in% demog_fields) %>%
    select(subject, trial_type, variable_type, responses) %>%
    filter(trial_type == "demog-dropdown") %>%
    group_by(subject) %>%
    mutate(responses = map(responses, ~ fromJSON(.))) %>%
    unnest(responses) %>%
    group_by(subject, variable_type) %>%
    #add row number to question type to seperate question from answer
    mutate(q_id = row_number()) %>%
    # since answer often occurs second, it must be an even number
    filter(q_id %% 2 == 0) %>%
    mutate(q_id = q_id / 2)

  demog_dropdown_country_bcg <- demog_dropdown %>%
    filter(variable_type == "demog_country_born_current_grew_up") %>%
    mutate(
      demog_question = case_when(
        q_id == 1 ~ "country_born",
        q_id == 2 ~ "current_in",
        q_id == 3 ~ "state_grewup"
      )
    )

  demog_dropdown_age_gender_ethnic <- demog_dropdown %>%
    filter(variable_type == "demog_age_gender_ethnic") %>%
    mutate(
      demog_question = case_when(
        q_id == 1 ~ "age",
        q_id == 2 ~ "gender",
        q_id == 3 ~ "ethnic"
      )
    )

  demog_dropdown_langfluency_en <- demog_dropdown %>%
    filter(variable_type == "demog_conditional_language_en_fluency") %>%
    mutate(
      demog_question = case_when(
        q_id == 1 ~ "lang_sp_en",
        q_id == 2 ~ "lang_ud_en"
      )
    )

  demog_dropdown_langfluency_zh <- demog_dropdown %>%
    filter(variable_type == "demog_conditional_language_cn_fluency") %>%
    mutate(
      demog_question = case_when(
        q_id == 1 ~ "lang_sp_zh",
        q_id == 2 ~ "lang_ud_zh"
      )
    )

  demog_dropdown_langfluency_vi <- demog_dropdown %>%
    filter(variable_type == "demog_conditional_language_vn_fluency") %>%
    mutate(
      demog_question = case_when(
        q_id == 1 ~ "lang_sp_vi",
        q_id == 2 ~ "lang_ud_vi"
      )
    )

  demog_dropdown_all <- bind_rows(demog_dropdown_country_bcg,
                                  demog_dropdown_age_gender_ethnic,
                                  demog_dropdown_langfluency_en,
                                  demog_dropdown_langfluency_vi,
                                  demog_dropdown_langfluency_zh) %>%
    mutate(demog_response = as.character(responses)) %>%
    select(subject, demog_question, demog_response)

  demog_all <- bind_rows(demog, demog_dropdown_all) %>%
    rowwise() %>%
    mutate(country = culture_string,
           demog_response = if_else(demog_response == "character(0)",
                                    NA_character_,
                                    demog_response),
           demog_question = factor(demog_question),
           demog_question = fct_relevel(demog_question,
                                        c("country_born","current_in","state_grewup",
                                          "abroadexp", "overseaexpnum",
                                          "oversea_exp_regions",
                                          "firstlanguage", "monolingual",
                                          "englishlanguage", "lang_sp_en", "lang_ud_en",
                                          "chineselanguage", "lang_sp_zh", "lang_ud_zh",
                                          "vietnameselanguage", "lang_sp_vi", "lang_ud_vi",
                                          "objectiveses", "subjectiveses",
                                          "age", "gender", "ethnic"))
           ) %>%

    select(-variable_type) %>%
    arrange(subject, demog_question) %>%
    pivot_wider(names_from = "demog_question", 
                values_from = "demog_response")
  
  return(demog_all)
}


