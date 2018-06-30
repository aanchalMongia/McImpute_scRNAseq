
clear;  clc;
tic

data_dir='data/'%'D:/AanchalMongia_phdClg/Phd/DATA_SINGLE_CELL/'
addpath(genpath('Dependencies')); 
addpath(genpath('functions')); 

dataname='Usoskin'; 
  
 %% Data read
if(strcmp(dataname, 'Usoskin'))
    data=csvread([data_dir 'raw_data/' dataname '_raw_data.csv'],1,1)' ;
elseif(strcmp(dataname,'Mousebrain'))
  data=csvread([data_dir 'raw_data/' dataname '_raw_data.csv']);
else
   sample_dir = [data_dir 'raw_data/' dataname '_dataset/hg19'];
   [data, gene_names, gene_ids, cells] = read_raw_10x( strcmp(dataname,'Preimplantation') ,sample_dir);% 0 for jurkat,1 for zygote
end

%% CALL MCIMPUTE
[data_recovered,~,data_recovered_raw, gene_names]=call_mcImpute(data,'dataname',dataname);%,'gene_names',gene_names,'gene_ids', gene_ids,'pro_dir',pro_dir);

%% Save results
mkdir(['RecoveredMatrices/' dataname '_imputed']); 
save(['RecoveredMatrices/' dataname '_imputed/rec.mat'],'data_recovered') 
time_taken=toc 


rng(0);
actual_labels=eval(['get_numeric_labels_' dataname '( dataname , data_dir )']) ; 
list_ni=[]; list_mc=[];
for (i=1:100) 
loc=randperm(length(actual_labels),length(unique(actual_labels)));
load(['processedData/' dataname '_processed.mat']);
ari_ni=call_kmeans(processed_data,'PCA', loc ,actual_labels); list_ni=[list_ni ari_ni];      
ari_mc=call_kmeans(data_recovered,'PCA', loc ,actual_labels); list_mc=[list_mc ari_mc];
end
avg_ari_ni=mean(list_ni)
avg_ari_mc=mean(list_mc)
