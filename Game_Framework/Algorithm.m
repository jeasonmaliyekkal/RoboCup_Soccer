function [newPos,state] = Algorithm(ballPos, strikerPos, defender1Pos,defender2Pos, goaliePos);


ball_striker = norm(ballPos-strikerPos);
striker_def1 = norm(defender1Pos-strikerPos);
striker_def2 = norm(defender2Pos-strikerPos);


newBall = [];
new_str = [];
newDef1 = [];
newDef2 = [];
newGoalie = [];

% 10,4 -> goal post, 9,4 goal area
state = "";

if ball_striker >=0.35
    %% Get the trajectory
        func = @(x_striker)strikerPos(2) + (strikerPos(2)-ballPos(2))/(strikerPos(1)-ballPos(1))*(x_striker-strikerPos(1));
        x_striker = linspace(strikerPos(1),ballPos(1)-0.2,10);
        y_striker = func(x_striker);
        state = "Possess";
elseif ball_striker <0.35 
        func = @(x_striker)strikerPos(2) + (strikerPos(2)-4)/(strikerPos(1)-9)*(x_striker-strikerPos(1));

        x_striker = linspace(strikerPos(1),9,50);
        y_striker = func(x_striker);
        state = "Dribble";
end
if strikerPos(1)>=9 && strikerPos(2)>2.7 && strikerPos(2)<5.3 && ball_striker <0.35
        func = @(x_striker)strikerPos(2) + (strikerPos(2)-4)/(strikerPos(1)-11)*(x_striker-strikerPos(1));
        x_striker = linspace(strikerPos(1),10.5,5);
        y_striker = func(x_striker);
        state = "Shoot";
end

newPos=[x_striker; y_striker];

end