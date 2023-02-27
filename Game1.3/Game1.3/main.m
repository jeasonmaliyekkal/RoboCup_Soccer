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
timeStep = 0.1;
endTime = 100;

for t = 0:timeStep:endTime
    frame = getframe(gca);
    ball_pos = ball.position;
    leftStriker_pos = red_striker.position;
    left_defender1_pos = red_defender1.position;
    left_defender2_pos = red_defender2.position;
    left_goalkeeper_pos = red_goalkeeper.position;

    rightStriker_pos = blue_striker.position;
    right_defender1_pos = blue_defender1.position;
    right_defender2_pos = blue_defender2.position;
    right_goalkeeper_pos = blue_goalkeeper.position;
    
    x1 = 2.5*rand(1)-1;
    y1 = 2.5*rand(1)-1;
    set(blue_strikerPos, 'XData', rightStriker_pos(1)+timeStep*x1, 'YData',rightStriker_pos(2)+timeStep*y1);
    blue_striker.position = [rightStriker_pos(1)+timeStep*x1, rightStriker_pos(2)+timeStep*y1];
    
    x2 = 2.5*rand(1)-1;
    y2 = 2.5*rand(1)-1;
    set(blue_defender1Pos, 'XData', right_defender1_pos(1)+timeStep*x2, 'YData',right_defender1_pos(2)+timeStep*y2);
    blue_defender1.position = [right_defender1_pos(1)+timeStep*x2, right_defender1_pos(2)+timeStep*y2];

    x3 = 2.5*rand(1)-1;
    y3 = 2.5*rand(1)-1;
    set(blue_defender2Pos, 'XData', right_defender2_pos(1)+timeStep*x3, 'YData',right_defender2_pos(2)+timeStep*y3);
    blue_defender2.position = [right_defender2_pos(1)+timeStep*x3, right_defender2_pos(2)+timeStep*y3];

    x4 = 3*rand(1);
    y4 = 2*rand(1)-1;
    if left_defender1_pos(1) >= 9
        x4=0.02*(rand(1)-1);
    end
    set(red_defender1Pos, 'XData', left_defender1_pos(1)+timeStep*x4, 'YData',left_defender1_pos(2)+timeStep*y4);
    red_defender1.position = [left_defender1_pos(1)+timeStep*x4, left_defender1_pos(2)+timeStep*y4];

    x5 = 3*rand(1);
    y5 = 2*rand(1)-1;
    if left_defender2_pos(1) >= 9
        x5=0.02*(rand(1)-1);
    end
    set(red_defender2Pos, 'XData', left_defender2_pos(1)+timeStep*x5, 'YData',left_defender2_pos(2)+timeStep*y5);
    red_defender2.position = [left_defender2_pos(1)+timeStep*x5, left_defender2_pos(2)+timeStep*y5];

    y6 = 2*rand(1)-1;
    set(blue_goalkeeperPos, 'XData', right_goalkeeper_pos(1), 'YData',right_goalkeeper_pos(2)+timeStep*y6);
    blue_goalkeeper.position = [right_goalkeeper_pos(1), right_goalkeeper_pos(2)+timeStep*y6];


    if red_striker.position(1)< 5.1
        set(red_strikerPos, 'XData', leftStriker_pos(1)+timeStep*1, 'YData',4);
        red_striker.position = [leftStriker_pos(1)+timeStep*1, leftStriker_pos(2)];
    end

    if red_striker.position(1) >= 5.1 && red_striker.position(1) < 7.5
        set(ballPos, 'XData', ball_pos(1)+timeStep*1, 'YData',4)
        set(red_strikerPos, 'XData', leftStriker_pos(1)+timeStep*1, 'YData',4);
        ball.position = [ball_pos(1)+timeStep*1, 4];
        red_striker.position = [leftStriker_pos(1)+timeStep*1, leftStriker_pos(2)];
    end

    if red_striker.position(1) >= 7.5
        set(ballPos, 'XData', ball_pos(1)+timeStep*1, 'YData',4)
        ball.position = [ball_pos(1)+timeStep*1, 4];
        if ball.position(1) >= 10.5
            fprintf("ball in")
            return
        end
    end

    drawnow
    pause(0.2);
end



% all players in each team using a for loop, and for each player, 
% check if it's a Defender or Striker using the isa() function. 
% If the player is a defender or striker and the ball is inside the player
% call the bounceOffObject() method of the Ball class, which updates the ball's velocity to bounce off the player.
