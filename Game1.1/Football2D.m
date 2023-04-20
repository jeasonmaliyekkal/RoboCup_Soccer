classdef Football2D
    properties
        position % Position of the football [x, y]
        velocity % Velocity of the football [vx, vy]
        radius   % Radius of the football
    end
    
    methods
        function obj = Football2D(pos, vel, r)
            % Constructor method to initialize the properties
            obj.position = pos;
            obj.velocity = vel;
            obj.radius = r;
        end
        
        function move(obj, dt)
            % Move the football based on its velocity and time step
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
        
%         function isInside(goal_area)
%         
%         end
% 
%         function reset()
%         
%         end
%         
        function draw(obj)
            % Draw the football using a filled circle
            t = linspace(0, 2*pi, 100);
            x = obj.radius * cos(t) + obj.position(1);
            y = obj.radius * sin(t) + obj.position(2);
            fill(x, y, 'yellow', 'EdgeColor', 'none');
        end
    end
end



