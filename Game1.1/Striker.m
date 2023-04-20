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
 




        
        function drawbuleTeam(obj)
            % Draw the striker using a filled circle
            th = 0:pi/50:2*pi;
            x = obj.position(1) + obj.radius * cos(th);
            y = obj.position(2) + obj.radius * sin(th);
            fill(x, y, 'b', 'EdgeColor', 'none');
        end

        function drawredTeam(obj)
            % Draw the striker using a filled circle
            th = 0:pi/50:2*pi;
            x = obj.position(1) + obj.radius * cos(th);
            y = obj.position(2) + obj.radius * sin(th);
            fill(x, y, 'r', 'EdgeColor', 'none');
        end
    end
end
