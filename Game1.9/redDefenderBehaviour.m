function [red_striker_T, red_defender_T, ball] =  redDefenderBehaviour(red_striker_T, red_defender_T, ball, ballPlotT, TOLERANCE, PLAYER_GAP, TIME_STEP,OMEGA, defenderPlotT, positionMatrixR, positionMatrixB)
    
    %%%%%%%%%%%%%%%%% GET POSSESSION %%%%%%%%%%%%%%%%%%%%
    if(red_defender_T.state == playerState.GET_POSSESSION)
        redDef_Ball = calcDistBearing(red_defender_T.position, ball.position);

            if(redDef_Ball(1) >  TOLERANCE)
                red_defender_T.headAngle = redDef_Ball(2);
                red_defender_T           = red_defender_T.move(TIME_STEP);
                red_defender_T.updatePos(defenderPlotT);

            else
                if(ball.possessed == 0)
                    red_defender_T.possession = 1;
                    ball.possessed            = 1;
                    red_defender_T.state      = playerState.DRIBBLE;
                else
                    red_defender_T.state      = playerState.TACKLE;
                    ball.possessed            = 0;
                    red_defender_T.possession = 1;
                    ball.possessed            = 1;
                    red_defender_T.state      = playerState.DRIBBLE;
                end

            end
    end
    
    %%%%%%%%%%%%%%%%%% DRIBBLE %%%%%%%%%%%%%%%%%%%%
    if(red_defender_T.state == playerState.DRIBBLE)
        action = obstacleDetection(red_defender_T.position, red_defender_T.headAngle, positionMatrixB, "RED");
        if(action == "CONTINUE")
            redSkr_Goal = calcDistBearing(red_defender_T.position, [8, 2+(2)*rand(1)]);
            if(redSkr_Goal(1) > TOLERANCE)
                    red_defender_T.headAngle = redSkr_Goal(2);
                    red_defender_T           = red_defender_T.move(TIME_STEP);
                    red_defender_T.updatePos(defenderPlotT);
             end
        elseif(action == "DIVERT_LEFT")
                red_defender_T = red_defender_T.turnPlayer( 1, OMEGA, TIME_STEP);
                red_defender_T = red_defender_T.move(TIME_STEP);
                red_defender_T.updatePos(defenderPlotT);
        elseif(action == "DIVERT_RIGHT")
                red_defender_T = red_defender_T.turnPlayer( -1, OMEGA, TIME_STEP);
                %red_defender_T = red_defender_T.move(TIME_STEP);
                red_defender_T.updatePos(defenderPlotT);
        elseif(action == "CLEAR")
                %red_defender_T.headAngle = red_defender_T.turnPlayer( "RIGHT", OMEGA, TIME_STEP);
                red_defender_T = red_defender_T.move(TIME_STEP);
                red_defender_T.updatePos(defenderPlotT);
        elseif(action == "PASS")
                red_defender_T.state = playerState.PASS;
        end
        ball.position = [red_defender_T.position(1) + 0.2*cos(red_defender_T.headAngle), red_defender_T.position(2) + 0.2*sin(red_defender_T.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
        ball.updatePlot(ballPlotT);

        %%%%%%%%%%%%%%%% PASS_temp %%%%%%%%%%%%%%%%%
        if(positionMatrixR(1,1) > 8)
            red_defender_T.state = playerState.PASS;
        end


    end
    
    %%%%%%%%%%%%%%%%%%%% PASS %%%%%%%%%%%%%%%%%%%%%
    if(red_defender_T.state == playerState.PASS)
        redDef_skr = calcDistBearing(red_defender_T.position, positionMatrixR(1,:));
        if (abs(red_defender_T.headAngle-redDef_skr(2)) >  TOLERANCE/10)
            if(red_defender_T.position(1,2) < positionMatrixR(1,2))
                red_defender_T =  red_defender_T.turnPlayer( 1, OMEGA, TIME_STEP);
                red_defender_T.updatePos(defenderPlotT);
                ball.position  = [red_defender_T.position(1) + 0.2*cos(red_defender_T.headAngle), red_defender_T.position(2) + 0.2*sin(red_defender_T.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
                ball.updatePlot(ballPlotT);
                red_striker_T.state = playerState.WAIT;
            end
        else
                    ball.velocity       = red_defender_T.kickBall(ball.mass, "PASS", TIME_STEP);
                    ball.direction      = red_defender_T.headAngle;
                    red_defender_T.state = playerState.ASSIST;
                    ball.possessed      = 0;
                    red_striker_T.state = playerState.GET_POSSESSION;
  
        end
    end
    %%%%%%%%%%%%%%%%%% ASSIST %%%%%%%%%%%%%%%%%%%%%
    if(red_defender_T.state == playerState.ASSIST) 
            redDef_skr = calcDistBearing(red_defender_T.position, positionMatrixR(1,:));
            
            if(redDef_skr(1) > PLAYER_GAP)
                red_defender_T.headAngle = redDef_skr(2) - 0.5*rand(1);
                red_defender_T           = red_defender_T.move(TIME_STEP);
                red_defender_T.updatePos(defenderPlotT);
            end
     end
           


end