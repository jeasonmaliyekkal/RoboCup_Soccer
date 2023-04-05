function blue_gk = blueGoalKeeperBehaviour(blue_gk, ball, ballPlot, blue_gkPlot,blue_striker,blue_defender1, blue_defender2,TIME_STEP)
     blue_gk_ball = calcDistBearing(blue_gk.position, ball.position);
     
    %%%%%%%%%%%%%%%%%%%%%%% WAIT STATE %%%%%%%%%%%%%%%%%%%%%%%%%%
     if blue_gk_ball(1) >= 2
         blue_gk.state = playerState.WAIT;
     end
     %%%%%%%%%%%%%%%%%%%%%%% MOVE STATE %%%%%%%%%%%%%%%%%%%%%%%%%%
     %%Start intercepting when the distance to the ball is less than 2
     if blue_gk_ball(1) < 2
         if blue_gk_ball(1)>0.2
            blue_gk.headAngle = blue_gk_ball(2);
            blue_gk           = blue_gk.move(TIME_STEP);
            blue_gk.updatePos(blue_gkPlot);
            blue_gk.state = playerState.TACKLE;
         end
         else
             %%start pass after interception
             blue_gk.state = playerState.TACKLED;
             dis1 = calcDistBearing(blue_gk.position, blue_striker.position);
             dis2 = calcDistBearing(blue_gk.position, blue_defender1.position);
             dis3 = calcDistBearing(blue_gk.position, blue_defender2.position);
             distance = [dis1(1), dis2(1), dis3(1)];
             head_angle = [dis1(2), dis2(2), dis3(2)];
             [min_dis, pos] = min(distance); % judge the min distance 
             min_angle = head_angle(pos); % which angle sholud be shooting 
             ball.velocity             = blue_gk.kickBall(ball.mass, "PASS", TIME_STEP);
             ball.direction            = min_angle;
             ball.possessed            = 0;
             ball.move(0.1);
             ball.updatePlot(ballPlot);
     end
end