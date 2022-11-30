library("papaja")
library("knitr") # for knitting things
library("tidyverse") # for all things tidyverse
library("car")
library("lme4")
library("patchwork")
library("effsize")
library("here")

# Seed for random number generation-----
set.seed(42)
knitr::opts_chunk$set(cache.extra = knitr::rand_seed)


#loading responding data --------
df.resp_E <- read.csv(paste(here(), "/data/responding/dataUS_excl.csv", sep = "")) %>%
  select(-X)

df.resp_V <- read.csv(paste(here(), "/data/responding/dataVN_excl.csv", sep = "")) %>%
  select(-X)

df.resp_M <- read.csv(paste(here(), "/data/responding/dataCN_excl.csv", sep = "")) %>%
  select(-X)

#loading corpus data ---------
df.corpus_E <- read.csv(paste(here(), "/data/corpus/corpusE.csv", sep = "")) %>%
  rename(tax_frequency_E = tax.frequency,
         theme_frequency_E = theme.frequency,
         tax_cosine_E = Tax.cosine_dist, 
         theme_cosine_E = Theme.cosine_dist,
         tax_cosine_sim_E = Tax.cosine_sim,
         theme_cosine_sim_E = Theme.cosine_sim,
         tax_match_E = Tax.match,
         theme_match_E = Theme.match, 
         cue_E = Cue)

df.corpus_V <- read.csv(paste(here(), "/data/corpus/corpusV.csv", sep = "")) %>%
  rename(tax_frequency_V = tax.frequency,
         theme_frequency_V = theme.frequency,
         tax_cosine_V = Tax.cosine_dist, 
         theme_cosine_V = Theme.cosine_dist,
         tax_cosine_sim_V = Tax.cosine_sim,
         theme_cosine_sim_V = Theme.cosine_sim,
         tax_match_V = Tax.match,
         theme_match_V = Theme.match, 
         cue_V = Cue)

df.corpus_M <- read.csv(paste(here(), "/data/corpus/corpusM.csv", sep = "")) %>%
  rename(tax_frequency_M = tax.frequency,
         theme_frequency_M = theme.frequency,
         tax_cosine_M = Tax.cosine_dist, 
         theme_cosine_M = Theme.cosine_dist,
         tax_cosine_sim_M = Tax.cosine_sim,
         theme_cosine_sim_M = Theme.cosine_sim,
         tax_match_M = Tax.match,
         theme_match_M = Theme.match, 
         cue_M = Cue)

df.corpus <- left_join(df.corpus_E, df.corpus_V, by = "Cue_renamed")
df.corpus <- left_join(df.corpus, df.corpus_M, by = "Cue_renamed")

#replacing any 0 raw counts with epsilon --------
df.corpus <- df.corpus %>%
  mutate(tax_frequency_E = ifelse(tax_frequency_E == 0, 
                                  .Machine$double.eps, tax_frequency_E),
         theme_frequency_E = ifelse(theme_frequency_E == 0, 
                                    .Machine$double.eps, theme_frequency_E),
         tax_frequency_V = ifelse(tax_frequency_V == 0, 
                                  .Machine$double.eps, tax_frequency_V),
         theme_frequency_V = ifelse(theme_frequency_V == 0, 
                                    .Machine$double.eps, theme_frequency_V), 
         tax_frequency_M = ifelse(tax_frequency_M == 0, 
                                  .Machine$double.eps, tax_frequency_M),
         theme_frequency_M = ifelse(theme_frequency_M == 0, 
                                    .Machine$double.eps, theme_frequency_M)
  )

# find triads_omit, used wherever analysis uses raw collocates --------
df.corpus_E_freq <- df.corpus_E %>%
  select(Cue_renamed, cue_E, tax_match_E, theme_match_E, tax_frequency_E, theme_frequency_E)
corpus_E_omit <- df.corpus_E_freq %>%
  filter(tax_frequency_E == 0 & theme_frequency_E == 0)

df.corpus_V_freq <- df.corpus_V %>%
  select(Cue_renamed, cue_V, tax_match_V, theme_match_V, tax_frequency_V, theme_frequency_V)
corpus_V_omit <- df.corpus_V_freq %>% 
  filter(tax_frequency_V == 0 & theme_frequency_V == 0)

df.corpus_M_freq <- df.corpus_M %>%
  select(Cue_renamed, cue_M, tax_match_M, theme_match_M, tax_frequency_M, theme_frequency_M)
corpus_M_omit <- df.corpus_M_freq %>% 
  filter(tax_frequency_M == 0 & theme_frequency_M == 0)

triads_omit <- append(corpus_E_omit$Cue_renamed, 
                      corpus_V_omit$Cue_renamed)
triads_omit <- append(triads_omit,
                      corpus_M_omit$Cue_renamed)

df.corpus_freq <- left_join(df.corpus_E_freq, 
                            df.corpus_V_freq, 
                            df.corpus_M_freq,
                            by = "Cue_renamed")

#mainly for sanity checking and so that there is a parallel df to df.corpus_freq--------
df.corpus_E_cos <- df.corpus_E %>%
  select(Cue_renamed, cue_E, tax_match_E, theme_match_E, 
         tax_cosine_E, theme_cosine_E,
         tax_cosine_sim_E, theme_cosine_sim_E)

df.corpus_V_cos <- df.corpus_V %>%
  select(Cue_renamed, cue_V, tax_match_V, theme_match_V, tax_cosine_V, theme_cosine_V,
         tax_cosine_sim_V, theme_cosine_sim_V)

