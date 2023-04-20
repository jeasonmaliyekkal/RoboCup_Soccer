%% Parameters

TOLERANCE = 0.20;
PLAYER_GAP = 1.5;

%% Define the map
MapLength = 11;
MapHeight = 8;
GoalLength = 3;
GoalHeight = 1;

%% Define player properties
PLAYER_SPEED = 0.5;  %m/s  0.167
OMEGA = 1;       %rads/s
PLAYER_SIZE = 12;    %Marker size



PLAYER_SHAPE = 'o';
PLAYER_OUTLINE = [1, 0, 0];

PLAYER_COLOR_R = [1, 0, 0];
PLAYER_COLOR_B = [0, 0, 1];

%% Define the ball


%% Initial parameters
headingAngleR = [0,0,0,0];
headingAngleB = [pi,pi,pi,pi];



redDefender1Position = [3, MapHeight/3];
redDefender2Position = [3, 2*MapHeight/3];
redGoalkeeperPosition = [1, MapHeight/2];

blueDefender1Position = [MapLength-3, MapHeight/3];
blueDefender2Position = [MapLength-3, 2*MapHeight/3];
blueGoalkeeperPosition = [MapLength-1, MapHeight/2];

% Change striker position based on toss result
if(kickoff_team == "Red")
    redStrikerPosition = [5, MapHeight/2];
    blueStrikerPosition = [MapLength-4.5, MapHeight/2];
else
    redStrikerPosition = [4.5, MapHeight/2];
    blueStrikerPosition = [MapLength-5.5, MapHeight/2];
end

ballPosition = [MapLength/2, MapHeight/2];
ballVelocity = [1, 0];
