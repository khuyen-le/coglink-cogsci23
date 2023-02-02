---
title: "Re-examining cross-cultural similarity judgments using language statistics"
bibliography: library.bib
csl: apa6.csl
document-params: "10pt, letterpaper"
header-includes:
  - \usepackage[utf8]{inputenc}
  - \usepackage[T1, T2A, T5]{fontenc}
  - \usepackage{kotex}
  - \usepackage{CJKutf8}
author-information: > 
    \author{{\large \bf Khuyen N. Le (knl005@ucsd.edu)}$^{1}$, {\large \bf Alexandra Carstensen (abc@ucsd.edu)}$^{1}$, \\ {\large \bf Shan Gao (shangaocog@gmail.com)$^2$}, {\large \bf Michael C. Frank (mcfrank@stanford.edu)$^3$},  \AND
    $^1$Department of Psychology, University of California, San Diego, $^2$Department of Psychology, University of Chicago, \\ $^3$Department of Psychology, Stanford University
    }
abstract: >
 Is “cow” more closely related to “grass” or to “chicken”? Speakers of different languages judge similarity in this context differently, but why? One possibility is that cultures co-varying with these languages induce differences in conceptualizations of similarity. Specifically, East Asian cultures may promote reasoning about thematic similarity, by which cow and grass are more related, whereas Western cultures may bias judgments toward taxonomic relations, like cow and chicken. We measure similarity judgments across the US, China, and Vietnam and replicate US-China cultural differences with Vietnam intermediate. We also show that word embedding models (fastText models for each language) are related to judgments within each country, suggesting a possible alternative interpretation of cross cultural differences. Perhaps notions of similarity are similar across contexts, but the statistics of the linguistic environment vary. 
    
keywords: >
    similarity; culture; language; semantics; lexical co-occurrence; variation; US; China; Vietnam
    
output: cogsci2016::cogsci_paper
#final-submission: \cogscifinalcopy
editor_options: 
  markdown: 
    wrap: sentence
---









# Introduction

<!-- By virtue of discrete words and grammatical features, language provides a categorical partition of our continuous experiences. -->

<!-- By measuring the similarity between words (as commonly done with lexical co-occurrence models), it may be possible to model the shape of similarity space in order to capture cross-linguistic and cross-cultural variation and provide a more general answer to the question of how language influences our conception of the world. -->

<!-- Taxonomic and thematic similarity provide a convenient entry point to broader debates about cross-linguistic and cross-cultural variation in notions of similarity. -->

<!-- Taxonomic categorization is based on the similarity of attributes, for example, similar perceptual properties, like shared color or shape, among objects. -->

<!-- In contrast, thematic categorization is based on causal, spatial, and temporal relationships among objects [@Markman1984]. -->

<!-- We constantly partition our continuous experience of the world into categories, but the way we organize these partitions can vary across cultures.-->

Many cognitive processes rely on similarity, from inference and generalization to analogy, mathematics, and science.
There is substantial consistency in human similarity reasoning, but also systematic variation across cultural and linguistic contexts.
In particular, there is considerable evidence showing that similarity reasoning in East Asian cultural contexts differs from that in Western cultures [e.g. @Nisbett2003b].
For example, in a triad task comparing preferences for taxonomic and thematic similarity (choose two out of three words that are most related to one another), @Ji2004 found that Chinese participants preferred thematic matching to a greater extent than European Americans.
In an image version of this task, Chinese children (9-10 years old) are also more likely to choose thematic matches compared to their American counterparts [@Chiu1972].
This cross-cultural difference is also observed in novel object categorization, with Chinese participants preferring to group by family resemblance across multiple features and Americans preferring a single-feature rule [@Norenzayan2002].
Across tasks, East Asian participants show a preference for thematic similarity based on causal, spatial, and temporal relationships while Western participants are more likely to make taxonomic matches based on the similarity of attributes, like shared color or shape, among objects [see @Markman1984 for a discussion of these types of similarity].

An influential perspective within cultural psychology links these differences in similarity judgment to tendencies toward analytic processing in Western cultures, and holistic processing in East Asian cultures [@Nisbett2003].
Analytic processing emphasizes rule-like relationships predicated on objects and their properties and, correspondingly, taxonomic similarity, while holistic processing emphasizes relations between objects and their context and therefor, thematic similarity.
In related work, East Asian participants show a higher level of sensitivity to context than their Western counterparts when reproducing drawings from memory [@Ji2000]; visually exploring naturalistic scenes [@Chua2005]; describing scenes [@Masuda2001]; and in explaining the causes of ambiguous behaviors [@Choi1999].
The consensus interpretation in this literature ascribes cross-cultural differences in similarity judgment to variation in the *conceptualization* of similarity -- with people from East Asian cultures relying on a more thematic notion of similarity than Westerners.

