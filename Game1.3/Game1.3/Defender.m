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


        function blueDefender = drawbuleTeam(obj)
            % Draw the defender using a filled circle
            blueDefender = plot(obj.position(1), obj.position(2));
            set(blueDefender, 'Marker', 'o');
            set(blueDefender, 'MarkerEdgeColor', [0, 0, 1]);
            set(blueDefender, 'MarkerFaceColor', [0,0,1]);
            set(blueDefender, 'MarkerSize', 15);
        end

        function redDefender = drawredTeam(obj)
            % Draw the defender using a filled square
            redDefender = plot(obj.position(1), obj.position(2));
            set(redDefender, 'Marker', 'o');
            set(redDefender, 'MarkerEdgeColor', [1, 0, 0]);
            set(redDefender, 'MarkerFaceColor', [1,0,0]);
            set(redDefender, 'MarkerSize', 15);
        end
    end
end
