function [blue_striker_T, blue_defender1_T, blue_defender2_T, red_striker_T, red_defender1_T, red_defender2_T, ball, BALL_POSSESSION] =  blueDefender2Behaviour(blue_striker_T, blue_defender1_T, blue_defender2_T, red_striker_T, red_defender1_T, red_defender2_T, ball, ballPlotT, BALL_POSSESSION,TOLERANCE, PLAYER_GAP, TIME_STEP, OMEGA, defenderPlotT, positionMatrixR,positionMatrixB)

    %%%%%%%%%%%%%%%%% GET POSSESSION %%%%%%%%%%%%%%%%%%%%
    if(BALL_POSSESSION == 'B' && blue_defender2_T.possession == 0)
                blue_defender2_T.state = playerState.ASSIST;
    end
    if(blue_defender2_T.state == playerState.GET_POSSESSION)
        blueDef_Ball = calcDistBearing(blue_defender2_T.position, ball.position);

            if(blueDef_Ball(1) >  TOLERANCE)
                blue_defender2_T.headAngle = blueDef_Ball(2);
                blue_defender2_T           = blue_defender2_T.move(TIME_STEP);
                blue_defender2_T.updatePos(defenderPlotT);

            else
                blue_defender2_T.state      = playerState.TACKLE;
                blue_defender2_T.counter    = 10;
                
                tackledPlayer             = tackle(blue_defender2_T.position, positionMatrixR);
                switch(tackledPlayer)
                    case(1)
                        red_striker_T.state     = playerState.TACKLED;
                        red_striker_T.counter   = 30;
                    case(2)
                        red_defender1_T.state   = playerState.TACKLED;
                        red_defender1_T.counter = 30;
                    case(3)
                        red_defender2_T.state   = playerState.TACKLED;
                        red_defender2_T.counter = 30;
                end

                BALL_POSSESSION           = 'B';
                blue_defender2_T.possession = 1;
                ball.possessed            = 1;
                blue_defender2_T.state      = playerState.DRIBBLE;

            end
    end
    
    %%%%%%%%%%%%%%%%%% DRIBBLE %%%%%%%%%%%%%%%%%%%%
    if(blue_defender2_T.state == playerState.DRIBBLE)
        action = obstacleDetection(blue_defender2_T.position, blue_defender2_T.headAngle, positionMatrixR, "BLUE");
        if(action == "CONTINUE")
            blueSkr_Goal = calcDistBearing(blue_defender2_T.position, [2, 2+(1)*rand(1)]);
            if(blueSkr_Goal(1) > TOLERANCE)
                    blue_defender2_T.headAngle = blueSkr_Goal(2);
                    blue_defender2_T           = blue_defender2_T.move(TIME_STEP);
                    blue_defender2_T.updatePos(defenderPlotT);
             end
        elseif(action == "DIVERT_NORTH")
                blue_defender2_T = blue_defender2_T.turnPlayer( -1, OMEGA, TIME_STEP);
                blue_defender2_T = blue_defender2_T.move(TIME_STEP);
                blue_defender2_T.updatePos(defenderPlotT);
        elseif(action == "DIVERT_SOUTH")
                blue_defender2_T = blue_defender2_T.turnPlayer( 1, OMEGA, TIME_STEP);
                %blue_defender_T = blue_defender_T.move(TIME_STEP);
                blue_defender2_T.updatePos(defenderPlotT);
        elseif(action == "CLEAR")
                %blue_defender_T.headAngle = blue_defender_T.turnPlayer( "RIGHT", OMEGA, TIME_STEP);
                blue_defender2_T = blue_defender2_T.move(TIME_STEP);
                blue_defender2_T.updatePos(defenderPlotT);
        elseif(action == "PASS")
                blue_defender2_T.state = playerState.PASS;
        end
        ball.position = [blue_defender2_T.position(1) + 0.2*cos(blue_defender2_T.headAngle), blue_defender2_T.position(2) + 0.2*sin(blue_defender2_T.headAngle)];  % 0.4 -> Robot radius, to plot the ball at the end of circle
        ball.updatePlot(ballPlotT);

        %%%%%%%%%%%%%%%% PASS_temp %%%%%%%%%%%%%%%%%
        if(positionMatrixB(1,1) < 2)
            blue_defender2_T.state = playerState.PASS;
        end


    end
    
    %%%%%%%%%%%%%%%%%%% PASS %%%%%%%%%%%%%%%%%%%%%
    if (blue_defender2_T.state == playerState.PASS)
    blueDef_skr = calcDistBearing(blue_defender2_T.position, positionMatrixB(1,:)); % distance and bearing to blue striker
    blueDef_def1 = calcDistBearing(blue_defender2_T.position, positionMatrixB(2,:)); % distance and bearing to blue defender 1
        if (abs(blue_defender2_T.headAngle - blueDef_skr(2)) <= TOLERANCE/10) % pass to blue striker
            ball.velocity = blue_defender2_T.kickBall(ball.mass, "PASS", TIME_STEP);
            ball.direction = blue_defender2_T.headAngle;
            blue_defender2_T.state = playerState.ASSIST;
            ball.possessed = 0;
            blue_striker_T.state = playerState.GET_POSSESSION;
        elseif (abs(blue_defender2_T.headAngle - blueDef_def1(2)) <= TOLERANCE/10 ) % pass to blue defender 1
            ball.velocity = blue_defender2_T.kickBall(ball.mass, "PASS", TIME_STEP);
            ball.direction = blue_defender2_T.headAngle;
            blue_defender2_T.state = playerState.ASSIST;
            ball.possessed = 0;
            blue_defender1_T.state = playerState.GET_POSSESSION;
        else % adjust position
            if (blue_defender2_T.position(1,2) < positionMatrixB(1,2))
                blue_defender2_T = blue_defender2_T.turnPlayer(1, OMEGA, TIME_STEP);
                blue_defender2_T.updatePos(defenderPlotT);
                ball.position = [blue_defender2_T.position(1) + 0.4*cos(blue_defender2_T.headAngle), blue_defender2_T.position(2) + 0.2*sin(blue_defender2_T.headAngle)];  % 0.4 -> Robot radius, to plot the ball at the end of circle
                ball.updatePlot(ballPlotT);
                blue_striker_T.state = playerState.WAIT;
            end
        end
    end

    %%%%%%%%%%%%%%%%%% ASSIST %%%%%%%%%%%%%%%%%%%%%
    if(blue_defender2_T.state == playerState.ASSIST) 
            blueDef_skr = calcDistBearing(blue_defender2_T.position, positionMatrixB(1,:));
            
            if(blueDef_skr(1) > PLAYER_GAP)
                blue_defender2_T.headAngle = blueDef_skr(2) - 0.5*rand(1);
                blue_defender2_T           = blue_defender2_T.move(TIME_STEP);
                blue_defender2_T.updatePos(defenderPlotT);
            end
     end
     %%%%%%%%%%%%%%%%%% TACKLED %%%%%%%%%%%%%%%%%%%%%%
     if(blue_defender2_T.state == playerState.TACKLED)
        blue_defender2_T.possession   = 0;

         if(blue_defender2_T.counter > 0)
            blue_defender2_T.counter = blue_defender2_T.counter - 1;
         else
             if(BALL_POSSESSION == 'R')
                blue_defender2_T.state = playerState.ASSIST;
             else
                blue_defender2_T.state = playerState.GET_POSSESSION;
             end
         end
    end
           





end