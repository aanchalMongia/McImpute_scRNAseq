# mcImpute
## A matlab tool for imputation of scRNA-seq data 

Click [here](www.google.com) for paper.

#### Implementation
McImpute takes raw gene expression Data (cells x genes) as input. It pre-processed the data (see paper for detailed steps) and applies nuclear norm minimization to recover the full expression data, filling in the dropouts. 

Code:
> run.m
