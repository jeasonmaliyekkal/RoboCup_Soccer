function C = clco(pass)
% Calculate the clustering coefficient of the passing network

[C, N, D] = deal(zeros(1,11)); % C = N/D clustering coefficient

for i = 1:11
    for j = 1:11
        for k = 1:11
        N(i) = N(i) + (pass(i,j)+pass(j,i))*...
                      (pass(j,k)+pass(k,j))*...
                      (pass(i,k)+pass(k,i));
        D(i) = D(i) + (pass(i,j)+pass(j,i))*(pass(i,k)+pass(k,i));
        end
    end
end
C = mean(N./D);