Alternatively, these judgments could be shaped by cross-cultural differences in the *input* to similarity judgment, that is, the statistics of the linguistic and/or physical environment as manifest in everyday experiences.
Perhaps when faced with the triad task, participants from all cultures follow the same process for conceptualizing similarity, but rely on language or culture-specific input to this process.
If we observe a difference in categorization between East Asian and Western participants, it could be that members of both groups use the same procedure (considering similarity that is influenced by both taxonomic and thematic relations), but that the input to this procedure differ between cultures, with East Asian participants exposed to more support for thematic similarity in their experience in comparison to their Western counterparts.
<!-- We might also expect that both conceptualization of similarity and input from experience play a role in driving cross-cultural differences -- East Asian participants may be exposed to more instances of thematic similarity, and prefer to conceptualize similarity as thematic to a greater extent than Westerners. -->

## Estimating variation in experience via language statistics

To determine whether varied input to similarity judgments can in part explain cross-cultural differences, we need a way to operationalize variation in exposure to thematic and taxonomic relations.
While exposure to types of similarity in everyday experience is difficult to measure, the statistics of language can provide a rough proxy.
Language statistics are useful in that they are part of the input to everyday experience -- and indeed, may afford many of the "experiences" that people have with infrequently encountered items, like cows or helicopters -- and they provide an accessible measure.
Previous work also suggests that language statistics, such as lexical co-occurrence or cosine distance of word embeddings, can be good predictors of similarity reasoning.
Semantic models that are constructed using lexical co-occurrence (in comparison to annotated relations) have been shown to perform well on predicting human judgments about similarity between word pairs that are thematically or taxonomically related [@Rohde2006].
Relatedly, a model trained on word-document co-occurrence can predict word association and the effects of semantic association on a variety of linguistic tasks [@Griffiths2007].
Word embeddings like word2vec, gloVe, and fastText have also been shown to be good predictors for similarity judgments [@Liu2019, @Jatnika2019, @asr2018].

Our study uses cosine distances of fastText word vectors as a measure of lexical co-occurrence.[^1]
fastText is a system that uses lexical co-occurrence information to generate a vector representing each word in its lexicon [@Mikolov2018].
Practically speaking, fastText vectors are available for many languages, and fastText has also been shown to be sensitive to cultural differences in word meanings: @Thompson2020 demonstrated that the distribution of semantic meaning clusters generated by fastText trained on language-specific corpora correlates with the cultural, historical, and geographical similarities of these languages.
<!-- This proof of concept provides support for our use of fastText in comparing different languages with varying levels of relatedness.-->

[^1]: With the preregistered exclusion criterion, all three corpora were significant predictors.

Language statistics may incorporate both cultural-specific environmental statistics, that is, the experiential *input* to similarity judgments, and culture-specific senses of similarity, the *conceptualization* of similarity.
For example, cultural features (like farming) can lead to differences in environmental statistics (seeing cows and grass) and these can influence language (talking more about cows and grass).
But other cultural features (like conceiving of similarity thematically) could also cause individuals to talk differently about the same experiences (mentioning what cows eat rather than what other animals cows are like).
Accordingly, our approach examines the extent to which language statistics can predict cross-cultural differences in similarity judgments with the understanding that language statistics are likely a proxy for both *input* to and *conceptualization* of similarity.

## The present study

<!-- @Ji2004 observed a difference in similarity judgment between Chinese and European Americans (the former preferred thematic matching the latter taxonomic). However, their evidence is not sufficient to conclude that it is culture that drives this difference, as their cross-cultural data is correlational. Furthermore, they have yet to rule out all mechanisms by which language could be relevant to the task. For example, their language manipulation (bilingual speakers from Mainland China making more taxonomic categorizations when tested in language) only points to an offline effect of language because it does not prevent participants from accessing linguistic representations. A stronger claim could have been made if verbal interference had been conducted, and if cross-cultural differences had remained. This would have been stronger in eliminating online effect of language as a potential cause for cross-cultural differences in similarity judgment.  -->

<!-- Additionally, outside of language, cross-cultural differences could come from a couple different mechanisms:  -->

```{=html}
<!--@Ji2004 suggest that the notion of similarity is what varies across cultural groups, but it is possible that similarity is regarded in the same way and it is actually the input to this similarity judgment that varies across cultural contexts.
It may be possible to gain traction on potential mechanisms by examining whether variation in similarity judgments co-vary with environmental statistics that differ across cultural and linguistic contexts.--
```
<!-- The present study tests whether the statistics of language can be used to predict cross-cultural differences in similarity judgments, and particularly, whether this approach provides additional insight beyond cross-cultural characterizations based on taxonomic vs thematic preferences. -->

