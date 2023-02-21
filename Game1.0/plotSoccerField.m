%To Plot Soccer field


function  plotSoccerField

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Added by Athul, Ball definition

%ballPlot = [];
% BALL_MARKER_SIZE = 11; 
% BALL_COLOR = [1,1,0];
% BALL_OUTLINE = [1, 1, 0];
% BALL_SHAPE = 'o';
% 
% %% Red Team
% PLAYER_SHAPE = 'o';
% PLAYER_OUTLINE = [1, 0, 0];
% PLAYER_COLOR = [1, 0, 0];
% PLAYER_MARKER_SIZE = 15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

f = figure();
f.Resize = 'off';

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ball plot

% ballPlot = plot(CENTER(1), CENTER(2));
% set(ballPlot, 'Marker', BALL_SHAPE);
% set(ballPlot, 'MarkerEdgeColor', BALL_OUTLINE);
% set(ballPlot, 'MarkerFaceColor', BALL_COLOR);
% set(ballPlot, 'MarkerSize', BALL_MARKER_SIZE);
% 
% 
% strikerPlot = plot(CENTER(1)-0.75,CENTER(2));
% set(strikerPlot, 'Marker', PLAYER_SHAPE);
% set(strikerPlot, 'MarkerEdgeColor', PLAYER_OUTLINE);
% set(strikerPlot, 'MarkerFaceColor', PLAYER_COLOR);
% set(strikerPlot, 'MarkerSize', PLAYER_MARKER_SIZE);
% 
% defender1Plot = plot(CENTER(1)-2.2,LEFT_PENALTY_Y-1.8);
% set(defender1Plot, 'Marker', PLAYER_SHAPE);
% set(defender1Plot, 'MarkerEdgeColor', PLAYER_OUTLINE);
% set(defender1Plot, 'MarkerFaceColor', PLAYER_COLOR);
% set(defender1Plot, 'MarkerSize', PLAYER_MARKER_SIZE);
% 
% defender2Plot = plot(CENTER(1)-2.2,LEFT_PENALTY_Y+1.8);
% set(defender2Plot, 'Marker', PLAYER_SHAPE);
% set(defender2Plot, 'MarkerEdgeColor', PLAYER_OUTLINE);
% set(defender2Plot, 'MarkerFaceColor', PLAYER_COLOR);
% set(defender2Plot, 'MarkerSize', PLAYER_MARKER_SIZE);
% 
% goaliePlot = plot(LEFT_PENALTY_AREA_ORIGIN_X+ 0.1,CENTER(2));
% set(goaliePlot, 'Marker', PLAYER_SHAPE);
% set(goaliePlot, 'MarkerEdgeColor', PLAYER_OUTLINE);
% set(goaliePlot, 'MarkerFaceColor', PLAYER_COLOR);
% set(goaliePlot, 'MarkerSize', PLAYER_MARKER_SIZE)


%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  hold off;



% function game 
% 
% 
% pause(1)
% for i = 1: 100 
% 
% set(ballPlot, 'XData', 5.5 +i/10, 'YData', 4+i/10);
% drawnow
% pause(0.1);
% end
% 
% end
% game;
% 
% shapeObj = [ballPlot, strikerPlot, defender1Plot, defender2Plot, goaliePlot];
% end