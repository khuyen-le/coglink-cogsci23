# Heading 1 
## Initial Data
1. Responding: .csv files generated from corresponding preprocessing.Rmd
    * US: data_E_0319.csv
    * China: data_M_0530.csv
    * Vietnam: data_V_0530.csv
2. Corpus: .csv files generated from .... //TODO. 
    * English: corpusE_cos.csv
    * Mandarin: corpusM_cos.csv
    * Vietnamese: corpusV_cos.csv

## Processed data
1. Responding data with exclusion. Use preregistered exclusion criteria. File name format: data[]_excl.csv
    * US: run respondingUS.Rmd
    * China: run respondingCN.Rmd
    * Vietnam: run respondingVN.Rmd

## Combine responding and corpus data
Run generate_full_data.Rmd

### Run analysis
Run analysis.Rmd

