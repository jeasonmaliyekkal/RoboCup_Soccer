function playerT = headAngleCorrection(playerT)

    if(playerT.headAngle > pi)
        playerT.headAngle = playerT.headAngle - 2*pi;
    elseif(playerT.headAngle < -pi)
        playerT.headAngle = playerT.headAngle + 2*pi;
    end

end