We measured taxonomic versus thematic similarity matching in a forced-choice word triad task in three populations.
Following @Ji2004, we measured preferences in the US and China.
In addition, we collected data in a novel context: Vietnam.
Vietnam is a Southeast Asian country that borders China and has historically been greatly influenced by Chinese culture [@Hui2002].
Therefore, it serves as a suitable cultural context to investigate whether the claim made by @Ji2004 and previous studies -- that Eastern and Western cultures have different notions of similarity -- extends beyond mainland China.
In addition to these replication and extension questions, we tested whether fastText vectors from corpora corresponding to each language context (English, Mandarin, and Vietnamese) are good predictors for similarity judgments in each population.

This study is correlational and cannot evaluate causal relationships between environmental statistics and similarity judgments.
However, this work can inform potential mechanisms by examining whether similarity judgments co-vary with environmental statistics that differ across these contexts.

Our specific research questions are as follows:

1.  Do we replicate cross-cultural differences in similarity judgments between East Asian and Western cultures?

2.  Are these cross-cultural differences related to differences in language?

3.  Is our language model specific to items with a taxonomic-thematic contrast, or can it predict similarity more generally?

To preview our results, we replicate US-China differences and find that Vietnamese judgments are intermediate between these two.
We find that language-specific statistics provide good predictions for cross-cultural differences in similarity judgments, and additionally, for more general similarity judgments that do not contrast taxonomic and thematic matches.
Critically, the stimuli used to assess this more general case of similarity reasoning were constructed to be outside the scope of explanation for taxonomic-thematic accounts (for use as filler items).
While the language model may succeed in taxonomic-thematic similarity predictions by picking up on differences in the conceptualization of similarity that are reflected in language data, this conceptualization account provides no prediction for these filler stimuli.
<!-- Accordingly, these filler stimuli provide the strongest test of the language model, demonstrating that it can explain variation in similarity judgments beyond that explained by thematic or taxonomic conceptualizations of similarity.  -->

Taken together, our findings provide support for an alternative to previous accounts on which differing cultures induce differing conceptions of similarity.
On this alternative, language explains for culture-specific variation in similarity reasoning, both for taxonomic-thematic judgments and for judgments not attributable to these senses of similarity.
While these findings do not rule out other cross-cultural factors, they show it is possible to explain some cross-cultural variation in similarity judgments purely from language statistics.

# Methods











## Participants

Data collection and analyses for this study were pre-registered, and the pre-registration is available at [blinded for review].
We recruited 200 participants from the US, 200 from mainland China, and 199 from Vietnam.
All participants were recruited through snowball sampling, which, in the US was seeded with student email lists at a large university, in China (CN) with student groups on WeChat, and in Vietnam (VN) with Vietnam-based student groups on Facebook.
US participants were compensated with \$5 gift certificates (USD), CN participants received 25CNY through WeChat credit transfer, and VN participants received 50,000₫ (VND) in phone credit,

We excluded 8 US participants, 16 CN participants, and 62 VN participants, who missed two or more of the 11 attention check questions.

In doing so, we deviated from our preregistered exclusion criterion, which used a more stringent policy, excluding participants who missed any of the 10 attention checks.
This approach would have substantially reduced our sample size, disproportionately affecting the VN sample (resulting in a final sample of 109 US, 132 CN, and 57 VN participants).
We report results with the less stringent exclusion criterion, but we performed analyses with both samples and found broadly similar results.
Any differences are noted in the Results & Discussion section.

We also applied four demographic exclusion criteria designed to reduce cross-cultural influences across our samples: we excluded participants who (1) were not native speakers of the test language (English, Vietnamese, or Mandarin Chinese), (2) were fluent in another one of the study languages, (3) had lived outside of the test country for more than two years, or (4) had significant international experience (more than 6 international experiences of 2 days or longer).
Following our pre-registration, we dropped any exclusion criterion that would exclude 25% or more of any one population, but only for that population.
Specifically, we did not exclude VN and CN participants who spoke English, or US participants with significant international experience.
As a result of these demographic exclusions, we excluded 73 US, 35 CN, and 27 VN participants.
The final US sample included 119 participants (30M, 84F, 3 non-binary, 2 other), with mean age = 22.2 (SD = 8.15).
The CN sample included 149 participants (61M, 87F, 1 other), with mean age = 23.1 (SD = 3.65).
And the VN sample included 110 participants (34M, 71F, 5 other), with mean age = 22.21 (SD = 5.81).

<!-- [^4]: A table summarizing the number of participants omitted for each criterion is included in the Supplementary Information. -->

## Materials

All stimuli and scripts for the experiment and analysis are available at [blinded for review].
We collected and adapted stimuli from previous studies to create test triads consisting of a cue with one thematic and one taxonomic match option.
For example, "cow," "grass," and "chicken," where "cow" is the cue, "grass" is the thematic match, and "chicken" the taxonomic match.
We included 105 such triads, a superset including triads pulled from supplemental information and in-text examples across the literature, and others that we adapted or created <!--(see SI for the full list of stimuli and sources)-->.
We selected triads on the basis of cultural familiarity within the US, Vietnam, and China.
The triads were translated from English to Vietnamese and Mandarin by fluent bilingual speakers of each language, and back-translated to English by another fluent bilingual who was naive to the original English version.
The back-translations were checked against the original English to identify ambiguities in the translation, which were resolved through discussion and selection of alternative terms when relevant.

