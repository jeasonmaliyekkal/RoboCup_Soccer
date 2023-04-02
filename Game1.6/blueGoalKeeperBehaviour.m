function blue_gk = blueGoalKeeperBehaviour(blue_gk, ball, ballPlot, blue_gkPlot)
     y = 2*rand(1)+3;
     blue_gk.position = [10, y];
     blue_gk.updatePos(blue_gkPlot);
end