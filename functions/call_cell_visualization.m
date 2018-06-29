function [ output_args ] = call_cell_visualization( dataX,  actual_labels )
%CALL_CELL_VISUALIZATION Summary of this function goes here
%   Detailed explanation goes here


data_dir='D:/AanchalMongia_phdClg/Phd/DATA_SINGLE_CELL/'
title_fontsize=20;
label_fontsize=20;

colorPalette=getColorPalette();

[mapped_data, mapping] = compute_mapping(dataX, 'PCA',10);
[mapped_data, mapping] = compute_mapping(mapped_data, 'tSNE',2)

load([ data_dir 'annotations/Mousebrain_labelNames_7labels.mat'])
load('Temp/usoskin_labelNames.mat');
data1=gscatter(mapped_data(:,1),mapped_data(:,2),actual_labels,colorPalette,[],10,'off'); %10 marker size

%chek order
%l=unique(gt_labels);lgnd=legend(l{1},l{2},l{3},l{4},l{5},l{6},l{7}); lgnd.FontSize=50

xlabel('tSNE 1','FontSize',label_fontsize)
ylabel('tSNE 2','FontSize',label_fontsize)

%title('KNN accuracy=87.50%, SVM accuracy=89.29%')
%xlim([-250 250]); ylim([-150 150]); 
%xlim([-20 20]); ylim([-30 30]); 
%xlim([-25 25]); ylim([-40 40]); 
%legend({'','','','','','','',''},'Location','bestoutside')
%acc_noImp=trainClassifier_svm(dataX,actual_labels)



end



function [accuracy]=trainClassifier_svm(mapped_data,actual_labels)
nsamples=size(mapped_data,1);
indices=randperm(nsamples); 
tr_indices= indices(1:round(0.8*nsamples));
te_indices= indices((1+round(0.8*nsamples)):end);
tr_coordinates=mapped_data(tr_indices,:);
tr_labels=actual_labels(tr_indices);
te_coordinates=mapped_data(te_indices,:);
te_labels=actual_labels(te_indices);

t = templateSVM('Standardize',1)%'Standardize',1,,'KernelFunction','rbf'
mdl=fitcecoc(tr_coordinates,tr_labels,'Learners',t  ); %
%%%%%CVmdl = crossval(mdl);
%KNN=fitcknn(tr_coordinates,tr_labels);
%%gen_err=kfoldLoss(CVmdl);
pred=predict(mdl,te_coordinates);
accuracy=length(find(pred==te_labels))/length(te_labels)

end

function [accuracy]=trainClassifier(mapped_data,actual_labels)

nsamples=size(mapped_data,1);
indices=randperm(nsamples); 
tr_indices= indices(1:round(0.8*nsamples));
te_indices= indices((1+round(0.8*nsamples)):end);
tr_coordinates=mapped_data(tr_indices,:);
tr_labels=actual_labels(tr_indices);
te_coordinates=mapped_data(te_indices,:);
te_labels=actual_labels(te_indices);
KNN=fitcknn(tr_coordinates,tr_labels);
pred=predict(KNN,te_coordinates);
accuracy=length(find(pred==te_labels))/length(te_labels)

end

function [ myColors ] = getColorsFrom8Labels( actual_labels)

myColors = zeros(size(actual_labels, 1), 3); % List of rgb colors for every data point.
myColors(actual_labels==1,1) = 0;
myColors(actual_labels==1,2) = 0;
myColors(actual_labels==1,3) = 1;

myColors(actual_labels==2,1) = 0;
myColors(actual_labels==2,2) = 1;
myColors(actual_labels==2,3) = 0;

myColors(actual_labels==3,1) = 0;
myColors(actual_labels==3,2) = 1;
myColors(actual_labels==3,3) = 1;

myColors(actual_labels==4,1) = 1;
myColors(actual_labels==4,2) = 0;
myColors(actual_labels==4,3) = 0;

myColors(actual_labels==5,1) = 1;
myColors(actual_labels==5,2) = 0;
myColors(actual_labels==5,3) = 1;

myColors(actual_labels==6,1) = 1;
myColors(actual_labels==6,2) = 1;
myColors(actual_labels==6,3) = 0;

myColors(actual_labels==7,1) = 128/255; %maroon
myColors(actual_labels==7,2) = 0;
myColors(actual_labels==7,3) = 0;

myColors(actual_labels==8,1) = 0; %purple
myColors(actual_labels==8,2) = 0;
myColors(actual_labels==8,3) = 1;
myColors(actual_labels==1,1) = 255/255; %pink
myColors(actual_labels==1,2) = 192/255;
myColors(actual_labels==1,3) = 203/255;
end

function [c]=getColorPalette()
c=zeros(8,3);
c(1,:)=[0 1 1];%red
c(2,:)=[1,0,0]%green 
c(3,:)=[0,0,1]%blue
c(4,:)=[0,1,0] %cyan
c(5,:)=[0,0,0]%magenta
c(6,:)=[1,0,1]%black
c(7,:)=[128/255,0,0]% grey
c(8,:)=[255/255,192/255,203/255]%mustard


end

