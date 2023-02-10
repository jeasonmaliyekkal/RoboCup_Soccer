function Game()

shapeObj = plotSoccerField;

ballPlot = shapeObj(1);
strikerPlot = shapeObj(2);
defender1Plot = shapeObj(3);
defender2Plot = shapeObj(4);
goaliePlot = shapeObj(5);

pause(0.5);

for i=1:3
frame = getframe(gca);

position = ObjectTracking(frame);

ballPos = position(1:2);
strikerPos = position(9:10);
defender1Pos = position(5:6);
defender2Pos = position(7:8);
goaliePos = position(3:4);

%disp(strikerPos)



%% Pixel to coordinate mapping
%% GCF
    %%X - coordinate
    % ballPos(1) = ballPos(1)/49.1 - 1.833;
    % strikerPos(1) = strikerPos(1)/49.1 - 1.833;
    % defender1Pos(1) = defender1Pos(1)/49.1 - 1.833;
    % defender2Pos(1) = defender2Pos(1)/49.1 - 1.833;
    % goaliePos(1) = goaliePos(1)/49.1 - 1.833;
    %%Y - coordinate
    % ballPos(2) = (525-ballPos(2))/53.125 - 1.13;
    % strikerPos(2) = (525-strikerPos(2))/53.125 - 1.13;
    % defender1Pos(2) = (525-defender1Pos(2))/53.125 - 1.13;
    % defender2Pos(2) = (525-defender2Pos(2))/53.125 - 1.13;
    % goaliePos(2) = (525-goaliePos(2))/53.125 - 1.13;

%% GCA
%% X - coordinate
ballPos(1) = ballPos(1)/49.363636;
strikerPos(1) = strikerPos(1)/49.363636;
defender1Pos(1) = defender1Pos(1)/49.363636;
defender2Pos(1) = defender2Pos(1)/49.363636;
goaliePos(1) = goaliePos(1)/49.363636;
%% Y - coordinate
ballPos(2) = (429-ballPos(2))/53.625;
strikerPos(2) = (429-strikerPos(2))/53.625;
defender1Pos(2) = (429-defender1Pos(2))/53.625;
defender2Pos(2) = (429-defender2Pos(2))/53.625;
goaliePos(2) = (429-goaliePos(2))/53.625;


[newPos,state] = Algorithm(ballPos, strikerPos, defender1Pos,defender2Pos, goaliePos);


refreshFrame(strikerPlot,ballPlot, newPos,state);


end

end
