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

        function blueGoal = drawbuleTeam(obj)
            % Draw the goalkeeper using a filled circle
            blueGoal = plot(obj.position(1), obj.position(2));
            set(blueGoal, 'Marker', 'o');
            set(blueGoal, 'MarkerEdgeColor', [0, 0, 1]);
            set(blueGoal, 'MarkerFaceColor', [0,0,1]);
            set(blueGoal, 'MarkerSize', 15);
        end
        function redGoal = drawredTeam(obj)
            % Draw the goalkeeper using a filled circle
            redGoal = plot(obj.position(1), obj.position(2));
            set(redGoal, 'Marker', 'o');
            set(redGoal, 'MarkerEdgeColor', [1, 0, 0]);
            set(redGoal, 'MarkerFaceColor', [1,0,0]);
            set(redGoal, 'MarkerSize', 15);
        end
    end
end
