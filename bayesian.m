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
    % Add new sampled point
    X_sample_tmp = [1 ; -1 + 2 * rand(1, 1)];

    X_sample(:, i) = X_sample_tmp;

    e_sample = 0.2 * randn(1, 1);

    t(i) = (w_o * X_sample(:,i)) + e_sample;

    % Update m_N and S_N for p(w|t) = N(w|m_N, S_N)
    s_n = pinv(pinv(s_prev) + 25 * X_sample(:,i) * X_sample(:,i)');

    m_n = s_n * (pinv(s_prev) * m_prev + 25 * X_sample(:,i) * t(i)');

    % Sample 5 weight w, with updated prob model
    w_learned = mvnrnd(m_n, s_n, 5);

    Y = (w_learned * X);

    figure(i);
    
    plot(X_sample(2,1:i), t(1:i), 'ro');
    
    hold on;
    
    plot(repmat(X(2,:)', 1, 5), Y', 'b-');

    hold on;
    
    s_prev = s_n;
    m_prev = m_n;
end
