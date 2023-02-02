
for j = 1:2
    file = ['DATA',num2str(j),'.xlsx'];
    [Type Sheet Format]=xlsfinfo(file);
    for i = 1:length(Sheet)
        [pass, n, x, y, delta(j,i)] = readat(file,Sheet{i});
        C(j,i) = clco(pass);                   
        pij = graphallshortestpaths(sparse(1./pass));          
        d(j,i) = sum(sum(pij))/110; 
    end
end

Kc = C(1,:)./C(2,:);
Kdelta = delta(1,:)./delta(2,:);
Kd = d(1,:)./d(2,:);
parament = [Kc;Kdelta;Kd]';
bar(parament);
xlabel('Match ID');
ylabel('K');
legend('聚类系数比值 Kc','球队节奏比值 K\delta','球队联系紧密度比值 Kd')

outcome = [1 2 0 0 0 1 0 2 0 0 1 2 0 1 1 2 1 1 ...
    2 2 0 0 0 2 1 0 1 0 0 1 1 0 2 2 1 1 2 0];
% outcome 矩阵为 38 场比赛的结果，0 为失败，1 为胜利，2 为平局
win = find(outcome == 1);
loss = find(outcome == 0);
% tie = find(outcome == 2);

Kc_win = sum(Kc(win))/length(win);
Kc_loss = sum(Kc(loss))/length(loss);
% Kc_tie = sum(Kc(tie))/length(tie);

Kdelta_win = sum(Kdelta(win))/length(win);
Kdelta_loss = sum(Kdelta(loss))/length(loss);
% Kdelta_tie = sum(Kdelta(tie))/length(tie);

Kd_win = sum(Kd(win))/length(win);
Kd_loss = sum(Kd(loss))/length(loss);
% Kd_tie = sum(Kd(tie))/length(tie);

K = [Kc_win,Kc_loss;Kdelta_win,Kdelta_loss;Kd_win,Kd_loss];
% K = [Kc_win,Kc_loss,Kc_tie;Kdelta_win,Kdelta_loss,Kdelta_tie;...
%     Kd_win,Kd_loss,Kd_tie];
figure;
bar(K);
legend('win','loss');
xticklabels({'Kc','K\delta','Kd'});