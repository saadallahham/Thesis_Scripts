
clear all;
close all;
clc;


%% Loading the well logs:

% ========================================================================

%%% this process for each well that will use %%%

% Create final data table for all wells
T = readtable('Well_all_final.csv');

W_x_1 = (T.WELL=="W_x_1");
trainingData = T(W_x_1,:);

W_x_2 = (T.WELL=="W_x_2");
x_2 = T(W_x_2,:);

W_x_3 = (T.WELL=="W_x_3");
x_3 = T(W_x_3,:);

W_x_4 = (T.WELL=="W_x_4");
x_4 = T(W_x_4,:);

W_x_5 = (T.WELL=="W_x_5");
x_5 = T(W_x_5,:);




