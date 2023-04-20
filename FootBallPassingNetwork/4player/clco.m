function C = clco(pass)
% 计算传球网络的聚类系数

[C, N, D] = deal(zeros(1,11)); % C = N/D 聚类系数

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