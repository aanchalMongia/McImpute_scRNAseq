function [labels] = get_numeric_labels_usoskin()



data_dir='D:/AanchalMongia_phdClg/Phd/DATA_SINGLE_CELL/'

load([data_dir 'annotations/Usoskin_annotations.mat']);
gt_labels=anno;
save('Temp/usoskin_labelNames.mat','gt_labels');
keySet =   { 'NP','TH','NF','PEP'}; %cyan, red, blue, green
valueSet = [1,2,3,4];
mapi=containers.Map(keySet,valueSet); %access labels using map(gt{i})
labels=[];
for i=1:length(gt_labels)
labels=[labels;mapi(gt_labels{i})];
end



end

