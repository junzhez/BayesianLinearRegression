close all;
clear all;

w_o = [1, 2];

X = -1:0.01:1;

X = [ones(1, 201);X];

s_prev = eye(2, 2);

m_prev = [0;0];

len = 10;

X_sample = zeros(2, len);
t = zeros(1, len);

for i = 1 : len
    X_sample_tmp = [1 ; -1 + 2 * rand(1, 1)];

    X_sample(:, i) = X_sample_tmp;

    e_sample = 0.2 * randn(1, 1);

    t(i) = (w_o * X_sample(:,i)) + e_sample;

    s_n = pinv(pinv(s_prev) + 25 * X_sample(:,i) * X_sample(:,i)');

    m_n = s_n * (pinv(s_prev) * m_prev + 25 * X_sample(:,i) * t(i)');
    
    pred_s = (1/25*eye(201,201) + X' * s_n * X);
    
    pred_m = m_n' * X;

    t_pred = mvnrnd(pred_m, pred_s, 10000);

    m_t_pred = mean(t_pred);
    
    s_t_pred = std(t_pred);

    figure(i);
    
    plot(X_sample(2,1:i), t(1:i), 'ro');
    
    hold on;
    
    errorbar(X(2,:), m_t_pred, s_t_pred);

    hold on;
    
    s_prev = s_n;
    m_prev = m_n;
end
