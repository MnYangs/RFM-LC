clear 
close all;
%addpath('.\LC-master');

initialization;  %初始化vlfeat工具箱

%使用者自主选择需要匹配的图像对和对应的ground truth
[imagename1 imagepath1]=uigetfile('.\data\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
image_input1=imread(strcat(imagepath1,imagename1));    %选择第一幅图像
[imagename2 imagepath2]=uigetfile('.\data\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
image_input2=imread(strcat(imagepath2,imagename2));    %选择第二幅图像
[GTname2 GTpath2]=uigetfile('.\data\*.jpg;*.mat;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image');
load(strcat(GTpath2,GTname2));                         %选择ground truth

I1=image_input1;
I2=image_input2;

 
% I1=imread('.\data\123_l.jpg');
% I2=imread('.\data\123_r.jpg');
% correct_index = ['.\data\123.mat']; 

% I1=imread('.\data\84_l.jpg');
% I2=imread('.\data\84_r.jpg');
%correct_index = ['.\data\84.mat']; 

%load(correct_index);   

%我们算法的主要内容在函数LC_func中
[inliers_ind,prob_inlier,runtime,mainV,nc]=LC_func(X,Y);

if ~exist('CorrectIndex'), CorrectIndex = ind; end
[inlier_num,inlierRate,precision_rate,Recall_rate]=get_evaluate(X,CorrectIndex,inliers_ind);
fscore=2*precision_rate*Recall_rate/(precision_rate+Recall_rate);

[FP,FN] = matches_lines(I1, I2, X, Y, inliers_ind, CorrectIndex);%画出图像匹配特征点连线图
plot_vectors(I1,I2,X, Y, inliers_ind, CorrectIndex)%画出一般运动向量场
plot_mainV(mainV,nc);%画出估计运动向量场

disp(['Precision=' num2str(precision_rate) ', Recall=' num2str(Recall_rate) ', F-socre=' num2str(fscore)]);
disp(['Runtime=' num2str(runtime*1000) 'ms']);