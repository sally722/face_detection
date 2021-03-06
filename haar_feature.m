close all;
fclose all;
clc;
clear;
dbstop error;

filepath='C:\Users\Bingqing\Documents\GitHub\face_detection\Profile Face Images\profile_images1\air-force.1.pgm';

img=int32(imread(filepath));
[n_row, n_col]=size(img);
figure(1);imagesc(img);colormap('gray');hold on;

img_int=zeros(size(img));
img_int(1,1)=img(1,1);
for i=2:n_row
    img_int(i,1)=img_int(i-1,1)+img(i,1);
end
for j=2:n_col
    img_int(1,j)=img_int(1,j-1)+img(1,j);
end
for i=2:n_row
    for j=2:n_col
        img_int(i,j)=img_int(i,j-1)+img_int(i-1,j)-img_int(i-1,j-1)+img(i,j);
    end
end
figure(2); imagesc(img_int); colormap('gray');hold on;

scale_i_array=[8 16 32];
scale_j_array=[8 16 32];

row_idx=33:16:n_row-33;
col_idx=33:16:n_col-33;
n_block_row=length(row_idx);
n_block_col=length(col_idx);

feature=zeros(length(scale_i_array)*length(scale_i_array)*4,...
    n_block_row*n_block_col);
for i=1:length(row_idx)
    for j=1:length(col_idx)
        feature(:,(i-1)*length(col_idx)+j)=feature_extract(img_int,... 
            [row_idx(i),col_idx(j)], scale_i_array, scale_j_array);
    end
end
figure(3);imagesc(feature);

groundtruth=-ones(1,n_block_row*n_block_col);

num_feature=size(feature,1);
theta=ones(1+num_feature+(num_feature+1)*num_feature/2+2*num_feature,1);
loglh=loglikelihood(theta,feature,groundtruth,n_block_row, n_block_col)
