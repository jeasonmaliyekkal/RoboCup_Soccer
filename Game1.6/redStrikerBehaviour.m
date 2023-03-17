function [red_striker_T, red_defender1_T, red_defender2_T, ball] =  redStrikerBehaviour(red_striker_T, red_defender1_T, red_defender2_T, ball, ballPlotT, TOLERANCE,TIME_STEP,OMEGA, strikerPlotT, positionMatrixR, positionMatrixB)
         
         %%%%%%%%%%%%%%%%% GET POSSESSION %%%%%%%%%%%%%%%%%%%
         if(red_striker_T.state == playerState.GET_POSSESSION)
            redSkr_Ball = calcDistBearing(red_striker_T.position, ball.position);

            if(redSkr_Ball(1) >  TOLERANCE)
                red_striker_T.headAngle = redSkr_Ball(2);
                %red_striker_T.position = [red_striker_T.position(1)+TIME_STEP*PLAYER_SPEED*cos(red_striker_T.headAngle),red_striker_T.position(2)+TIME_STEP*PLAYER_SPEED*sin(red_striker_T.headAngle)];
                red_striker_T = red_striker_T.move(TIME_STEP);
                red_striker_T.updatePos(strikerPlotT);

            else
                if(ball.possessed == 0)
                    red_striker_T.possession = 1;
                    ball.possessed           = 1;
                    red_striker_T.state      = playerState.DRIBBLE;
                else
                    red_striker_T.state      = playerState.TACKLE;
                    ball.possessed           = 0;
                    red_striker_T.possession = 1;
                    ball.possessed           = 1;
                    red_striker_T.state      = playerState.DRIBBLE;

                end
            end
         end


         %%%%%%%%%%%%%%%%% DRIBBLE %%%%%%%%%%%%%%%%%%%%%
        if(red_striker_T.state == playerState.DRIBBLE)
            action = obstacleDetection(red_striker_T.position, red_striker_T.headAngle, positionMatrixB, "RED");
            if(action == "CONTINUE")
                redSkr_Goal = calcDistBearing(red_striker_T.position, [9.5, 3+(2)*rand(1)]);
                if(redSkr_Goal(1) > TOLERANCE)
                    red_striker_T.headAngle = redSkr_Goal(2);
                    red_striker_T           = red_striker_T.move(TIME_STEP);
                    red_striker_T.updatePos(strikerPlotT);
                end
            elseif(action == "DIVERT_LEFT")
                red_striker_T = red_striker_T.turnPlayer( "LEFT", OMEGA, TIME_STEP);
                red_striker_T = red_striker_T.move(TIME_STEP);
                red_striker_T.updatePos(strikerPlotT);
            elseif(action == "DIVERT_RIGHT")
                red_striker_T = red_striker_T.turnPlayer( "RIGHT", OMEGA, TIME_STEP);
                %red_striker_T = red_striker_T.move(TIME_STEP);
                red_striker_T.updatePos(strikerPlotT);
            elseif(action == "CLEAR")
                %red_striker_T.headAngle = red_striker_T.turnPlayer( "RIGHT", OMEGA, TIME_STEP);
                red_striker_T = red_striker_T.move(TIME_STEP);
                red_striker_T.updatePos(strikerPlotT);
            elseif(action == "PASS")
                red_striker_T.state = playerState.PASS;
            end
        ball.position = [red_striker_T.position(1) + 0.4*cos(red_striker_T.headAngle), red_striker_T.position(2) + 0.2*sin(red_striker_T.headAngle)];  % 0.4 -> Robot radius, to plot the ball at the end of circle
        ball.updatePlot(ballPlotT);


        end

        %%%%%%%%%%%%% PASS %%%%%%%%%%%%%%
        if(red_striker_T.state == playerState.PASS)
            str_def1 = calcDistBearing(red_striker_T.position, positionMatrixR(2,:) );
            str_def2 = calcDistBearing(red_striker_T.position, positionMatrixR(3,:) );
            
            if(str_def1(1) < str_def2(1))
                if (red_striker_T.headAngle-str_def1(2) >  TOLERANCE/10)
                    red_striker_T =  red_striker_T.turnPlayer( "RIGHT", OMEGA, TIME_STEP);
                    red_striker_T.updatePos(strikerPlotT);
                    ball.position = [red_striker_T.position(1) + 0.4*cos(red_striker_T.headAngle), red_striker_T.position(2) + 0.2*sin(red_striker_T.headAngle)];  % 0.4 -> Robot radius, to plot the ball at the end of circle
                    ball.updatePlot(ballPlotT);
                  
                else
                    ball.velocity       = red_striker_T.kickBall(ball.mass, "PASS", TIME_STEP);
                    ball.direction      = red_striker_T.headAngle;
                    red_striker_T.state = playerState.ASSIST;
                    ball.possessed      = 0;
                    red_defender1_T.state = playerState.GET_POSSESSION;

                end
            end
        end
        %%%%%%%%%%%%%%%%%% ASSIST %%%%%%%%%%%%%%%%%%%%%
        if(red_striker_T.state == playerState.ASSIST) 
            redSkr_Goal = calcDistBearing(red_striker_T.position, [9.5, 3+(2)*rand(1)]);
            
            if(redSkr_Goal(1) > TOLERANCE)
                red_striker_T.headAngle = redSkr_Goal(2) - 0.5*rand(1);
                red_striker_T           = red_striker_T.move(TIME_STEP);
                red_striker_T.updatePos(strikerPlotT);
            end
        end

        %%%%%%%%%%%%%%%%%% WAIT %%%%%%%%%%%%%%%%%%%%%%
        if(red_striker_T.state == playerState.WAIT) 
            redSkr_Ball = calcDistBearing(red_striker_T.position, ball.position);
            if(redSkr_Ball(1) <  TOLERANCE)
                red_striker_T.possession = 1;
                ball.possessed           = 1;
                red_striker_T.state      = playerState.SHOOT;
            end

        end


        %%%%%%%%%%%%%%%%% SHOOT %%%%%%%%%%%%%%%%%%%%%%

        if(red_striker_T.position(1,1) > 8)
            red_striker_T.state = playerState.SHOOT;
        end
        
        if(red_striker_T.state == playerState.SHOOT)
            if(red_striker_T.position(1,2) < 5.3 && red_striker_T.position(1,2) > 2.7)
                red_striker_T.headAngle = 0.3*rand(1);
                pause(0.1);
                ball.velocity       = red_striker_T.kickBall(ball.mass, "PASS", TIME_STEP);
                ball.direction      = red_striker_T.headAngle;
                ball.possessed      = 0;
            end
        end
end
