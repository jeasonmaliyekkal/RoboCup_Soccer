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
red_goalkeeper.drawredTeam()
red_defender1 = Defender(leftDefender1Position,0.275,0);
red_defender1.drawredTeam()
red_defender2 = Defender(leftDefender2Position,0.275,0);
red_defender2.drawredTeam()
red_striker = Striker(leftStrikerPosition,0.275,0);
red_striker.drawredTeam()

blue_goalkeeper = Goalkeeper(rightGoalkeeperPosition,0.275,0);
blue_goalkeeper.drawbuleTeam()
blue_defender1 = Defender(rightDefender1Position,0.275,0);
blue_defender1.drawbuleTeam()
blue_defender2 = Defender(rightDefender2Position,0.275,0);
blue_defender2.drawbuleTeam()
blue_striker = Striker(rightStrikerPosition,0.275,0);
blue_striker.drawbuleTeam()

% Define the teams
leftTeam = {red_goalkeeper, red_defender1, red_defender2, red_striker};
rightTeam = {blue_goalkeeper, blue_defender1, blue_defender2, blue_striker};

% Define the ball
ball = Football2D(ballPosition, ballVelocity,0.2);
ball.draw()
% Initialize the score
scoreLeft = 0;
scoreRight = 0;

%% Run the simulation
timeStep = 0.1;
endTime = 100;


for t = 0:timeStep:endTime
    
    % Move the ball
    ball.move(timeStep);
    
    % Check for collisions with the field boundaries
    ball.bounce(MapLength, MapHeight);
    
    % Check for collisions with the goals
    if ball.isInside(leftGoal)
        scoreRight = scoreRight + 1;
        ball.reset();
    elseif ball.isInside(rightGoal)
        scoreLeft = scoreLeft + 1;
        ball.reset();
    end
    
    % Check for collisions with the players
    for i = 1:numel(leftTeam)
        if leftTeam{i}.isInside(ball.position)
            % If the ball is inside a left team player, bounce off the player
            ball.bounceOffObject(leftTeam{i});
        end
    end
    
    for i = 1:numel(rightTeam)
        if rightTeam{i}.isInside(ball.position)
            % If the ball is inside a right team player, bounce off the player
            ball.bounceOffObject(rightTeam{i});
        end
    end
    
    % Check for collisions with the defenders and strikers
    for i = 1:numel(leftTeam)
        if isa(leftTeam{i}, 'Defender') || isa(leftTeam{i}, 'Striker')
            if leftTeam{i}.isInside(ball.position)
                % If the ball is inside a defender or striker, bounce off the player
                ball.bounceOffObject(leftTeam{i});
            end
        end
    end
    
    for i = 1:numel(rightTeam)
        if isa(rightTeam{i}, 'Defender') || isa(rightTeam{i}, 'Striker')
            if rightTeam{i}.isInside(ball.position)
                % If the ball is inside a defender or striker, bounce off the player
                  ball.bounceOffObject(rightTeam{i});
            end
        end
    end

end

% all players in each team using a for loop, and for each player, 
% check if it's a Defender or Striker using the isa() function. 
% If the player is a defender or striker and the ball is inside the player
% call the bounceOffObject() method of the Ball class, which updates the ball's velocity to bounce off the player.