## Procedure

```{=tex}
\begin{CJK*}{UTF8}{gbsn}
Each participant completed all 105 triads in blocks of 21 trials at a time (10 test triads, 10 filler triads, and 1 attention check per page), by selecting the match most related to the cue. We elicited similarity match responses by asking "Which thing is most closely related to the bolded [cue] item?" In Mandarin Chinese, we used the phrasing for "most closely related" reported by Ji et al. (2004): "关联". And in Vietnamese, we translated this as "liên quan nhất".
The test triads were presented with 105 filler triads mixed in, to obscure the taxonomic-thematic two-answer forced choice structure of the test stimuli and reduce the likelihood that participants would become aware of the design.
The filler triads were groups of three semantically related words, but where the match options were not distinguished by thematic vs. taxonomic similarity, for example, the cue "bird" with match options "lizard" and "toad." Additionally, we included 11 attention check trials, which were formatted similarly to the test and filler triads but included an instruction instead of a cue item, e.g., "Choose wife" with match options "wife" and "husband." In total, each participant completed 210 similarity judgments (105 test triads and 105 fillers) and 11 attention check questions, with all items presented in randomized orders that varied between subjects.
\end{CJK*}
```
## Corpus model

<!-- Our general approach is to build a model of similarity that is based on collocation counts in each language.  -->

<!-- ### Raw lexical co-occurrences -->

<!-- To give an intuition for our model, consider the cow-grass-chicken triad: we counted how many times “cow” and “grass” co-occur within a window of text in each corpus, and compare this to how many times “cow” and “chicken” co-occur. Our similarity prediction is then proportional to the relative frequency of these pairs. For example, if the thematic cow-grass match accounts for 30% of collocations for this triad (with cow-chicken making up the other 70%), then our model predicts, correspondingly, that 30% of responses to the triad will be grass, and the other 70% chicken. We then use a mixed-effects regression to evaluate how well each corpus collocate model predicts participants’ similarity judgments, across triads and languages. -->

<!-- #### Collocate retrieval and coding -->

<!-- For our English co-occurrence metric, we used the online interface of the Corpus of Contemporary American English [@COCA] to retrieve collocation counts. We recorded the raw count of times that any cue-match pair (e.g., cow-grass or cow-chicken) co-occur in a window of 19 words, which is the maximum window size in the online interface, and closest to the sentence co-occurrence metric in our VI corpus collocation counts.  -->

<!-- To determine Vietnamese co-occurrence, we used the raw frequency of sentence co-occurrences from a subset of the Vietnamese corpus in the Leipzig Corpora Collection [@VICorpus]; this corpus includes 70 million Vietnamese sentences, but our corpus data comes from a 1 million sentence subset for which co-occurrence counts are available for download. Vietnamese makes very frequent use of compositional morphology but the written language  uses spacing to delineate syllable boundaries rather than word boundaries. Accordingly, collocate searches returned instances of both target terms and many morphologically related, but distinct, words. We included in our counts any instances of the target term or close semantic neighbors containing the same morpheme(s) as long as they entailed a likely literal reference to the target term. For example, our search for collocates of the term “gà” (chicken) also returned “gà mái,” a distinct word for female chickens. Despite being a different word, “gà mái” both includes the morpheme for “chicken” and entails reference to a chicken. Accordingly, instances of both “gà” and “gà mái” were included in our collocate count for “chicken.” Some compounds do not meet this criteria, and were excluded from collocate counts. For example “trái cây” (tree.fruits) includes the same syllable as the word “cây” (tree), but refers to fruit that comes from trees, not the trees themselves, and was therefore excluded from our collocate counts for “tree.” -->

<!-- Mandarin co-occurrence was collected using the online interface of the Chinese Lexical Association Database (Lin et al, 2019). Mandarin also makes frequent use of compositional morphology. To match the Vietnamese corpus statistics, we included in our counts any instances of the target term or close semantic neighbors containing the same morpheme(s) following the rule described above. These semantic neighbors were either suggested to us by the online interface (which gave search suggestions for words beginning with the target term as we typed them in) or suggested by a native speaker of Mandarin conducting the co-occurrence count data collection. For example, in getting the collocates of the term "門" (door), we also included "門兒" (also door, but is returned as a different word). Compounds that do not meet this criteria were excluded from collocate counts. For example "門牙" (door.tooth) refers to the front tooth even though it includes the same character as the target word "門" (door), so was therefore excluded from our collocate counts for "door". -->

