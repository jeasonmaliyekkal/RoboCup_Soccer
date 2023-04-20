classdef Striker
    properties
        position % Position of the striker [x, y]
        radius   % Radius of the striker
        speed    % Speed of the striker
    end
    
    methods
        function obj = Striker(pos, r, s)
            % Constructor method to initialize the properties
            obj.position = pos;
            obj.radius = r;
            obj.speed = s;
        end
        
        function moveTowards(obj, target, dt)
            % Move the striker towards a specified target position
            direction = target - obj.position;
            distance = norm(direction);
            if distance > obj.radius
                obj.position = obj.position + obj.speed * direction / distance * dt;
            end
        end
        
        function kickTowards(obj, target, power)
            % Kick the ball towards a specified target position with a specified power
            direction = target - obj.position;
            distance = norm(direction);
            if distance <= obj.radius
                % If the ball is within the striker's radius, kick the ball
                ballDirection = direction / distance;
                ballSpeed = power * obj.speed;
                ball.setVelocity(ballSpeed * ballDirection);
            end
        end
 
        function blueStriker = drawbuleTeam(obj)
            % Draw the striker using a filled circle
            blueStriker = plot(obj.position(1), obj.position(2));
            set(blueStriker, 'Marker', 'o');
            set(blueStriker, 'MarkerEdgeColor', [0, 0, 1]);
            set(blueStriker, 'MarkerFaceColor', [0,0,1]);
            set(blueStriker, 'MarkerSize', 15);
        end

        function redStriker = drawredTeam(obj)
            % Draw the striker using a filled circle
            redStriker = plot(obj.position(1), obj.position(2));
            set(redStriker, 'Marker', 'o');
            set(redStriker, 'MarkerEdgeColor', [1, 0, 0]);
            set(redStriker, 'MarkerFaceColor', [1,0,0]);
            set(redStriker, 'MarkerSize', 15);
        end
    end
end
