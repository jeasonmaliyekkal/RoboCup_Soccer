% Define the positions of the players and the ball
leftGoalkeeperPosition = [1, fieldHeight/2];
leftDefender1Position = [3, fieldHeight/3];
leftDefender2Position = [3, 2*fieldHeight/3];
leftStrikerPosition = [6, fieldHeight/2];
rightGoalkeeperPosition = [fieldWidth-1, fieldHeight/2];
rightDefender1Position = [fieldWidth-3, fieldHeight/3];
rightDefender2Position = [fieldWidth-3, 2*fieldHeight/3];
rightStrikerPosition = [fieldWidth-6, fieldHeight/2];
ballPosition = [fieldWidth/2, fieldHeight/2];
ballVelocity = [1, 0];

% Define the teams
leftTeam = {Goalkeeper(leftGoalkeeperPosition,0.5,0), Defender(leftDefender1Position,0.5,0), Defender(leftDefender2Position,0.5,0), Striker(leftStrikerPosition,0.5,0)};
leftTeam