<!-- #### Collocate similarity model -->

<!-- From the raw co-occurrence counts of each triad, we calculated the thematic co-occurrence ratio as the number of thematic co-occurrences over the sum of thematic and taxonomic co-occurrences. We did this for both the English and Vietnamese corpus co-occurrence counts. In this way, we obtained predictions for 73 of 105 triads from the Vietnamese corpus and 104 of 105 triads from English. We therefore limited all analyses reported here to the subset of triads for which our corpus-based model can make meaningful predictions, meaning triads that have at least one non-zero collocate count (either thematic or taxonomic match). We replaced any remaining zero collocate counts with $\epsilon$ to account for sparsity in the corpus data. We then tested whether these simple relative frequency models predict US and VN responding. -->

<!-- ### Cosine distance of word vectors -->

Our general approach is to predict behavioral preferences in similarity judgment using relative similarity between fastText word embeddings.

#### Word vector retrieval

We use the fastText pre-trained models of English, Mandarin, and Vietnamese in @Grave2018.
These models were trained on Common Crawl and Wikipedia using fastText and use character n-grams of length 5, and 10 negative examples.
The training used a Continuous Bag of Words with position-weights and a window of size 5.
From these models, we retrieve the word vectors (dimension 300) for each word in our triad and filler stimuli.

#### Similarity model

To give an intuition for our model, consider again the cow: grass/chicken triad.
We retrieved word vectors for "cow" and "grass", and calculated the cosine distance between these vectors.
We did the same for "cow" and "chicken." Our similarity prediction is inversely proportional to the ratio of cosine distance of these pairs.
This is because a larger cosine distance means the word vectors are further apart, and thus the words are less similar.
For example, if the cosine distance of thematic cow-grass is 0.7 and the cosine distance of taxonomic cow-chicken is 0.3 (the more similar of the two), then our model predicts, correspondingly, that 30% of responses to the triad will be grass, and the other 70% chicken.

We calculated the cosine distance between each cue-thematic match (thematic cosine distance) and cue-taxonomic match (taxonomic cosine distance).
<!-- , using the `spatial.distance.cosine` function from the SciPy package in R [@2020SciPy]. --> We then calculated the thematic cosine distance proportion as thematic cosine distance over the sum of taxonomic cosine distance and thematic cosine distance.
We followed this process for all three corpora, and were able to obtain predictions for all triads in all languages.
Then, we used a mixed-effects regression to evaluate how well each corpus model predicts participants' similarity judgments, across triads and cultural contexts.

# Results & Discussion

## 1. Replication of previous work and extension to a Vietnamese sample



In keeping with @Ji2004, we would expect participants from mainland China to prefer thematic matches more than US participants (e.g., to prefer the cow-grass match over cow-chicken to a greater extent than US participants).
On the basis of the previous literate more broadly, we would also expect participants from Vietnam to pattern with China, showing a stronger preference for thematic matches than US participants.

We observed the strongest preference for thematic matching in China (M = 0.65, SD = 0.11), followed by Vietnam (M = 0.6, SD = 0.11), and then the US (M = 0.56, SD = 0.17; see Figure 1).

\begin{CodeChunk}
\begin{figure}[tb]

{\centering \includegraphics{figs/unnamed-chunk-1-1} 

}

\caption[Proportion of thematic responses by country]{Proportion of thematic responses by country.}\label{fig:unnamed-chunk-1}
\end{figure}
\end{CodeChunk}

To test for differences in similarity judgment between the countries, we ran a mixed-effects logistic regression predicting triad match (taxonomic or thematic) with country (US, China, or Vietnam) as a fixed effect.
As random effects, we included an intercept per subject and one per triad, as well as by-triad random slopes for country to account for variation in the country effect across triads.

We found a significant effect of country ($\chi^2$(2) = 15.37, p < .001), but this effect is driven by the difference between US and CN responding ($\beta_{US}$ = -0.48, p < .001). There was no statistical difference between matching in Vietnam and China ($\beta_{Vietnam}$ = -0.22, p = 0.09), or the US and Vietnam ($\beta_{Vietnam}$ = 0.26, p = 0.086).

In sum, we replicated the differences documented by @Ji2004 between the US and China.
However, we did not find that Vietnamese participants grouped particularly with Chinese participants.
Instead they were intermediate between the two.
Accordingly, we did not find strong support for the hypothesis that there are overall biases toward thematic responding across Asian cultural contexts broadly.
<!-- However, in our corpus model comparison, we do find evidence for different, more fine-grained variation in similarity judgments between the US and Vietnam. -->

## 2. Language statistics as a predictor for cross-cultural variation in similarity judgments

In our next analysis, we tested whether triad-level differences in judgments across countries could be predicted from language statistics.

### Single corpus model

