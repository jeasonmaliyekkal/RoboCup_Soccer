function red_gk = redGoalKeeperBehaviour(red_gk, ball, ballPlot, red_gkPlot,red_striker,red_defender1, red_defender2,TIME_STEP)
     red_gk_ball = calcDistBearing(red_gk.position, ball.position);
     
     %%%%%%%%%%%%%%%%%%%%%%% WAIT STATE %%%%%%%%%%%%%%%%%%%%%%%%%%
     if red_gk_ball(1) >= 2
         red_gk.state = playerState.WAIT;
     end
     %%%%%%%%%%%%%%%%%%%%%%% MOVE STATE %%%%%%%%%%%%%%%%%%%%%%%%%%
     %%Start intercepting when the distance to the ball is less than 2
     if red_gk_ball(1) < 2
         if red_gk_ball(1)>0.2
            red_gk.headAngle = red_gk_ball(2);
            red_gk           = red_gk.move(TIME_STEP);
            red_gk.updatePos(red_gkPlot);
            red_gk.state = playerState.TACKLE;
         end
         else
             %%start pass after interception
             red_gk.state = playerState.TACKLED;
             dis1 = calcDistBearing(red_gk.position, red_striker.position);
             dis2 = calcDistBearing(red_gk.position, red_defender1.position);
             dis3 = calcDistBearing(red_gk.position, red_defender2.position);
             distance = [dis1(1), dis2(1), dis3(1)];
             head_angle = [dis1(2), dis2(2), dis3(2)];
             [min_dis, pos] = min(distance); % judge the min distance  
             min_angle = head_angle(pos);  % which angle sholud be shooting  
             ball.velocity             = red_gk.kickBall(ball.mass, "PASS", TIME_STEP);
             ball.direction            = min_angle;
             ball.possessed            = 0;
             ball.move(0.1);
             ball.updatePlot(ballPlot);
     end
end