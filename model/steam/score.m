clc; clear
'steam';

figure
s1 = subplot(1, 2, 1);
load data/param_h_random.mat
angerness = 1:0.01:1.2;
balance_alpha = [1, 1.25, 1.5, 1.75, 2];
hold(s1, 'on')
for alpha = balance_alpha
    scores = arrayfun(@(x) scoring(x, p_h, lambda_h, alpha), angerness);
    plot(angerness, scores)
end
legend(cellfun(@(f) num2str(f), mat2cell(balance_alpha', ones(numel(balance_alpha), 1)), 'UniformOutput', false))

s2 = subplot(1, 2, 2);
load data/param_h_decrease.mat
angerness = 1:0.01:1.2;
balance_alpha = [1, 1.25, 1.5, 1.75, 2];
hold(s2, 'on')
for alpha = balance_alpha
    scores = arrayfun(@(x) scoring(x, p_h, lambda_h, alpha), angerness);
    plot(angerness, scores)
end
legend(cellfun(@(f) num2str(f), mat2cell(balance_alpha', ones(numel(balance_alpha), 1)), 'UniformOutput', false))

function s = scoring(x, p, lambda, alpha)
    n = numel(lambda);
    P = ones(n, 1);
    for j = 2:n
        P(j) = P(j-1) * p(j-1);
    end
    s = sum((P./lambda .* x.^(0:n-1)').^alpha);
end