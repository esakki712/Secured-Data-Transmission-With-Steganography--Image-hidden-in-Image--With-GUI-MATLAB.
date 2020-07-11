clc;
clear all;
close all;
clearvars;
A = imread("PVD_baboon.bmp");
B = imread("PVD_stego_image.bmp");
[peaksnr, snr] = psnr(B,A);
disp(peaksnr);
disp(snr);