classdef Football2D
    properties
        position % Position of the football [x, y]
        velocity % Velocity of the football [vx, vy]
        radius   % Radius of the football
        possessed
    end
    
    methods
        function obj = Football2D(pos, vel, r)
            % Constructor method to initialize the properties
            obj.position = pos;
            obj.velocity = vel;
            obj.radius = r;
            obj.possessed =0;
        end
        
        function move(obj, dt)
            % Move the football based on its velocity and time ste
            obj.position = obj.position + obj.velocity * dt;
            
        end
        
        function bounce(obj, dim)
            % Bounce the football off the edges of the specified dimension
            for i = 1:length(obj.position)
                if obj.position(i) < obj.radius
                    obj.position(i) = obj.radius;
                    obj.velocity(i) = -obj.velocity(i);
                elseif obj.position(i) > dim(i) - obj.radius
                    obj.position(i) = dim(i) - obj.radius;
                    obj.velocity(i) = -obj.velocity(i);
                end
            end
        end
        
        function kick(obj, dir, speed)
            % Kick the football in a specified direction and speed
            obj.velocity = obj.velocity + speed * dir;
        end

        function setToNewPosition(x,y)
            t = linspace(0, 2*pi, 100);
            x1 = obj.radius * cos(t) + x;
            y1 = obj.radius * sin(t) + y;
            fill(x1, y1, 'yellow', 'EdgeColor', 'none');
        end
        
%         function isInside(goal_area)
%         
%         end
% 
%         function reset()
%         
%         end
%       
        function ballPlot = draw(obj)
            % Draw the football using a filled circle
            ballPlot = plot(obj.position(1), obj.position(2));
            set(ballPlot, 'Marker', 'o');
            set(ballPlot, 'MarkerEdgeColor', [1, 1, 0]);
            set(ballPlot, 'MarkerFaceColor', [1,1,0]);
            set(ballPlot, 'MarkerSize', 10);
        end
    end
end



