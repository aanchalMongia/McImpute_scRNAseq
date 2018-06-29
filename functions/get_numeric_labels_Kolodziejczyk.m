function [labels] = get_numeric_labels_Kolodziejczyk()



data_dir='D:/AanchalMongia_phdClg/Phd/DATA_SINGLE_CELL/'

load([data_dir 'annotations/Kolodziejczyk_annotations.mat']); %anno=csvread([data_dir 'annotations/Kolodziejczyk_annotations.csv']);
gt_labels=anno;
keySet =   { '2i','a2i','lif'};
valueSet = [1,2,3];
mapi=containers.Map(keySet,valueSet); %access labels using map(gt{i})
labels=[];
for i=1:length(gt_labels)
labels=[labels;mapi(gt_labels{i})];
end



end


