classdef Player
    properties
        position  % Position of the striker [x, y]
        radius    % Radius of the striker
        speed     % Speed of the striker
        headAngle % Direction of facing
        color
        state
        possession 
        counter
    end
    
    methods
        function obj = Player(pos, r, s, theta, color)
            % Constructor method to initialize the properties
            obj.position = pos;
            obj.radius = r;
            obj.speed = s;
            obj.headAngle = theta;
            obj.color = color;
            obj.state = 'WAIT';
            obj.possession = 0;
            obj.counter = 0;
        end
        
        function obj =  move(obj, dt)
            % Move the striker foward in the direction of "headingAngle"
            obj.position = [obj.position(1)+dt*obj.speed*cos(obj.headAngle),obj.position(2)+dt*obj.speed*sin(obj.headAngle)];
            
        end
        
        function ball_velocity = kickBall(~, ball_mass, action, dt)
            % Kick the ball towards a specified target position with a specified power
            if(action == "PASS")
                ball_velocity = (5/ball_mass)*dt; %Force = 1.1N
            end
        end
 

        function player_obj = initializeBot(obj)
           
                player = plot(obj.position(1), obj.position(2));
                set(player, 'Marker', 'o');
                set(player, 'MarkerEdgeColor', obj.color);
                set(player, 'MarkerFaceColor', obj.color);
                set(player, 'MarkerSize', obj.radius);

                projection = [0.2*cos(obj.headAngle), 0.2*sin(obj.headAngle)];
                lne = plot([obj.position(1), obj.position(1)+projection(1)], [obj.position(2), obj.position(2)+projection(2)], 'Color', obj.color, 'LineWidth', 1);
                player_obj = [player, lne];
        end


        function updatePos(obj, curPlot)
            set(curPlot(1), 'XData', obj.position(1), 'YData', obj.position(2))
            projection = [0.2*cos(obj.headAngle), 0.2*sin(obj.headAngle)];
            set(curPlot(2), 'XData', [obj.position(1), obj.position(1)+projection(1)],'YData', [obj.position(2), obj.position(2)+projection(2)], 'Color', obj.color, 'LineWidth', 1);
        end

        function obj = turnPlayer(obj, dir, omega, timeStep)
                obj.headAngle = obj.headAngle + dir*omega*timeStep;

        end

    end
end
