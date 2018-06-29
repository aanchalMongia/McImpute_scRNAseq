function [ labels ] = get_numeric_labels( )
%GET_NUMERIC_LABELS Summary of this function goes here
%   Detailed explanation goes here

data_dir='D:/AanchalMongia_phdClg/Phd/DATA_SINGLE_CELL/'
fid=fopen([data_dir 'annotations/zygote_annotations.csv']);
gt=textscan(fid,'%s','Delimiter',',');
gt_labels=gt{1};
keySet =   { '16cell','4cell','8cell','BXC', 'C57twocell','early2cell', 'earlyblast','fibroblast','late2cell','lateblast','mid2cell','midblast','zygote'};
valueSet = [1,2,3,4,5,6,7,8,9,10,11,12,13];
mapi=containers.Map(keySet,valueSet); %access labels using map(gt{i})
labels=[];
for i=1:length(gt_labels)
labels=[labels;mapi(gt_labels{i})];
end

end

