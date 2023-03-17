clc;
clear;

plotSoccerField;

%% Simulation setup
simulationTime = 15;
stepSize = 0.05;
% frame_rate = PLAYER_SPEED;
TIME_STEP = 0.1;


% Initialize the score
scoreLeft = 0;
scoreRight = 0;

%% Run the simulation

simSteps = simulationTime/stepSize;
game = 1;
flag = 1;

for t = 1:simSteps
    
    positionMatrixR = [red_striker.position; red_defender1.position; red_defender2.position; red_gk.position];
    positionMatrixB = [blue_striker.position; blue_defender1.position; blue_defender2.position; blue_gk.position];

    if(game ==1)

        %% Set the state at the start of the game
        if(flag==1)
            red_striker.state   = playerState.GET_POSSESSION;
            red_defender1.state = playerState.ASSIST;
            red_defender2.state = playerState.ASSIST;
            red_gk.state        = playerState.WAIT;
            flag = 0;
        end
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%% %%

        %% RED STRIKER BEHAVIOUR
        [red_striker, red_defender1, red_defender2, ball]   = redStrikerBehaviour(red_striker, red_defender1, red_defender2, ball, ballPlot, TOLERANCE, TIME_STEP, OMEGA, strikerPlot, positionMatrixR, positionMatrixB);
        %% RED DEFENDER1 BEHAVIOUR
        [red_striker, red_defender1, ball]  = redDefenderBehaviour(red_striker, red_defender1, ball, ballPlot, TOLERANCE, PLAYER_GAP, TIME_STEP, OMEGA, defender1Plot, positionMatrixR,positionMatrixB);
        %% RED DEFENDER2 BEHAVIOUR
        if(t > 20)
        [red_striker, red_defender2, ball]  = redDefenderBehaviour(red_striker, red_defender2, ball, ballPlot, TOLERANCE, PLAYER_GAP, TIME_STEP, OMEGA, defender2Plot, positionMatrixR,positionMatrixB);
        end
       

        if(ball.velocity > 0 && ball.possessed == 0)
            ball = ball.calcPhysics(TIME_STEP);
            ball.updatePlot(ballPlot);
        elseif(ball.velocity ~= 0 && ball.possessed == 1)
            ball.velocity = 0;
        end

    end
ball
red_striker;
red_defender1;
pause(TIME_STEP);
end