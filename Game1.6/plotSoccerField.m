

parameters;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT FIELD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PITCH_COLOR = '#4c8527';
PITCH_LENGTH = 11;
PITCH_WIDTH = 8;
PLAY_LENGTH = 9;
PLAY_WIDTH = 6;
GOAL_LENGTH= 0.6;
GOAL_WIDTH= 2.6;
GOAL_AREA_LENGTH = 1;
GOAL_AREA_WIDTH = 3;
PENALTY_AREA_LENGTH = 2;
PENALTY_AREA_WIDTH = 5;
PENALTY_DISTANCE = 1.5;
CENTER = [PITCH_LENGTH/2, PITCH_WIDTH/2];

LEFT_GOAL_ORIGIN_X = (PITCH_LENGTH-PLAY_LENGTH)/2 - GOAL_LENGTH;
LEFT_GOAL_ORIGIN_Y = PITCH_WIDTH/2 - GOAL_WIDTH/2;
RIGHT_GOAL_ORIGIN_X = (PITCH_LENGTH-PLAY_LENGTH)/2 + PLAY_LENGTH;
RIGHT_GOAL_ORIGIN_Y = PITCH_WIDTH/2 - GOAL_WIDTH/2;
LEFT_GOAL_AREA_ORIGIN_X = (PITCH_LENGTH-PLAY_LENGTH)/2;
LEFT_GOAL_AREA_ORIGIN_Y = PITCH_WIDTH/2 - GOAL_AREA_WIDTH/2;
RIGHT_GOAL_AREA_ORIGIN_X = (PITCH_LENGTH-PLAY_LENGTH)/2 + PLAY_LENGTH - GOAL_AREA_LENGTH;
RIGHT_GOAL_AREA_ORIGIN_Y = PITCH_WIDTH/2 - GOAL_AREA_WIDTH/2;
LEFT_PENALTY_AREA_ORIGIN_X = (PITCH_LENGTH-PLAY_LENGTH)/2;
LEFT_PENALTY_AREA_ORIGIN_Y = PITCH_WIDTH/2 - PENALTY_AREA_WIDTH/2;
RIGHT_PENALTY_AREA_ORIGIN_X = (PITCH_LENGTH-PLAY_LENGTH)/2 + PLAY_LENGTH - PENALTY_AREA_LENGTH;
RIGHT_PENALTY_AREA_ORIGIN_Y = PITCH_WIDTH/2 - PENALTY_AREA_WIDTH/2;
LEFT_PENALTY_X = (PITCH_LENGTH-PLAY_LENGTH)/2 + PENALTY_DISTANCE;
RIGHT_PENALTY_X = (PITCH_LENGTH-PLAY_LENGTH)/2 + PLAY_LENGTH - PENALTY_DISTANCE;
LEFT_PENALTY_Y = PITCH_WIDTH/2;
RIGHT_PENALTY_Y = PITCH_WIDTH/2;

%f = figure(1);
%f.Resize = 'off';
figure(1); clf;
hold on;

set(gca,'XTick',[], 'YTick', [],'Color',PITCH_COLOR);
title('RoboCup Soccer');
axis([0 PITCH_LENGTH 0 PITCH_WIDTH]);


%playable area
rectangle('Position', [1 1 PLAY_LENGTH PLAY_WIDTH],'LineWidth', 2, 'EdgeColor','w');

%left goal
rectangle('Position', [LEFT_GOAL_ORIGIN_X LEFT_GOAL_ORIGIN_Y GOAL_LENGTH GOAL_WIDTH],'LineWidth', 3, 'EdgeColor','w');

%right goal
rectangle('Position', [RIGHT_GOAL_ORIGIN_X RIGHT_GOAL_ORIGIN_Y GOAL_LENGTH GOAL_WIDTH],'LineWidth', 3, 'EdgeColor','w');

