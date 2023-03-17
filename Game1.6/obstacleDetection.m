function action = obstacleDetection(curPos, headingAngle, positionMatrix, tag)

action = "CONTINUE";
flag = 0;
if(tag == "RED")
    for i = 1:4
        val = calcDistBearing(curPos,positionMatrix(i,:));
        if(val(1) < 1.5 && abs(abs(val(2)-headingAngle)) < 0.35)
            action = "PASS";
            break;
        elseif (val(1) < 1.8 && abs(val(2)-headingAngle) < 0.35 && curPos(2)<=positionMatrix(i,2) )
            action = "DIVERT_RIGHT";
            flag = 1;
            
        elseif (val(1) < 1.8 && abs(val(2)-headingAngle) < 0.35 && curPos(2)>positionMatrix(i,2) )
            action = "DIVERT_LEFT";
            flag = 1;
        elseif (val(1) < 1.8 && curPos(1)<positionMatrix(i,1))
            action = "CLEAR";
            flag = 1;
        elseif(flag == 0)
            action = "CONTINUE";
        end
    end


end
