clc;
clear;

% Define the map
MapLength = 11;
MapHeight = 8;
GoalLength = 3;
GoalHeight = 1;
% PITCH_LENGTH = 11;
% PITCH_WIDTH = 8;
% PLAY_LENGTH = 9;
% PLAY_WIDTH = 6;
% GOAL_AREA_LENGTH = 1;
% GOAL_AREA_WIDTH = 3;

% Create the field and goals as rectangles
plotSoccerField()

% Define the positions of the players and the ball
leftGoalkeeperPosition = [1, MapHeight/2];
leftDefender1Position = [3, MapHeight/3];
leftDefender2Position = [3, 2*MapHeight/3];
leftStrikerPosition = [4.5, MapHeight/2];
rightGoalkeeperPosition = [MapLength-1, MapHeight/2];
rightDefender1Position = [MapLength-3, MapHeight/3];
rightDefender2Position = [MapLength-3, 2*MapHeight/3];
rightStrikerPosition = [MapLength-4.5, MapHeight/2];
ballPosition = [MapLength/2, MapHeight/2];
ballVelocity = [1, 0];


red_goalkeeper= Goalkeeper(leftGoalkeeperPosition,0.275,0);
red_goalkeeperPos = red_goalkeeper.drawredTeam()
red_defender1 = Defender(leftDefender1Position,0.275,0);
red_defender1Pos = red_defender1.drawredTeam()
red_defender2 = Defender(leftDefender2Position,0.275,0);
red_defender2Pos = red_defender2.drawredTeam()
red_striker = Striker(leftStrikerPosition,0.275,0);
red_strikerPos = red_striker.drawredTeam()

blue_goalkeeper = Goalkeeper(rightGoalkeeperPosition,0.275,0);
blue_goalkeeperPos = blue_goalkeeper.drawbuleTeam()
blue_defender1 = Defender(rightDefender1Position,0.275,0);
blue_defender1Pos = blue_defender1.drawbuleTeam()
blue_defender2 = Defender(rightDefender2Position,0.275,0);
blue_defender2Pos = blue_defender2.drawbuleTeam()
blue_striker = Striker(rightStrikerPosition,0.275,0);
blue_strikerPos = blue_striker.drawbuleTeam()

% Define the teams
leftTeam = {red_goalkeeper, red_defender1, red_defender2, red_striker};
rightTeam = {blue_goalkeeper, blue_defender1, blue_defender2, blue_striker};

% Define the ball
ball = Football2D(ballPosition, ballVelocity,0.2);
ballPos = ball.draw()
% Initialize the score
scoreLeft = 0;
scoreRight = 0;
pause(5);
%% Run the simulation
timeStep = 1;
endTime = 100;
for t = 0:timeStep:endTime
%     frame = getframe(gca);
    %下面是进行动画的example，我是随机让一些点进行改变 然后动画展示，还有范围限制我还没考虑，时间来不及
    %我先发给你动画效果。
    x1 = randi([1 7])   %random position,先随机位置。后面具体在什么位置通过算法进行计算
    y1 = randi([1 5])
    set(ballPos, 'XData', x1, 'YData',y1)
    x2 = randi([1 3])   %random position,先随机位置。后面具体在什么位置通过算法进行计算
    y2 = randi([1 4])
    set(red_goalkeeperPos, 'XData', x2, 'YData',y2)
    x3 = randi([1 10])  %random position,先随机位置。后面具体在什么位置通过算法进行计算
    y3 = randi([1 10])
    set(blue_goalkeeperPos, 'XData', x3, 'YData',y3)
    x4 = randi([1 10])
    y4 = randi([1 10])
    set(red_defender1Pos, 'XData', x4, 'YData',y4)
    x5 = randi([1 10])
    y5 = randi([1 10])
    set(blue_defender1Pos, 'XData', x5, 'YData',y5)
    drawnow
    pause(0.2);
end



% all players in each team using a for loop, and for each player, 
% check if it's a Defender or Striker using the isa() function. 
% If the player is a defender or striker and the ball is inside the player
% call the bounceOffObject() method of the Ball class, which updates the ball's velocity to bounce off the player.
