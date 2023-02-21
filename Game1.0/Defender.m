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
        
        function draw(obj)
            % Draw the defender using a filled square
            x = [obj.position(1) - obj.radius, obj.position(1) + obj.radius, obj.position(1) + obj.radius, obj.position(1) - obj.radius];
            y = [obj.position(2) - obj.radius, obj.position(2) - obj.radius, obj.position(2) + obj.radius, obj.position(2) + obj.radius];
            fill(x, y, 'r', 'EdgeColor', 'none');
        end
    end
end
