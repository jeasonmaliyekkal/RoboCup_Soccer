clc;
clear;

%% Simulate a coin toss
if rand() < 0.5
    kickoff_team = 'Red';
else
    kickoff_team = 'Blue';
end
plotSoccerField;

%% Simulation setup
simulationTime = 15;
stepSize = 0.05;
% frame_rate = PLAYER_SPEED;
TIME_STEP = 0.1;


% Initialize the score
scoreLeft = 0;
scoreRight = 0;

% Dimension for text box to print score
dim = [.52 .9 0 0];

%% Run the simulation

simSteps = simulationTime/stepSize;
game = 1;
flag = 1;
RESET = 0;

temp = 0;
BALL_POSSESSION = 'N';
for t = 1:simSteps
    
     % title delayed to show who got toss
    if(t<75)
        title(sprintf("Robocup Soccer\n%s won the toss and chose to kickoff",kickoff_team));
    else
        title("Robocup Soccer");
    end
    
    % Print scores
    score_str = sprintf('%s %d : %d %s', "Team Red", scoreLeft, scoreRight, "Team Blue");
    annotation('textbox',dim,'String',score_str,'FitBoxToText','on','LineStyle','none','HorizontalAlignment','center','FontSize',14, 'Color', 'white');
    
    positionMatrixR = [red_striker.position; red_defender1.position; red_defender2.position; red_gk.position];
    positionMatrixB = [blue_striker.position; blue_defender1.position; blue_defender2.position; blue_gk.position];
   

    if(game ==1)
        
        %% Set the state at the start of the game
        if(flag==1)
            red_striker.state   = playerState.GET_POSSESSION;
            red_defender1.state = playerState.ASSIST;
            red_defender2.state = playerState.ASSIST;
            red_gk.state        = playerState.WAIT;

            blue_striker.state   = playerState.GET_POSSESSION;
            blue_defender1.state = playerState.ASSIST;
            blue_defender2.state = playerState.ASSIST;
            flag = 0;
        end
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%% %%

        %% RED STRIKER BEHAVIOUR
        [red_striker, red_defender1, red_defender2, blue_striker, blue_defender1, blue_defender2, ball, BALL_POSSESSION, RESET]   = redStrikerBehaviour(red_striker, red_defender1, red_defender2, blue_striker, blue_defender1, blue_defender2,  ball, ballPlot, BALL_POSSESSION, TOLERANCE, TIME_STEP, OMEGA, red_strikerPlot, positionMatrixR, positionMatrixB);
        %% RED DEFENDER1 BEHAVIOUR
        [red_striker, red_defender1, red_defender2, blue_striker, blue_defender1, blue_defender2, ball,BALL_POSSESSION]  = redDefenderBehaviour1(red_striker, red_defender1, red_defender2, blue_striker, blue_defender1, blue_defender2, ball, ballPlot, BALL_POSSESSION, TOLERANCE, PLAYER_GAP, TIME_STEP, OMEGA, red_defender1Plot, positionMatrixR,positionMatrixB);
        %% RED DEFENDER2 BEHAVIOUR
        
        if(temp > 5) %% temporary setting
        [red_striker, red_defender1, red_defender2, blue_striker, blue_defender1, blue_defender2, ball,BALL_POSSESSION]  = redDefenderBehaviour2(red_striker, red_defender1, red_defender2, blue_striker, blue_defender1, blue_defender2, ball, ballPlot, BALL_POSSESSION, TOLERANCE, PLAYER_GAP, TIME_STEP, OMEGA, red_defender2Plot, positionMatrixR,positionMatrixB);
        
        %% red GoalKeeper BEHAVIOUR
        red_gk = redGoalKeeperBehaviour(red_gk, ball, ballPlot, red_gkPlot,red_striker,red_defender1, red_defender2,TIME_STEP);
        %%%%%%%%%%%%%%%%% BLUE TEAM %%%%%%%%%%%%%%%%%%%

        %% BLUE STRIKER BEHAVIOUR
        [blue_striker, blue_defender1, blue_defender2, red_striker, red_defender1, red_defender2, ball,  BALL_POSSESSION, RESET] =  blueStrikerBehaviour(blue_striker, blue_defender1, blue_defender2, red_striker, red_defender1, red_defender2, ball, ballPlot, BALL_POSSESSION, TOLERANCE,TIME_STEP,OMEGA, blue_strikerPlot, positionMatrixR, positionMatrixB);
        end
        %% BLUE DEFENDER1 BEHAVIOUR
        [blue_striker, blue_defender1, ball]  = blueDefender1Behaviour(blue_striker, blue_defender1, ball, ballPlot, TOLERANCE, PLAYER_GAP, TIME_STEP, OMEGA, blue_defender1Plot, positionMatrixR,positionMatrixB);
        %% BLUE DEFENDER2 BEHAVIOUR
        [blue_striker, blue_defender2, ball]  = blueDefender2Behaviour(blue_striker, blue_defender2, ball, ballPlot, TOLERANCE, PLAYER_GAP, TIME_STEP, OMEGA, blue_defender2Plot, positionMatrixR,positionMatrixB);
        %% BLUE GoalKeeper BEHAVIOUR
        blue_gk = blueGoalKeeperBehaviour(blue_gk, ball, ballPlot, blue_gkPlot,blue_striker,blue_defender1, blue_defender2,TIME_STEP);
       


        if(ball.velocity > 0 && ball.possessed == 0)
            ball = ball.calcPhysics(TIME_STEP);
            ball.updatePlot(ballPlot);
        elseif(ball.velocity ~= 0 && ball.possessed == 1)
            ball.velocity = 0;
        end
        
        red_striker  = headAngleCorrection(red_striker);
        blue_striker = headAngleCorrection(blue_striker);
        



    if(RESET == 1)
        if(ball.position(1) < 1)
            pause(0.8);
            plotSoccerField;
            RESET = 0;
            flag = 1;
            temp = -35;
        end
    end
    end
temp = temp+1;
ball;
red_striker;
red_defender1;
blue_striker;
blue_defender1;
pause(TIME_STEP);
end