First, to test whether variation in language statistics can explain differences in similarity judgments, <!-- we compare logistic mixed-effects regression models fit to the thematic responding data from each country separately. --> <!-- We first ask how well each corpus model (English, Vietnamese, or Mandarin) predicts similarity judgments by speakers of the corresponding language (US, Vietnam, or China). --> <!-- To do this,  --> we use a mixed-effects logistic regression fit individually for each country.
Our models predicted responses by individual participants to particular triad (0=taxonomic or 1=thematic) with fastText predictions (proportion of cosine distance) as a fixed effect and participant and triad as random effects.
If language statistics contribute to the differences in similarity judgments, we would expect each language corpus to be a good predictor for similarity judgments in the corresponding population.









All corpora were significant predictors of all cultural context responding, with p \< 0.05 and $\beta$ from -8.69 to -2.4.
<!-- (For a full report, see Supplementary Information.) -->

### Multi-corpus model

If language statistics are able to predict meaningful culture-specific variation in similarity judgments (rather than just consistency across cultures), we would expect each corpus to be the best predictor of its corresponding culture compared to the other two corpora.
We directly compared the corpus models by including all three corpus predictors as fixed effects in three mixed-effect regressions (predicting US, VN, and CN responding) with the same random effects as above.



For US responding: only the English (EN) corpus was a significant predictor[\^2].
EN corpus: $\beta$ = -6.96, $\chi^2$(1) = 16.57, p < .001. VI corpus: $\beta$ = -2.22, $\chi^2$(1) = 3.73, p = 0.054. ZH corpus: $\beta$ = -3.18, $\chi^2$(1) = 3.37, p = 0.066.

For Vietnamese participants' responses, only the Vietnamese (VI) and Mandarin (ZH) corpora were significant predictors[^2].
EN corpus: $\beta$ = -2.98, $\chi^2$(1) = 2.58, p = 0.108. VI corpus: $\beta$ = -2.75, $\chi^2$(1) = 4.84, p = 0.028. ZH corpus: $\beta$ = -4.39, $\chi^2$(1) = 5.49, p = 0.019.

[^2]: With the preregistered exclusion criteria, all three corpora were significant predictors.

For responses by Chinese participants, only the Mandarin (ZH) and English (EN) corpus were significant predictors.
EN corpus: $\beta$ = -3.32, $\chi^2$(1) = 7.18, p = 0.007. VI corpus: $\beta$ = -1.59, $\chi^2$(1) = 3.63, p = 0.057. ZH corpus: $\beta$ = -5.31, $\chi^2$(1) = 17.69, p < .001.

We observed some language specificity in this analysis (Figure 2).
The English corpus was the best predictor for US responding, and the Mandarin corpus was the best predictor for Chinese responding.
While this is not the case with the Vietnamese corpus and Vietnamese participants' responding, the Vietnamese corpus was still a significant predictor for this responding.
These results support our hypothesis that specific language statistics can predict cross-cultural variation in similarity judgment.



\begin{CodeChunk}
\begin{figure}[tb]

{\centering \includegraphics{figs/coeffs_cos-1} 

}

\caption[Fixed effect sizes of each corpus lexical statistics (cosine distance proportion) when included as a predictor for China, Vietnam, and US responding, respectively]{Fixed effect sizes of each corpus lexical statistics (cosine distance proportion) when included as a predictor for China, Vietnam, and US responding, respectively. The English corpus is the best predictor for US response, and the Mandarin corpus is the best predictor for China response.}\label{fig:coeffs_cos}
\end{figure}
\end{CodeChunk}



However, in all cultural contexts, adding the other two corpora produced a significantly better fit than the identical model with only the corresponding corpus included as a predictor (US responses: $\chi^2$(2) = 7.93, p = 0.019; VN responses: $\chi^2$(2) = 13.72, p = 0.001; CN responses: $\chi^2$(2) = 10.56, p = 0.005). This analysis suggests that culture-specific input to similarity judgments (as proxied by language statistics) do not fully explain cross-cultural differences in similarity judgment, whether due to noise or sparsity in the estimates of language statistics or true additional variance picked up by embeddings from other corpora.

<!-- ## 3. Cultural context as a predictor for cross-cultural variation in similarity judgments -->

<!-- Our above models tested whether language statistics is a good predictor for similarity judgment. -->

<!-- As we noted above, language statistics can be a proxy of both inputs and conceptualization of similarity. -->

<!-- However, it is still an open question whether conceptualization of similarity itself has a unique contribution to similarity judgment (beyond its influence on language statistics). -->

<!-- To test this hypothesis, we operationalize cultural-specific conceptualization of similarity as country. -->

<!-- We then compare a model that includes country, corresponding corpus statistics and their interaction as fixed effects to a model with only the corresponding corpus statistics as the fixed effect. -->

<!-- If conceptualization of similarity has a unique contribution to similarity judgment, we should see that terms including country to be a significant predictor of responding. -->



