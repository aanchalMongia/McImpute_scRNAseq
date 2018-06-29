function [cts, corr_vector1,corr_vector2,corr_vector3] = call_cts(X,anno, L1,L2, ncells2pick)


ind=find(anno==L1);
A=X(ind,:);             %cellIndices=randperm(size(A,1),ncells2pick); A=A(cellIndices,:);
pair_corr=corr(A','type','Spearman');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
corr_vector(isnan(corr_vector))=[];
%kde(corr_vector); hold on;
corr_vector1=corr_vector;
m1=median(corr_vector)



ind=find(anno==L2);
A=X(ind,:);                %cellIndices=randperm(size(A,1),ncells2pick); A=A(cellIndices,:);
pair_corr=corr(A','type','Spearman');
mask = tril(true(size(pair_corr)),-1);% Use mask to select lower triangular elements from input array
corr_vector = pair_corr(mask);
corr_vector(isnan(corr_vector))=[];
%kde(corr_vector); hold on;
corr_vector2=corr_vector;
m2=median(corr_vector)


m_intra=(m1+m2)/2;

ind1=find(anno==L1);%2-3, 3-6, 3-8
ind2=find(anno==L2);
A=X(ind1 ,:);           %cellIndices=randperm(size(A,1),ncells2pick); A=A(cellIndices,:);
B=X(ind2 ,:);           %cellIndices=randperm(size(B,1),ncells2pick); B=B(cellIndices,:);
pair_corr=corr(A',B','type','Spearman');
corr_vector=pair_corr(:);
corr_vector(isnan(corr_vector))=[];
%kde(corr_vector); hold on;
corr_vector3=corr_vector;
m_inter=median(corr_vector)


cts=m_intra-m_inter;
vec=[m1;m2;m_inter;cts]
%kde(c); hold on;

end

