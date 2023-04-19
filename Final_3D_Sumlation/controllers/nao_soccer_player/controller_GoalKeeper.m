function [blue_gk, ball, BALL_POSSESSION, RESET] = blueGoalKeeperBehaviour(blue_gk, blue_gkPlot, blue_striker, blue_defender1, blue_defender2,  ball, ballPlotT, BALL_POSSESSION, TOLERANCE, TIME_STEP,OMEGA, positionMatrixR,positionMatrixB)

     gk_ball = calcDistBearing(blue_gk.position, ball.position);
     RESET = 0;
     %%%%%%%%%%%%%%%%%%%%%%% WAIT %%%%%%%%%%%%%%%%%%%%%%%%%%
     if (ball.position(1) < 8 )
         blue_gk.state = playerState.WAIT;
     elseif(blue_gk.possession == 0)
         blue_gk.state = playerState.SAVE;
     end
     if(blue_gk.state == playerState.WAIT && ball.position(1) < 8 )
             gk_goal = calcDistBearing(blue_gk.position, [10,4]);
             if(gk_goal(1) > TOLERANCE)
                if(abs(blue_gk.headAngle-gk_goal(2)) >  TOLERANCE/2)
                    blue_gk =  blue_gk.turnPlayer( -1, OMEGA, TIME_STEP);
                    blue_gk.updatePos(blue_gkPlot);
                else
                     blue_gk.headAngle = gk_goal(2);
                     blue_gk           = blue_gk.move(TIME_STEP);
                     blue_gk.updatePos(blue_gkPlot);
                end
             elseif(gk_goal(1) < TOLERANCE && abs(abs(blue_gk.headAngle) - pi) > TOLERANCE)
                    blue_gk =  blue_gk.turnPlayer( -1, OMEGA, TIME_STEP);
                    blue_gk.updatePos(blue_gkPlot);
             end
     end

     %%%%%%%%%%%%%%%%%%%%%%%  SAVE  %%%%%%%%%%%%%%%%%%%%%%%%%%
     if(blue_gk.state == playerState.SAVE)
         if(blue_gk.position(1) > 8 && blue_gk.position(2) > 2 && blue_gk.position(2) < 6 )
             if(ball.position(1) < 8.5)
                 blue_gk.headAngle = gk_ball(2);
                 blue_gk           = blue_gk.move(TIME_STEP);
                 blue_gk.updatePos(blue_gkPlot);
                 if(gk_ball(1) < TOLERANCE && ball.possessed == 0)
                        ball.possessed     = 1;
                        BALL_POSSESSION    = 'B';
                        blue_gk.state      = playerState.PASS;
                        ball.position      = [blue_gk.position(1) + 0.2*cos(blue_gk.headAngle), blue_gk.position(2) + 0.2*sin(blue_gk.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
                        ball.updatePlot(ballPlotT);
                 end
             else 
                 gk_ballSave = calcDistBearing(blue_gk.position, [blue_gk.position(1), ball.position(2)]);
                 if (abs(blue_gk.headAngle-gk_ballSave(2)) >  TOLERANCE)
                     if(blue_gk.position(2)<ball.position(2))
                        blue_gk =  blue_gk.turnPlayer( -1, OMEGA, TIME_STEP);
                        blue_gk.updatePos(blue_gkPlot);
                     else
                        blue_gk =  blue_gk.turnPlayer( 1, OMEGA, TIME_STEP);
                        blue_gk.updatePos(blue_gkPlot)
                     end
                 else
                    if(gk_ballSave(1)<0.2 && ball.possessed == 0)
                        blue_gk.possession = 1;
                        ball.possessed     = 1;
                        BALL_POSSESSION    = 'B';
                        RESET              = 1;
                        blue_gk.state      = playerState.PASS;
                        ball.velocity      = 0;
                        ball.position      = [blue_gk.position(1) + 0.2*cos(blue_gk.headAngle), blue_gk.position(2) + 0.2*sin(blue_gk.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
                        ball.updatePlot(ballPlotT);
                    end
                        blue_gk.headAngle = gk_ballSave(2);
                        blue_gk           = blue_gk.move(TIME_STEP);
                        blue_gk.updatePos(blue_gkPlot);
                    
                 end

             end
         elseif(blue_gk.possession == 0)
             gk_goal = calcDistBearing(blue_gk.position, [10,4]);
             blue_gk.headAngle = gk_goal(2);
             blue_gk           = blue_gk.move(TIME_STEP);
             blue_gk.updatePos(blue_gkPlot);
         end
     end
     %%%%%%%%%%%%%%%%%%%%%%%  PASS  %%%%%%%%%%%%%%%%%%%%%%%%%%
     %Pass the ball back to own team
     if(blue_gk.state == playerState.PASS)
        gk_player = zeros(3,2);
        gk_player(1,:) = calcDistBearing(blue_gk.position, positionMatrixB(1,:) );
        gk_player(2,:) = calcDistBearing(blue_gk.position, positionMatrixB(2,:) );
        gk_player(3,:) = calcDistBearing(blue_gk.position, positionMatrixB(3,:) );
        [~,passPlayerIndex] = min(gk_player(:,1));

        if (abs(blue_gk.headAngle-gk_player(passPlayerIndex, 2)) >  TOLERANCE/2)
            blue_gk =  blue_gk.turnPlayer( 1, OMEGA, TIME_STEP);
            blue_gk.updatePos(blue_gkPlot)
            ball.position = [blue_gk.position(1) + 0.2*cos(blue_gk.headAngle), blue_gk.position(2) + 0.2*sin(blue_gk.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
            ball.updatePlot(ballPlotT);
        else
            ball.velocity             = blue_gk.kickBall(ball.mass, "PASS", TIME_STEP);
            ball.direction            = blue_gk.headAngle;
            blue_gk.state             = playerState.WAIT;
            ball.possessed            = 0;
            blue_gk.possession        = 0;
            switch(passPlayerIndex)
                case(1)
                    blue_striker.state    = playerState.GET_POSSESSION;
                case(2)
                    blue_defender1.state  = playerState.GET_POSSESSION;
                case(3)
                    blue_defender2.state  = playerState.GET_POSSESSION;
            end
        end
     end

end
