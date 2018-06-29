function [processed_data] = scimpute_processing(dataname, raw_count)
%PROCESS Summary of this function goes here
%   Detailed explanation goes here


% Lib size normalization
totalCounts_by_cell  = sum(raw_count,2);
save(['Temp/' dataname 'scimputeProcessing_totalCellCounts.mat'],'totalCounts_by_cell');
totalCounts_by_cell(totalCounts_by_cell == 0) = 1;
normed_data = bsxfun(@rdivide, raw_count, totalCounts_by_cell/10^6);

% Log transform
processed_data = log10(1.01+normed_data);

end