df.corpus_M_cos <- df.corpus_M %>%
  select(Cue_renamed, cue_M, tax_match_M, theme_match_M, tax_cosine_M, theme_cosine_M, 
         tax_cosine_sim_M, theme_cosine_sim_M)

df.corpus_cos <- left_join(df.corpus_E_cos, df.corpus_V_cos, by = "Cue_renamed")
df.corpus_cos <- left_join(df.corpus_cos, df.corpus_M_cos, by = "Cue_renamed")


#combine response and corpus data-------
df.triad_E <- df.resp_E %>%
  filter(stim_type == "triad",
         responses != "NA")
triad_cues_E <- read.csv("../../data/corpus/cue_renamed_E.csv")
df.triad_E <- left_join(df.triad_E, triad_cues_E, by = c("cue", "top_opt", "bottom_opt"))
df.triad_E <- inner_join(df.triad_E, df.corpus, by = "Cue_renamed")

df.triad_E <- df.triad_E %>%
  mutate(responses_theme = ifelse(responses == theme_match_E, 1, 0),
         language = "English",
         country = "US") %>%
  select(subject, rt, Cue_renamed, cue, top_opt, bottom_opt, 
         responses, responses_theme, country, language,
         tax_match_E, theme_match_E, tax_match_V, theme_match_V, tax_match_M, theme_match_M,
         tax_frequency_E, theme_frequency_E, tax_frequency_V, theme_frequency_V, tax_frequency_M, theme_frequency_M,
         tax_cosine_E, theme_cosine_E, tax_cosine_V, theme_cosine_V, tax_cosine_M, theme_cosine_M,
         tax_cosine_sim_E, theme_cosine_sim_E, tax_cosine_sim_V, theme_cosine_sim_V, tax_cosine_sim_M, theme_cosine_sim_M)

df.triad_V <- df.resp_V %>%
  filter(stim_type == "triad",
         responses != "NA")
triad_cues_V <- read.csv("../../data/corpus/cue_renamed_V.csv")
df.triad_V <- left_join(df.triad_V, triad_cues_V, by = c("cue", "top_opt", "bottom_opt"))
df.triad_V <- inner_join(df.triad_V, df.corpus, by = "Cue_renamed")

df.triad_V <- df.triad_V %>%
  mutate(responses_theme = ifelse(responses == theme_match_V, 1, 0),
         language = "Vietnamese", 
         country = "Vietnam") %>%
  select(subject, rt, Cue_renamed, cue, top_opt, bottom_opt, 
         responses, responses_theme, country, language,
         tax_match_E, theme_match_E, tax_match_V, theme_match_V, tax_match_M, theme_match_M,
         tax_frequency_E, theme_frequency_E, tax_frequency_V, theme_frequency_V, tax_frequency_M, theme_frequency_M,
         tax_cosine_E, theme_cosine_E, tax_cosine_V, theme_cosine_V, tax_cosine_M, theme_cosine_M,
         tax_cosine_sim_E, theme_cosine_sim_E, tax_cosine_sim_V, theme_cosine_sim_V, tax_cosine_sim_M, theme_cosine_sim_M)

df.triad_M <- df.resp_M %>%
  filter(stim_type == "triad",
         responses != "NA")
triad_cues_M <- read.csv("../../data/corpus/cue_renamed_M.csv")
df.triad_M <- left_join(df.triad_M, triad_cues_M, by = c("cue", "top_opt", "bottom_opt"))
df.triad_M <- inner_join(df.triad_M, df.corpus, by = "Cue_renamed")

df.triad_M <- df.triad_M %>%
  mutate(responses_theme = ifelse(responses == theme_match_M, 1, 0),
         language = "Mandarin", 
         country = "China") %>%
  select(subject, rt, Cue_renamed, cue, top_opt, bottom_opt, 
         responses, responses_theme, country, language,
         tax_match_E, theme_match_E, tax_match_V, theme_match_V, tax_match_M, theme_match_M,
         tax_frequency_E, theme_frequency_E, tax_frequency_V, theme_frequency_V, tax_frequency_M, theme_frequency_M,
         tax_cosine_E, theme_cosine_E, tax_cosine_V, theme_cosine_V, tax_cosine_M, theme_cosine_M,
         tax_cosine_sim_E, theme_cosine_sim_E, tax_cosine_sim_V, theme_cosine_sim_V, tax_cosine_sim_M, theme_cosine_sim_M)

#calculate proportion for raw frequencies and cosine distance------
df <- rbind(df.triad_E, df.triad_V)
df <- rbind(df, df.triad_M) %>%
  mutate(theme_freq_prop_E = theme_frequency_E / (theme_frequency_E + tax_frequency_E),
         theme_freq_prop_V = theme_frequency_V / (theme_frequency_V + tax_frequency_V), 
         theme_freq_prop_M = theme_frequency_M / (theme_frequency_M + tax_frequency_M), 
         theme_cosine_prop_E = theme_cosine_E / (theme_cosine_E + tax_cosine_E),
         theme_cosine_prop_V = theme_cosine_V / (theme_cosine_V + tax_cosine_V), 
         theme_cosine_prop_M = theme_cosine_M / (theme_cosine_M + tax_cosine_M)) %>%
  rename(triad = Cue_renamed)

# write csv file -------
df_main_analysis <- df #keep a copy of df in case exploratory analysis changes it
write.csv(df_main_analysis, "../../data/data_USCNVN_ENZHVI.csv")
write.csv(triads_omit, "../../data/triads_omit.csv")
