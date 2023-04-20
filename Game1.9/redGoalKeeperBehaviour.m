function [red_gk, ball, BALL_POSSESSION, RESET] = redGoalKeeperBehaviour(red_gk, red_gkPlot, red_striker, red_defender1, red_defender2,  ball, ballPlotT, BALL_POSSESSION, TOLERANCE, TIME_STEP,OMEGA, positionMatrixR, positionMatrixB)

     gk_ball = calcDistBearing(red_gk.position, ball.position);
     RESET = 0;
     %%%%%%%%%%%%%%%%%%%%%%% WAIT %%%%%%%%%%%%%%%%%%%%%%%%%%
     if (ball.position(1) > 3 )
         red_gk.state = playerState.WAIT;
     elseif(red_gk.possession == 0)
         red_gk.state = playerState.SAVE;
     end
     if(red_gk.state == playerState.WAIT && ball.position(1) > 3 )
             gk_goal = calcDistBearing(red_gk.position, [1,4]);
             if(gk_goal(1) > TOLERANCE)
                if(abs(red_gk.headAngle-gk_goal(2)) >  TOLERANCE/2)
                    red_gk =  red_gk.turnPlayer( -1, OMEGA, TIME_STEP);
                    red_gk.updatePos(red_gkPlot);
                else
                     red_gk.headAngle = gk_goal(2);
                     red_gk           = red_gk.move(TIME_STEP);
                     red_gk.updatePos(red_gkPlot);
                end
             elseif(gk_goal(1) < TOLERANCE && abs(abs(red_gk.headAngle)) > TOLERANCE)
                    red_gk =  red_gk.turnPlayer( -1, OMEGA, TIME_STEP);
                    red_gk.updatePos(red_gkPlot);
             end
     end

     %%%%%%%%%%%%%%%%%%%%%%%  SAVE  %%%%%%%%%%%%%%%%%%%%%%%%%%
     if(red_gk.state == playerState.SAVE)
         if(red_gk.position(1) < 2 && red_gk.position(2) > 2 && red_gk.position(2) < 6 )
             if(ball.position(1) > 2.5)
                 red_gk.headAngle = gk_ball(2);
                 red_gk           = red_gk.move(TIME_STEP);
                 red_gk.updatePos(red_gkPlot);
                 if(gk_ball(1) < TOLERANCE && ball.possessed == 0)
                        ball.possessed     = 1;
                        BALL_POSSESSION    = 'R';
                        red_gk.state      = playerState.PASS;
                        ball.position      = [red_gk.position(1) + 0.2*cos(red_gk.headAngle), red_gk.position(2) + 0.2*sin(red_gk.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
                        ball.updatePlot(ballPlotT);
                 end
             else 
                 gk_ballSave = calcDistBearing(red_gk.position, [red_gk.position(1), ball.position(2)]);
                 if (abs(red_gk.headAngle-gk_ballSave(2)) >  TOLERANCE)
                     if(red_gk.position(2)<ball.position(2))
                        red_gk =  red_gk.turnPlayer( 1, OMEGA, TIME_STEP);
                        red_gk.updatePos(red_gkPlot);
                     else
                        red_gk =  red_gk.turnPlayer( -1, OMEGA, TIME_STEP);
                        red_gk.updatePos(red_gkPlot)
                     end
                 else
                    if(gk_ballSave(1)<0.2 && ball.possessed == 0)
                        red_gk.possession = 1;
                        ball.possessed     = 1;
                        BALL_POSSESSION    = 'R';
                        RESET              = 1;
                        red_gk.state      = playerState.PASS;
                        ball.velocity      = 0;
                        ball.position      = [red_gk.position(1) + 0.2*cos(red_gk.headAngle), red_gk.position(2) + 0.2*sin(red_gk.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
                        ball.updatePlot(ballPlotT);
                    end
                        red_gk.headAngle = gk_ballSave(2);
                        red_gk           = red_gk.move(TIME_STEP);
                        red_gk.updatePos(red_gkPlot);
                    
                 end

             end
         elseif(red_gk.possession == 0)
             gk_goal = calcDistBearing(red_gk.position, [1,4]);
             red_gk.headAngle = gk_goal(2);
             red_gk           = red_gk.move(TIME_STEP);
             red_gk.updatePos(red_gkPlot);
         end
     end
     %%%%%%%%%%%%%%%%%%%%%%%  PASS  %%%%%%%%%%%%%%%%%%%%%%%%%%
     %Pass the ball back to own team
     if(red_gk.state == playerState.PASS)
        gk_player = zeros(3,2);
        gk_player(1,:) = calcDistBearing(red_gk.position, positionMatrixR(1,:) );
        gk_player(2,:) = calcDistBearing(red_gk.position, positionMatrixR(2,:) );
        gk_player(3,:) = calcDistBearing(red_gk.position, positionMatrixR(3,:) );
        [~,passPlayerIndex] = min(gk_player(:,1));

        if (abs(red_gk.headAngle-gk_player(passPlayerIndex, 2)) >  TOLERANCE/2)
            red_gk =  red_gk.turnPlayer( 1, OMEGA, TIME_STEP);
            red_gk.updatePos(red_gkPlot)
            ball.position = [red_gk.position(1) + 0.2*cos(red_gk.headAngle), red_gk.position(2) + 0.2*sin(red_gk.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
            ball.updatePlot(ballPlotT);
        else
            ball.velocity             = red_gk.kickBall(ball.mass, "PASS", TIME_STEP);
            ball.direction            = red_gk.headAngle;
            red_gk.state             = playerState.WAIT;
            ball.possessed            = 0;
            red_gk.possession        = 0;
            switch(passPlayerIndex)
                case(1)
                    red_striker.state    = playerState.GET_POSSESSION;
                case(2)
                    red_defender1.state  = playerState.GET_POSSESSION;
                case(3)
                    red_defender2.state  = playerState.GET_POSSESSION;
            end
        end
     end

end