<!-- ```{r country language interaction in raw co-occurrences, include = F} -->

<!-- fit.language = glmer(responses_theme ~ theme_freq_prop_corr_lang + (1 | subject) + (1 | triad),  -->

<!--           data = df %>% filter(!(triad %in% triads_omit)),   -->

<!--           family="binomial") -->

<!-- summary(fit.language) -->

<!-- fit.language.anova = Anova(fit.language, type = 3) -->

<!-- fit.language.anova -->

<!-- fit.country_language = glmer(responses_theme ~ theme_freq_prop_corr_lang * country + (1 | subject) + (1 | triad),  -->

<!--           data = df %>% filter(!(triad %in% triads_omit)),   -->

<!--           family="binomial") -->

<!-- summary(fit.country_language) -->

<!-- fit.country_language.anova = Anova(fit.country_language, type = 3) -->

<!-- fit.country_language.anova -->

<!-- fit.country_language_compare = anova(fit.language, fit.country_language, type = 3) -->

<!-- fit.country_language_compare -->

<!-- ``` -->



<!-- In the model containing only the corresponding corpus statistics, the corpus statistics is a significant predictor ($\beta$ = -1.79, $\chi^2$(1) = 75.58, p < .001). When adding country and interaction between country and corpus, corpus statistics ($\beta$ = -1.72, $\chi^2$(1) = 23.34, p < .001), country (F(2, \ensuremath{\infty{}}) = 13.18, $\chi^2$(2) = 7.39, p = 0.025), and interaction between country and corpus (F(2, \ensuremath{\infty{}}) = 6.66, $\chi^2$(2) = 13.33, p = 0.001), are significant predictors[^7]. Including the country and country-corpus terms to the language-only model significantly its ability to explain variation in responding ($\chi^2$(4) = 40.76, p < .001). This result points to a unique contribution by culture-specific ways of conceptualizing similarity to similarity judgment that is not captured in language statistics. -->

<!-- [^7]: With preregistered exclusion criterion: only corpus statistics and interaction between country and corpus are significant predictors. -->

## 3. Language statistics as a predictor for non-structured filler items

One possible concern with our approach is that our models are only able to account for variation in similarity judgments because the word embedding models pick up on cross-cultural differences in the conceptualization of similarity.
Perhaps some aspect of the geometry of the embedding space specifically reflects these differences rather than capturing more item-specific patterns of co-occurrence.

If this is the case, the embedding models should be less accurate at predicting responding for filler items (such as whether "tomorrow" or "yesterday" is more related to "today") because these items do not have a thematic/taxonomic structure.
Additionally, even when one option might be more related to the cue, that relationship is not systematic throughout the set of fillers.
Alternatively, if the embedding models capture similarity judgments more generally (beyond thematic/taxonomic preferences), they should predict judgments for the unstructured filler items as well as they do for our experimental items.









For each filler triad, we randomly assigned one of the responding options as 'Word1'.
Running a mixed-effects logistic regression to predict responding (Word1 or Word2) with country as a fixed effect and a random effect structure as above in Question 1, we found no effect of country on filler responding ($\chi^2$(2) = 0.74, p = 0.692).

<!-- #### Raw co-occurrences -->

<!-- ```{r US responding predicted by each corpus model raw co-occurrences for fillers, warning=FALSE,include = F} -->

<!-- # English  -->

<!-- fit.EN_US_filler = glmer(responses_word1 ~ word1_match_frequency_prop_E + (1 | subject) + (1 | cue),  -->

<!--           data = df.filler %>% filter(country == "US",  -->

<!--                                !(cue_id %in% fillers_omit)),  -->

<!--           family="binomial") -->

<!-- summary(fit.EN_US_filler) -->

<!-- fit.EN_US_filler.anova = Anova(fit.EN_US_filler, type = 3) -->

<!-- fit.EN_US_filler.anova -->

<!-- ``` -->

<!-- ```{r VN responding predicted by each corpus model raw co-occurrences for fillers, warning=FALSE, include = F} -->

<!-- # Vietnamese -->

<!-- fit.VI_VN_filler = glmer(responses_word1 ~ word1_match_frequency_prop_V + (1 | subject) + (1 | cue),  -->

<!--           data = df.filler %>% filter(country == "Vietnam",  -->

<!--                                !(cue_id %in% fillers_omit)),  -->

<!--           family="binomial") -->

<!-- summary(fit.VI_VN_filler) -->

<!-- fit.VI_VN_filler.anova = Anova(fit.VI_VN_filler, type = 3) -->

<!-- fit.VI_VN_filler.anova -->

<!-- ``` -->

<!-- Yes, corpus raw co-occurrences predicts responding for both US and Vietnamese. *need to discuss with Shan to incorporate Mandarin due to a lot of empty counts* -->

