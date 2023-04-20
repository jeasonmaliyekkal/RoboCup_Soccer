%To Plot Soccer field
clear;

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

figure();
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
%add ball in center
rectangle('Position', [CENTER(1)-0.2,CENTER(2)-0.2,0.4,0.4], 'Curvature', [1 1], 'FaceColor', 'y');

c = [LEFT_PENALTY_AREA_ORIGIN_X,LEFT_PENALTY_AREA_ORIGIN_Y] ;   % center of circle


%goal keeper
rectangle('Position', [LEFT_PENALTY_AREA_ORIGIN_X-0.2,LEFT_PENALTY_Y-0.2,0.4,0.4], 'Curvature', [0.5 0.5], 'FaceColor', 'r');
% striker
rectangle('Position', [CENTER(1)-1,LEFT_PENALTY_Y-0.2,0.4,0.4], 'Curvature', [0.5 0.5], 'FaceColor', 'r');
%Defender1
rectangle('Position', [CENTER(1)-2.2,LEFT_PENALTY_Y-1.8,0.4,0.4], 'Curvature', [0.5 0.5], 'FaceColor', 'r');
%Defender2
rectangle('Position', [CENTER(1)-2.2,LEFT_PENALTY_Y+1.8,0.4,0.4], 'Curvature', [0.5 0.5], 'FaceColor', 'r');


hold off;
