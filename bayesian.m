close all;
clear all;

w_o = [1, 2];

X = -1:0.01:1;

X = [ones(1, 201);X];

e = 0.004 * randn(10000, 201);

w = randn(10000, 2);

Y = (w * X) + e;

m_y = mean(Y);
std_y = std(Y);

errorbar(X(2,:), m_y, std_y);

X_sample = -1 + 2 * rand(1, 10);

X_sample = [ones(1, 10); X_sample];

e_sample = 0.004 * randn(1, 10);

t = (w_o * X_sample) + e_sample;