<!-- #### Cosine distance -->









Using the same mixed-effects logistic regression structure as the single corpus models in Question 2, we predicted responses (1=word1 or 0=word2) in each cultural context with the corresponding corpus predictor as a fixed effect, and participant and triad as random effects.
In all cultural contexts, the corresponding corpus was a significant predictor of responding, with p \< 0.05 and $\beta$ from -9.59 to -3.14.
<!-- (For a full report, see Supplementary Information.)  --> These results show that the word embedding models predict general similarity in addition to structured thematic/taxonomic similarity.





To investigate whether language statistics predict taxonomic/thematic triads and filler items differently, we compared the variance accounted for by the models of the two different types of items.
We ran two mixed-effects logistic regression models that predict responding across cultural contexts (1=thematic or word1, 0=taxonomic or word2), with the corresponding corpus predictor as a fixed effect and participant and item as random effects.
Consistent with our results above, the corresponding corpus was a significant predictor for responding to both triads and filler items (triads: $\beta$ = -1.79, $\chi^2$(1) = 75.58, p < .001, fillers: $\beta$ = -2, $\chi^2$(1) = 70.89, p < .001). Importantly, we found comparable conditional $R^2$ values when the corresponding corpus was used to predict only triad items ($R^2$ = 0.3) and only filler items ($R^2$ = 0.26). This result provides evidence for our view that word embeddings index general tendencies in similarity judgment, beyond a specific dimension of thematic/taxonomic relations.

# General Discussion

Do members of different cultures vary in their conceptualization of similarity?
Cross-cultural differences in similarity judgment would seem to suggest this conclusion.
In this paper, we consider whether statistics of the environment (as indexed by language statistics) can account for cross-cultural differences in a classic similarity judgment paradigm.
We replicated the previously documented contrast between English speakers in the US and Mandarin Chinese speakers from East Asia (mainland China, Taiwan, Hong Kong, and Singapore): Chinese participants preferred thematic relations to a greater extent compared to US participants.
Our sample of Vietnamese participants showed an intermediate preference but were not significantly different from either Chinese or US participants.
This finding suggests some limitations on the generality of the cultural account, which proposes that thematic/taxonomic similarity preferences align with East Asian and Western tendencies toward holistic and analytic processing, respectively.

In contrast, we found some support for the environmental statistics account: word embeddings based on language-specific corpora were a good predictor for the corresponding country's similarity judgments, even when other corpus statistics were included, and even for filler triads without a thematic/taxonomic structure.
<!-- However, we also found that culture-based conceptualization of similarity uniquely contributes to predicting similarity judgment when included in a model with corpus statistics. --> Overall, our results provide evidence that cross-cultural differences in similarity judgments are related to patterns in linguistic statistics (which also vary across cultures).

There are some important limitations of our approach.
While we discuss cross-cultural variability at the level of countries or larger world areas, these are not cultural monoliths.
For convenience, we operationalize culture at the level of country, based on where participants were raised and had lived for the large majority of their lives.
It is an open question whether performance in our participant populations (of relatively young and well-educated adults) is representative of the broader country.
This is especially true for societies with substantial ethnic and cultural variation such as the US.
We expect that our data is likely to underestimate variation both within and between the countries we sample from.

Additionally, language, culture, cognition, and individual experiences are intertwined in complex causal relationships.
In this study, we measure language and its relation to cross-cultural differences in categorization, but these relations test only the plausibility of a language-based account; they cannot establish the direction of causality.

@Ji2004 established that culture-aligned differences in this paradigm exist, even when the test language is held constant, concluding that "it is culture (independent of the testing language) that led to different grouping styles" in their study.
Our data provide a cautionary note to this conclusion, suggesting that while cultural differences in similarity judgment exists, we might get better traction on modelling cross-cultural variation through environmental statistics such as lexical co-occurrences.

There are still many open questions for this account, however.
Our operationalization of environmental statistics with word embeddings likely captures both language inputs and culture-specific conceptualization of similarity.
Further investigation of the semantic spaces captured by cross-cultural word embedding models is required.
Future work should also aim to provide a more specific computational account of how lexical co-occurrence might guide categorization preference beyond the simple proportion-of-similarity model tested here, and investigate other individual- or triad-specific factors that might influence how environmental statistics affect similarity judgment.

Despite these caveats, our findings here demonstrate the plausibility of an alternative perspective on cross-cultural accounts of similarity in the case of taxonomic and thematic reasoning.
It may be the input to similarity judgments, rather than the evaluative process or the conceptualization of similarity that produces variation in similarity reasoning across cultural and linguistic contexts.
We hope this work provides a foundation for further research probing this question.

# Acknowledgements

Blinded for review.

# References



```{=tex}
\setlength{\parindent}{-0.1in} 
\setlength{\leftskip}{0.125in}
```
\noindent

\newpage
