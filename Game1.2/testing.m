clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%this file only for testing classes%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%To use the ball class, can create a Ball object and call its methods, below is an example%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a Football2D object with position [0, 0], velocity [1, 1], and radius 0.5
football = Football2D([0, 0], [1, 1], 0.5);

% Move the football for 0.1 seconds and then bounce it off a 2D box with dimensions [10, 10]
dt = 0.1;
dim = [10, 10];
for i = 1:100
    football.move(dt);
    football.bounce(dim);
    clf;
    hold on;
    axis([0, dim(1), 0, dim(2)]);
    football.draw();
    pause(0.01);
end

% Kick the football in the y direction with a speed of 2
dir = [0, 1];
speed = 2;
football.kick(dir, speed);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%To use the Goalkeeper class, can create a Goalkeeper object and call its methods, below is an example%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a Goalkeeper object with position [5, 5], radius 0.5, and speed 2
goalkeeper = Goalkeeper([5, 5], 0.5, 2);

% Move the goalkeeper towards a target position [8, 8] for 0.1 seconds
dt = 0.1;
target = [8, 8];
for i = 1:100
    goalkeeper.moveTowards(target, dt);
    clf;
    hold on;
    axis([0, 10, 0, 10]);
    goalkeeper.draw();
    pause(0.01);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%To use the Defender class, can create a Defender object and call its methods, below is an example%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a Defender object with position [3, 3], radius 0.5, and speed 1.5
defender = Defender([3, 3], 0.5, 1.5);

% Move the defender towards a target position [6, 6] for 0.1 seconds
dt = 0.1;
target = [6, 6];
for i = 1:100
    defender.moveTowards(target, dt);
    clf;
    hold on;
    axis([0, 10, 0, 10]);
    defender.draw();
    pause(0.01);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%To use the Striker class, can create a Striker object and call its methods, below is an example%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a Striker object with position [3, 3], radius 0.5, and speed 1.5
striker = Striker([3, 3], 0.5, 1.5);

% Move the striker towards a target position [6, 6] for 0.1 seconds
dt = 0.1;
target = [6, 6];
for i = 1:100
    striker.moveTowards(target, dt);
    clf;
    hold on;
    axis([0, 10, 0, 10]);
    striker.draw();
    ball.draw();
    pause(0.01);
end

% Kick the ball towards a target position [9, 9] with a power of 2.0
power = 2.0;
target = [9, 9];
striker.kickTowards(target, power);