%left goal area
rectangle('Position', [LEFT_GOAL_AREA_ORIGIN_X LEFT_GOAL_AREA_ORIGIN_Y GOAL_AREA_LENGTH GOAL_AREA_WIDTH],'LineWidth', 2, 'EdgeColor','w');

%right goal area
rectangle('Position', [RIGHT_GOAL_AREA_ORIGIN_X RIGHT_GOAL_AREA_ORIGIN_Y GOAL_AREA_LENGTH GOAL_AREA_WIDTH],'LineWidth', 2, 'EdgeColor','w');

%left penlaty area
rectangle('Position', [LEFT_PENALTY_AREA_ORIGIN_X LEFT_PENALTY_AREA_ORIGIN_Y PENALTY_AREA_LENGTH PENALTY_AREA_WIDTH],'LineWidth', 2, 'EdgeColor','w');

%right goal area
rectangle('Position', [RIGHT_PENALTY_AREA_ORIGIN_X RIGHT_PENALTY_AREA_ORIGIN_Y PENALTY_AREA_LENGTH PENALTY_AREA_WIDTH],'LineWidth', 2, 'EdgeColor','w');

%left penalty spot
plot(LEFT_PENALTY_X, LEFT_PENALTY_Y,'+',Color='w',LineWidth=2, MarkerSize=10)

%right penalty spot
plot(RIGHT_PENALTY_X, RIGHT_PENALTY_Y,'+',Color='w',LineWidth=2, MarkerSize=10)

%center circle
viscircles(CENTER,0.75, Color='w', LineWidth=1);

%center point
plot(CENTER(1), CENTER(2),'+',Color='w',LineWidth=2, MarkerSize=10)

%center line
plot([CENTER(1),CENTER(1)],[(PITCH_LENGTH-PLAY_LENGTH)/2,(PITCH_LENGTH-PLAY_LENGTH)/2+ PLAY_WIDTH], Color='w', LineWidth=2);




%%%%%%%%%%%%%%%%%%%%%%%%%%% GENERATE PLOT OBJECTS FOR PLAYERS AND BALL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Ball plot

ball = Football2D(ballPosition, 0.2);
ballPlot = ball.draw();

%% RED TEAM
red_striker = Player(redStrikerPosition, PLAYER_SIZE, PLAYER_SPEED, headingAngleR(1), PLAYER_COLOR_R);
strikerPlot = red_striker.initializeBot();

red_defender1 = Player(redDefender1Position, PLAYER_SIZE, PLAYER_SPEED, headingAngleR(1), PLAYER_COLOR_R);
defender1Plot = red_defender1.initializeBot();

red_defender2 = Player(redDefender2Position, PLAYER_SIZE, PLAYER_SPEED, headingAngleR(1), PLAYER_COLOR_R);
defender2Plot = red_defender2.initializeBot();

red_gk = Player(redGoalkeeperPosition, PLAYER_SIZE, PLAYER_SPEED, headingAngleR(1), PLAYER_COLOR_R);
red_gkPlot = red_gk.initializeBot();

%% BLUE TEAM

blue_striker = Player(blueStrikerPosition, PLAYER_SIZE, PLAYER_SPEED, headingAngleB(1), PLAYER_COLOR_B);
blue_strikerPlot = blue_striker.initializeBot();

blue_defender1 = Player(blueDefender1Position, PLAYER_SIZE, PLAYER_SPEED, headingAngleB(1), PLAYER_COLOR_B);
blue_defender1Plot = blue_defender1.initializeBot();

blue_defender2 = Player(blueDefender2Position, PLAYER_SIZE, PLAYER_SPEED, headingAngleB(1), PLAYER_COLOR_B);
blue_defender2Plot = blue_defender2.initializeBot();

blue_gk = Player(blueGoalkeeperPosition, PLAYER_SIZE, PLAYER_SPEED, headingAngleB(1), PLAYER_COLOR_B);
blue_gkPlot = blue_gk.initializeBot();
