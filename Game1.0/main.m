% Define the field
fieldWidth = 12;
fieldHeight = 9;
goalWidth = 2;
goalHeight = 3;

% Create the field and goals as rectangles
plotSoccerField()

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
rightTeam = {Goalkeeper(rightGoalkeeperPosition,0.5,0), Defender(rightDefender1Position,0.5,0), Defender(rightDefender2Position,0.5,0), Striker(rightStrikerPosition,0.5,0)};

% Define the ball
ball = Football2D(ballPosition, ballVelocity,0.5);

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
    ball.bounceOffWalls(fieldWidth, fieldHeight);
    
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
