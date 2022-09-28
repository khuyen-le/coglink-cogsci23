# Public Data and Analysis
In order to replicate analysis, please follow the following steps. 

## 0. Getting collated raw data
This project contains 2 types of raw data: responding data (from participants) and corpus data (from language corpora and fastText).

1. Responding:
These .csv files are generated from the raw, individualized data with the corresponding R script in `code/0_preprocessing`. Note that the individualized data was not made available for privacy reasons (meaning, you should not need to rerun any scripts in 0_preprocessing).
    * US: `data/responding/data_US.csv`
    * China: `data/responding/data_CN.csv`
    * Vietnam: `data/responding/data_VN.csv`

2. Corpus: 
These .csv files include the lexical co-occurrence value and cosine similarities score for each pair in each triad. 
The English lexical co-occurrence values are collected from [COCA collocates](https://www.english-corpora.org/coca/), the Vietnamese lexical co-occurrence values from the [Leipzig Corpora Collection](https://wortschatz.uni-leipzig.de/en/download/Vietnamese#vie_mixed_2014), and the Mandarin lexical co-occcurrence values are from [CLAD](http://www.chinesereadability.net/LexicalAssociation/CLAD/).
The cosine similarities score are calculated from fastText vectors per the python script at `code/0_corpus/fasttext_cosine.ipynb`. The actual fastText models are not included due to size, but are accessible following [instructions here](https://fasttext.cc/docs/en/crawl-vectors.html). We used the vectors in their original dimension of 300. 
Similar to the responding .csv files, you should not need to rerun any scripts.
    * English: `data/corpus/corpusE.csv`
    * Mandarin: `data/corpus/corpusM.csv`
    * Vietnamese: `data/corpus/corpusV.csv`

## 1. Processing responding data with exclusion
Using preregistered exclusion criteria. The resulting files will be in `data`.
    * US: Run `code/1_exclusions/1_exclusionsUS.Rmd`. Resulting file: `data/dataUS_excl.csv`
    * China: Run `code/1_exclusions/1_exclusionsCN.Rmd`. Resulting file: `data/dataCN_excl.csv`
    * Vietnam: Run `code/1_exclusions/1_exclusionsVN.Rmd`. Resulting file: `data/dataVN_excl.csv`

## 2. Combining responding and corpus data
Run `code/2_combine/2_combine.Rmd`. Resulting file: `data/data_USCNVN_ENZHVI.csv`.

## 3. Running reported analysis (including demographics)
Run `code/3_analysis/3_analysis.Rmd`.