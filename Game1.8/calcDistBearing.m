function val = calcDistBearing(pos1,pos2)


distance = norm(pos1-pos2);

headingAngle = atan2(pos2(2)-pos1(2), pos2(1)-pos1(1));

val = [distance,headingAngle];

end