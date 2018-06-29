
function [ labels , gt_labels ] = get_numeric_labels_mouseBrain( n  )
%GET_NUMERIC_LABELS_MOUSEBRAIN Summary of this function goes here
%   Detailed explanation goes here

data_dir='D:/AanchalMongia_phdClg/Phd/DATA_SINGLE_CELL/'
fid=fopen([data_dir 'annotations/MouseBrain_labels_sorted.csv']);
gt=textscan(fid,'%s%s','Delimiter',',');
gt_labels=gt{1};
if n==7
gt_labels(find(strcmp(gt_labels,'unannotated')))=[];
gt_labels(find(strcmp(gt_labels,'purple')))=[];

end
if n==5
gt_labels(find(strcmp(gt_labels,'unannotated')))=[];
gt_labels(find(strcmp(gt_labels,'purple')))=[];
gt_labels(find(strcmp(gt_labels,'OPC')))=[];
gt_labels(find(strcmp(gt_labels,'Newly formed Oligodendrocyte')))=[];

end

%save('data/data_RAW/data_mouseBrain/labelNames_5labels.mat','gt_labels')
keySet =   { 'Astrocyte','Endothelial','Microglia','Myelinating Oligodendrocyte', 'Neurons','Newly formed Oligodendrocyte', 'OPC','purple','unannotated'};
% cyan red blue green black pink brown
valueSet = [1,2,3,4,5,6,7,8,9];
mapi=containers.Map(keySet,valueSet); %access labels using map(gt{i})
labels=[];
for i=1:length(gt_labels)
labels=[labels;mapi(gt_labels{i})];
end

if n==7 
labels(find(labels==9))=[];
labels(find(labels==8))=[];
end

if n==5
labels(find(labels==9))=[];
labels(find(labels==8))=[];
labels(find(labels==7))=[];
labels(find(labels==6))=[];
end


end

