# mcImpute
## A matlab tool for imputation of scRNA-seq data 

Click [here](www.google.com) for paper.

### Brief Description
McImpute takes raw gene expression Data (cells x genes) as input. It pre-processed the data (see paper for detailed steps) and applies nuclear norm minimization to recover the full expression data, filling in the dropouts. 

### Implementation
Running the script would read the count matrix, processes it, call mcImpute and place the recovered matrices in a folder 'RecoveredMatrices'
> run.m

### Testing

Fix seed for reproducibility
> rng(0);

Get annotations (single cell types)
>actual_labels=eval(['get_numeric_labels_' dataname '( dataname , data_dir )']) ; 

Run kmeans on after applying PCA on scRNA0-seq data
> list_ni=[]; list_mc=[];

> for (i=1:100) 

>   loc=randperm(length(actual_labels),length(unique(actual_labels)));

>   load(['processedData/' dataname '_processed.mat']);
>   ari_ni=call_kmeans(processed_data,'PCA', loc ,actual_labels); list_ni=[list_ni ari_ni];      
>   ari_mc=call_kmeans(data_recovered,'PCA', loc ,actual_labels); list_mc=[list_mc ari_mc];
> end
> avg_ari_ni=mean(list_ni)
> avg_ari_mc=mean(list_mc)
