clc; clear; close all; 

H = imread('bay.jpg'); %图像应该是灰度图；注意，初始读入的是utf-8类型的矩阵
H = im2double(H); %换成double类型
figure; subplot(1, 2, 1); imshow(H); 

[M, N] = size(H); 

[counts, x] = imhist(H); %imhist对图像直方图进行统计，其中count是每个灰度值得个数，x代表灰度值。一般的，x=1:256

location = find(counts ~= 0); %找到所有像素个数不为0的灰度级

MinCDF = min(counts(location)); %找到包含个数最少的灰度级

for j = 1:length(location)

    CDF = sum(counts(location(1:j))); %计算各个灰度级像素个数累计分布

    P = find(H==x(location(j))); %找到图像中等于某个灰度级所有像素点所在位置 

    H(P) = (CDF-MinCDF) / (M*N-MinCDF); %利用灰度换算公式，修改所有位置上的像素值

end

subplot(1,2,2); imshow(H);
