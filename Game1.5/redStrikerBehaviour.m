function red_striker_T =  redStrikerBehaviour(red_striker_T,ball, TOLERANCE,TIME_STEP,OMEGA, strikerPlotT, positionMatrixB)

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
                    ball.possessed         = 1;
                    red_striker_T.state      = playerState.DRIBBLE;
                else
                    red_striker_T.state      = playerState.TACKLE;
                    ball.possessed         = 0;
                    red_striker_T.possession = 1;
                    ball.possessed         = 1;
                    red_striker_T.state      = playerState.DRIBBLE;

                end
            end
        end
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
            end
        end

        
        
end
