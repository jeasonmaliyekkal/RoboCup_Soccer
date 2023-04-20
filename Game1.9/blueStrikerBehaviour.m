function [blue_striker_T, blue_defender1_T, blue_defender2_T, red_striker_T, red_defender1_T, red_defender2_T, ball, BALL_POSSESSION, RESET] =  blueStrikerBehaviour(blue_striker_T, blue_defender1_T, blue_defender2_T, red_striker_T, red_defender1_T, red_defender2_T, ball, ballPlotT, BALL_POSSESSION,  TOLERANCE, PLAYER_GAP, TIME_STEP,OMEGA, strikerPlotT, positionMatrixR, positionMatrixB, RESET )

         %%%%%%%%%%%%%%%%% CONSTRAINTS %%%%%%%%%%%%%%%%%%%
         if(BALL_POSSESSION == 'R' && blue_striker_T.state ~=playerState.TACKLED)
             blue_striker_T.state = playerState.GET_POSSESSION;
         end

         if(BALL_POSSESSION == 'B' && blue_striker_T.possession == 0 && ball.possessed == 1)
                blue_striker_T.state = playerState.ASSIST;
         end


         %%%%%%%%%%%%%%%%% GET POSSESSION %%%%%%%%%%%%%%%%%%%
         if(blue_striker_T.state == playerState.GET_POSSESSION)
            
            blueSkr_Ball = calcDistBearing(blue_striker_T.position, ball.position);

            if(blueSkr_Ball(1) >  TOLERANCE)
                blue_striker_T.headAngle = blueSkr_Ball(2);
                blue_striker_T           = blue_striker_T.move(TIME_STEP);
                blue_striker_T.updatePos(strikerPlotT);

            else
                if(ball.possessed == 0)
                    blue_striker_T.possession = 1;
                    ball.possessed            = 1;
                    BALL_POSSESSION           = 'B';
                    blue_striker_T.state      = playerState.DRIBBLE;
                else
                    blue_striker_T.state      = playerState.TACKLE;
                    blue_striker_T.counter    = 10;
                    
                    tackledPlayer             = tackle(blue_striker_T.position, positionMatrixR);
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
                    blue_striker_T.possession = 1;
                    ball.possessed            = 1;
                    blue_striker_T.state      = playerState.DRIBBLE;

                end
            end
         end


         %%%%%%%%%%%%%%%%% DRIBBLE %%%%%%%%%%%%%%%%%%%%%
        if(blue_striker_T.state == playerState.DRIBBLE)
            if(blue_striker_T.counter > 0)  
                action = "CONTINUE";
                blue_striker_T.counter = blue_striker_T.counter - 1;
            else
                action = obstacleDetection(blue_striker_T.position, blue_striker_T.headAngle, positionMatrixR, "BLUE");
            end
            if(action == "CONTINUE")
                blueSkr_Goal = calcDistBearing(blue_striker_T.position, [1.9, 3+(2)*rand(1)]);
                if(blueSkr_Goal(1) > TOLERANCE)
                    blue_striker_T.headAngle = blueSkr_Goal(2);
                    blue_striker_T           = blue_striker_T.move(TIME_STEP);
                    blue_striker_T.updatePos(strikerPlotT);
                end
            elseif(action == "DIVERT_NORTH")
                blue_striker_T = blue_striker_T.turnPlayer( -1, OMEGA, TIME_STEP);
                blue_striker_T = blue_striker_T.move(TIME_STEP);
                blue_striker_T.updatePos(strikerPlotT);
            elseif(action == "DIVERT_SOUTH")
                blue_striker_T = blue_striker_T.turnPlayer( 1, OMEGA, TIME_STEP);
                %blue_striker_T = blue_striker_T.move(TIME_STEP);
                blue_striker_T.updatePos(strikerPlotT);
            elseif(action == "CLEAR")
                %blue_striker_T.headAngle = blue_striker_T.turnPlayer( "RIGHT", OMEGA, TIME_STEP);
                blue_striker_T = blue_striker_T.move(TIME_STEP);
                blue_striker_T.updatePos(strikerPlotT);
            elseif(action == "PASS")
                blue_striker_T.state = playerState.PASS;
            end
            ball.position = [blue_striker_T.position(1) + 0.2*cos(blue_striker_T.headAngle), blue_striker_T.position(2) + 0.2*sin(blue_striker_T.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
            ball.updatePlot(ballPlotT);

        end

        %%%%%%%%%%%%% PASS %%%%%%%%%%%%%%
        if(blue_striker_T.state == playerState.PASS)
            str_def1 = calcDistBearing(blue_striker_T.position, positionMatrixB(2,:) );
            str_def2 = calcDistBearing(blue_striker_T.position, positionMatrixB(3,:) );
            
            if(str_def1(1) <= str_def2(1))
                if (abs(blue_striker_T.headAngle-str_def1(2)) >  TOLERANCE/2)
                    blue_striker_T =  blue_striker_T.turnPlayer( 1, OMEGA, TIME_STEP);
                    blue_striker_T.updatePos(strikerPlotT);
                    ball.position = [blue_striker_T.position(1) + 0.2*cos(blue_striker_T.headAngle), blue_striker_T.position(2) + 0.2*sin(blue_striker_T.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
                    ball.updatePlot(ballPlotT);
                  
                else
                    ball.velocity             = blue_striker_T.kickBall(ball.mass, "PASS", TIME_STEP);
                    ball.direction            = blue_striker_T.headAngle;
                    blue_striker_T.state      = playerState.ASSIST;
                    ball.possessed            = 0;
                    blue_striker_T.possession = 0;
                    blue_defender1_T.state    = playerState.GET_POSSESSION;
                end
            else
                if (abs(blue_striker_T.headAngle-str_def2(2)) >  TOLERANCE/2)
                    blue_striker_T =  blue_striker_T.turnPlayer( -1, OMEGA, TIME_STEP);
                    blue_striker_T.updatePos(strikerPlotT);
                    ball.position = [blue_striker_T.position(1) + 0.2*cos(blue_striker_T.headAngle), blue_striker_T.position(2) + 0.2*sin(blue_striker_T.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
                    ball.updatePlot(ballPlotT);
                  
                else
                    ball.velocity             = blue_striker_T.kickBall(ball.mass, "PASS", TIME_STEP);
                    ball.direction            = blue_striker_T.headAngle;
                    blue_striker_T.state      = playerState.ASSIST;
                    ball.possessed            = 0;
                    blue_striker_T.possession = 0;
                    blue_defender2_T.state    = playerState.GET_POSSESSION;

                end
            end
        end
        %%%%%%%%%%%%%%%%%% ASSIST %%%%%%%%%%%%%%%%%%%%%
        if(blue_striker_T.state == playerState.ASSIST) 
            if(BALL_POSSESSION == 'R')
                blue_striker_T.state = playerState.GET_POSSESSION;
            end
            
            %% Find player to assist
            assistPlayerDist = [3, 0];
            if(blue_defender1_T.possession ==1)
                assistPlayerDist = calcDistBearing(blue_striker_T.position, blue_defender1_T.position);
            elseif(blue_defender2_T.possession ==1)
                assistPlayerDist = calcDistBearing(blue_striker_T.position, blue_defender2_T.position);
            end
            %% Calculate offside position
            blueSkr_Goal = calcDistBearing(blue_striker_T.position, [1.5, 3+(2)*rand(1)]);
            [offside,~] = min(positionMatrixR(1:3,1)); 
            if(blue_striker_T.position(1) < offside)
                blue_striker_T.headAngle = blue_striker_T.headAngle+ pi/2;
                blue_striker_T           = blue_striker_T.move(TIME_STEP);
                blue_striker_T.updatePos(strikerPlotT);
            end
            if(blueSkr_Goal(1) > TOLERANCE && assistPlayerDist(1) < PLAYER_GAP)
                blue_striker_T.headAngle = blueSkr_Goal(2) - 0.5*rand(1);
                blue_striker_T           = blue_striker_T.move(TIME_STEP);
                blue_striker_T.updatePos(strikerPlotT);

            elseif(assistPlayerDist(1) > PLAYER_GAP && blue_striker_T.position(1) < 8.5)
                blue_striker_T.headAngle = assistPlayerDist(2) - 0.5*rand(1);
                blue_striker_T           = blue_striker_T.move(TIME_STEP);
                blue_striker_T.updatePos(strikerPlotT);
            end

        end

        %%%%%%%%%%%%%%%%%% WAIT %%%%%%%%%%%%%%%%%%%%%%
        if(blue_striker_T.state == playerState.WAIT) 
            blueSkr_Ball = calcDistBearing(blue_striker_T.position, ball.position);

            if(blueSkr_Ball(1) <  TOLERANCE)
                blue_striker_T.possession = 1;
                ball.possessed            = 1;
               % blue_striker_T.state      = playerState.SHOOT;
            end

        end


        %%%%%%%%%%%%%%%%% SHOOT %%%%%%%%%%%%%%%%%%%%%%

        if(blue_striker_T.position(1,1) < 2 && blue_striker_T.possession == 1)
            blue_striker_T.state = playerState.SHOOT;
        end
        
        if(blue_striker_T.state == playerState.SHOOT)
            if(blue_striker_T.position(1,2) < 5.3 && blue_striker_T.position(1,2) > 2.7)
                blue_striker_T.headAngle    = pi + 0.3*rand(1);
                pause(0.1);
                ball.velocity               = blue_striker_T.kickBall(ball.mass, "SHOOT", TIME_STEP);
                ball.direction              = blue_striker_T.headAngle;
                ball.possessed              = 0;
                blue_striker_T.possession   = 0;
                RESET                       = 1;
            end
        end

       %%%%%%%%%%%%% TACKLED %%%%%%%%%%%%%%%
       if(blue_striker_T.state == playerState.TACKLED)
            blue_striker_T.possession   = 0;
            if(BALL_POSSESSION == 'R')
                blue_defender1_T.state = playerState.GET_POSSESSION;
                blue_defender2_T.state = playerState.GET_POSSESSION;
            end
            if(blue_striker_T.counter > 0)
                blue_striker_T.counter = blue_striker_T.counter - 1;
            else 
                if(BALL_POSSESSION == 'B')
                    blue_striker_T.state = playerState.ASSIST;
                else
                    blue_striker_T.state = playerState.GET_POSSESSION;
                end
            end
       end
end
