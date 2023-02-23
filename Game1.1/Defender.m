classdef Defender
    properties
        position % Position of the defender [x, y]
        radius   % Radius of the defender
        speed    % Speed of the defender
    end
    
    methods
        function obj = Defender(pos, r, s)
            % Constructor method to initialize the properties
            obj.position = pos;
            obj.radius = r;
            obj.speed = s;
        end
        
        function moveTowards(obj, target, dt)
            % Move the defender towards a specified target position
            direction = target - obj.position;
            distance = norm(direction);
            if distance > obj.radius
                obj.position = obj.position + obj.speed * direction / distance * dt;
            end
        end






        
        function drawbuleTeam(obj)
            % Draw the defender using a filled circle
            t = linspace(0, 2*pi, 100);
            x = obj.radius * cos(t) + obj.position(1);
            y = obj.radius * sin(t) + obj.position(2);
            fill(x, y, 'blue', 'EdgeColor', 'none');
        end

        function drawredTeam(obj)
            % Draw the defender using a filled square
            t = linspace(0, 2*pi, 100);
            x = obj.radius * cos(t) + obj.position(1);
            y = obj.radius * sin(t) + obj.position(2);
            fill(x, y, 'r', 'EdgeColor', 'none');
        end
    end
end
