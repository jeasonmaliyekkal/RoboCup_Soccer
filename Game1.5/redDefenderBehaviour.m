function red_defender_T =  redDefenderBehaviour(red_defender_T, ball, TOLERANCE, PLAYER_GAP, TIME_STEP,OMEGA, defenderPlotT, positionMatrixR, positionMatrixB)

    if(red_defender_T.state == playerState.ASSIST) 
            redDef1_skr = calcDistBearing(red_defender_T.position, positionMatrixR(1,:));
            
            if(redDef1_skr(1) > PLAYER_GAP)
                red_defender_T.headAngle = redDef1_skr(2) + 0.5*rand(1);
                red_defender_T           = red_defender_T.move(TIME_STEP);
                red_defender_T.updatePos(defenderPlotT);
            end
     end
            redDef2_skr = calcDistBearing(red_defender_T.position, positionMatrixR(1,:));


end