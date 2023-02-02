dat = xlsread('data.xlsx','sheet1');
[pass, n, x, y, delta] = readat('data.xlsx','sheet1', [1:100]);
h = plotfield(0,x,y,n,pass);
for t = 0:size(dat,1)-100
   [pass, n, x, y, delta] = readat('data.xlsx','sheet1', [1:100]+t);
   h = plotfield(t,x,y,n,pass,h);
   drawnow
end

% -------------------------------------------------------------------------

function h = plotfield(t,x,y,n,pass,h)
% plot soccer field

L = 105/2; W = 68/2; 
x = -L + L/50*x; y = -W + W/50*y;

G = digraph(pass);

if nargin==6
    set(h(1), 'XData',x, 'YData',y, 'SizeData', n.^2); 
    set(h(2), 'String',['第',num2str(t),'段传球网络']);
    delete(h(3)); h(3) = plot(G,'r-','XData',x,'YData',y);
    return; 
end

figure('position',[100,100,1000,600])
R = 9.15;
l = [16.5 5.5 -2]; w = [20.16 9.16 3.66];
fill(1.1*L*[-1 1 1 -1], 1.1*W*[-1 -1 1 1], [0.8,1,0.8]);
axis image; axis([-1.1*L,1.1*L,-1.1*W,1.1*W]); hold on
plot(L*[1 -1 -1 1 1],W*[1 1 -1 -1 1],'k',[0,0],W*[-1 1],'k','linewidth',2);
plot(R*cosd(0:360),R*sind(0:360),'k','linewidth',2);
for i = 1:3
    plot([L-l(i)*[0 1 1 0]']*[-1 1], w(i)*[-1 -1 1 1]','k','linewidth',2)
end
plot([L-11-R*cosd(-51:51)']*[-1 1], R*sind(-51:51)','k','linewidth',2);
xlabel('x (m)'); ylabel('y (m)')


h(1) = scatter(x,y,n.^2,n,'filled');
h(2) = title(['第',num2str(t),'段传球网络']);
h(3) = plot(G,'r-','XData',x,'YData',y);

end