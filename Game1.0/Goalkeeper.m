classdef Goalkeeper
    properties
        position % Position of the goalkeeper [x, y]
        radius   % Radius of the goalkeeper
        speed    % Speed of the goalkeeper
    end
    
    methods
        function obj = Goalkeeper(pos, r, s)
            % Constructor method to initialize the properties
            obj.position = pos;
            obj.radius = r;
            obj.speed = s;
        end
        
        function moveTowards(obj, target, dt)
            % Move the goalkeeper towards a specified target position
            direction = target - obj.position;
            distance = norm(direction);
            if distance > obj.radius
                obj.position = obj.position + obj.speed * direction / distance * dt;
            end
        end
        
        function draw(obj)
            % Draw the goalkeeper using a filled circle
            t = linspace(0, 2*pi, 100);
            x = obj.radius * cos(t) + obj.position(1);
            y = obj.radius * sin(t) + obj.position(2);
            fill(x, y, 'b', 'EdgeColor', 'none');
        end
    end
end
