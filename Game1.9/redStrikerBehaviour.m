function [red_striker_T, red_defender1_T, red_defender2_T, blue_striker_T, blue_defender1_T, blue_defender2_T,  ball, BALL_POSSESSION, RESET] =  redStrikerBehaviour(red_striker_T, red_defender1_T, red_defender2_T, blue_striker_T, blue_defender1_T, blue_defender2_T,  ball, ballPlotT, BALL_POSSESSION, TOLERANCE, PLAYER_GAP, TIME_STEP,OMEGA, strikerPlotT, positionMatrixR, positionMatrixB, RESET )  
         
         %%%%%%%%%%%%%%%%% GET POSSESSION %%%%%%%%%%%%%%%%%%%
         if(BALL_POSSESSION == 'B' && red_striker_T.state ~= playerState.TACKLED && red_striker_T.state ~= playerState.WAIT)
             red_striker_T.state = playerState.GET_POSSESSION;
         end
         if(BALL_POSSESSION == 'R' && red_striker_T.possession == 0 && ball.possessed == 1)
             red_striker_T.state = playerState.ASSIST;
         end

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
                    BALL_POSSESSION          = 'R';
                    red_striker_T.state      = playerState.DRIBBLE;
                else
                    red_striker_T.state      = playerState.TACKLE;
                    red_striker_T.counter    = 10;
                    
                    tackledPlayer             = tackle(red_striker_T.position, positionMatrixB);
                    switch(tackledPlayer)
                        case(1)
                            blue_striker_T.state     = playerState.TACKLED;
                            blue_striker_T.counter   = 30;
                        case(2)
                            blue_defender1_T.state   = playerState.TACKLED;
                            blue_defender1_T.counter = 30;
                        case(3)
                            blue_defender2_T.state   = playerState.TACKLED;
                            blue_defender2_T.counter = 30;
                    end

                    BALL_POSSESSION          = 'R';                    
                    ball.possessed           = 0;
                    red_striker_T.possession = 1;
                    ball.possessed           = 1;
                    red_striker_T.state      = playerState.DRIBBLE;

                end
            end
         end


         %%%%%%%%%%%%%%%%% DRIBBLE %%%%%%%%%%%%%%%%%%%%%
        if(red_striker_T.state == playerState.DRIBBLE)
            if(red_striker_T.counter > 0)  
                action = "CONTINUE";
                red_striker_T.counter = red_striker_T.counter - 1;
            else
            action = obstacleDetection(red_striker_T.position, red_striker_T.headAngle, positionMatrixB, "RED");
            end
            if(action == "CONTINUE")
                redSkr_Goal = calcDistBearing(red_striker_T.position, [9.5, 3+(2)*rand(1)]);
                if(redSkr_Goal(1) > TOLERANCE)
                    red_striker_T.headAngle = redSkr_Goal(2);
                    red_striker_T           = red_striker_T.move(TIME_STEP);
                    red_striker_T.updatePos(strikerPlotT);
                end
            elseif(action == "DIVERT_NORTH")
                red_striker_T = red_striker_T.turnPlayer( 1, OMEGA, TIME_STEP);
                red_striker_T = red_striker_T.move(TIME_STEP);
                red_striker_T.updatePos(strikerPlotT);
            elseif(action == "DIVERT_SOUTH")
                red_striker_T = red_striker_T.turnPlayer( -1, OMEGA, TIME_STEP);
                %red_striker_T = red_striker_T.move(TIME_STEP);
                red_striker_T.updatePos(strikerPlotT);
            elseif(action == "CLEAR")
                %red_striker_T.headAngle = red_striker_T.turnPlayer( "RIGHT", OMEGA, TIME_STEP);
                red_striker_T = red_striker_T.move(TIME_STEP);
                red_striker_T.updatePos(strikerPlotT);
            elseif(action == "PASS")
                red_striker_T.state = playerState.PASS;
            end
        ball.position = [red_striker_T.position(1) + 0.2*cos(red_striker_T.headAngle), red_striker_T.position(2) + 0.2*sin(red_striker_T.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
        ball.updatePlot(ballPlotT);


        end

        %%%%%%%%%%%%% PASS %%%%%%%%%%%%%%
        if(red_striker_T.state == playerState.PASS)
            str_def1 = calcDistBearing(red_striker_T.position, positionMatrixR(2,:) );
            str_def2 = calcDistBearing(red_striker_T.position, positionMatrixR(3,:) );
            
            if(str_def1(1) <= str_def2(1))
                if (red_striker_T.headAngle-str_def1(2) >  TOLERANCE/10)
                    red_striker_T =  red_striker_T.turnPlayer( -1, OMEGA, TIME_STEP);
                    red_striker_T.updatePos(strikerPlotT);
                    ball.position = [red_striker_T.position(1) + 0.2*cos(red_striker_T.headAngle), red_striker_T.position(2) + 0.2*sin(red_striker_T.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
                    ball.updatePlot(ballPlotT);
                  
                else
                    ball.velocity            = red_striker_T.kickBall(ball.mass, "PASS", TIME_STEP);
                    ball.direction           = red_striker_T.headAngle;
                    red_striker_T.state      = playerState.ASSIST;
                    ball.possessed           = 0;
                    red_striker_T.possession = 0;
                    red_defender1_T.state    = playerState.GET_POSSESSION;

                end
            else
                if (red_striker_T.headAngle-str_def2(2) >  TOLERANCE/10)
                    red_striker_T =  red_striker_T.turnPlayer( -1, OMEGA, TIME_STEP);
                    red_striker_T.updatePos(strikerPlotT);
                    ball.position = [red_striker_T.position(1) + 0.2*cos(red_striker_T.headAngle), red_striker_T.position(2) + 0.2*sin(red_striker_T.headAngle)];  % 0.2 -> Robot radius, to plot the ball at the end of circle
                    ball.updatePlot(ballPlotT);
                  
                else
                    ball.velocity            = red_striker_T.kickBall(ball.mass, "PASS", TIME_STEP);
                    ball.direction           = red_striker_T.headAngle;
                    red_striker_T.state      = playerState.ASSIST;
                    ball.possessed           = 0;
                    red_striker_T.possession = 0;
                    red_defender2_T.state    = playerState.GET_POSSESSION;

                end
            end
        end
        %%%%%%%%%%%%%%%%%% ASSIST %%%%%%%%%%%%%%%%%%%%%
        if(red_striker_T.state == playerState.ASSIST) 
            if(BALL_POSSESSION == 'B')
                red_striker_T.state = playerState.GET_POSSESSION;
            end
            
            %% Find player to assist
            assistPlayerDist = [0,0];
            if(red_defender1_T.possession ==1)
                assistPlayerDist = calcDistBearing(red_striker_T.position, red_defender1_T.position);
            elseif(blue_defender2_T.possession ==1)
                assistPlayerDist = calcDistBearing(red_striker_T.position, red_defender2_T.position);
            end
            %% Calculate offside position
            redSkr_Goal = calcDistBearing(red_striker_T.position, [9.5, 3+(2)*rand(1)]);
            [offside,~] = max(positionMatrixB(1:3,1)); 

            if(red_striker_T.position(1) < offside && redSkr_Goal(1) > TOLERANCE && assistPlayerDist(1) < PLAYER_GAP)
                red_striker_T.headAngle = redSkr_Goal(2) - 0.5*rand(1);
                red_striker_T           = red_striker_T.move(TIME_STEP);
                red_striker_T.updatePos(strikerPlotT);
            elseif(assistPlayerDist(1) > PLAYER_GAP)
                red_striker_T.headAngle = assistPlayerDist(2) - 0.5*rand(1);
                red_striker_T           = red_striker_T.move(TIME_STEP);
                red_striker_T.updatePos(strikerPlotT);
            end

        end

        %%%%%%%%%%%%%%%%%%%% WAIT %%%%%%%%%%%%%%%%%%%%%%
        if(red_striker_T.state == playerState.WAIT) 
            if(red_striker_T.counter > 0)
                red_striker_T.counter = red_striker_T.counter - 1;
            elseif(BALL_POSSESSION == 'R')
                red_striker_T.state = playerState.ASSIST;
            else
                red_striker_T.state = playerState.GET_POSSESSION;
            end
        end


        %%%%%%%%%%%%%%%%%%%% SHOOT %%%%%%%%%%%%%%%%%%%%%

        if(red_striker_T.position(1,1) > 9 && red_striker_T.possession == 1)
            red_striker_T.state = playerState.SHOOT;
        end
        
        if(red_striker_T.state == playerState.SHOOT)
            if(red_striker_T.position(1,2) < 5.3 && red_striker_T.position(1,2) > 2.7)
                red_striker_T.headAngle = 0.3*rand(1);
                %pause(0.1);
                ball.velocity            = red_striker_T.kickBall(ball.mass, "SHOOT", TIME_STEP);
                ball.direction           = red_striker_T.headAngle;
                ball.possessed           = 0;
                red_striker_T.possession = 0;
                red_striker_T.counter    = 10;
                %red_striker_T.state      = playerState.WAIT;
                RESET                    = 1;
            end
        end
       %%%%%%%%%%%%%%%%%% TACKLED %%%%%%%%%%%%%%%%%%%%%%
       if(red_striker_T.state == playerState.TACKLED)
           red_striker_T.possession   = 0;
            if(BALL_POSSESSION == 'B')
                red_defender1_T.state = playerState.GET_POSSESSION;
                %red_defender2_T.state = playerState.GET_POSSESSION;
            end
            if(red_striker_T.counter > 0)
                red_striker_T.counter = red_striker_T.counter - 1;
            else
                if(BALL_POSSESSION == 'R')
                    red_striker_T.state = playerState.ASSIST;
                else
                    red_striker_T.state = playerState.GET_POSSESSION;
                end
            end
       end
        

end
