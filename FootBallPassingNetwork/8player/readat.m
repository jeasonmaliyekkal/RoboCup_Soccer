function [pass, n, x, y, delta] = readat(xlsx, sht, rng)

dat = xlsread(xlsx, sht);
if nargin==2; rng = 1:size(dat,1); end

I = dat(:,3);
J = dat(:,4);
pass = zeros(8);
x = zeros(8,1);
y = zeros(8,1);
for k = rng
    i = dat(k,3); j = dat(k,4);
    pass(i,j) = pass(i,j) + 1;
    x(i) = x(i) + dat(k, 8);
    y(i) = y(i) + dat(k, 9);
    x(j) = x(j) + dat(k,10);
    y(j) = y(j) + dat(k,11);
end

n = sum(pass,1)' + sum(pass,2);
x = x./n; y = y./n;
delta = abs(  (dat(rng,11) - dat(rng,9))./ (dat(rng,10) - dat(rng,8))  );
delta(isinf(delta)|isnan(delta)) = 100;
delta = mean(delta);