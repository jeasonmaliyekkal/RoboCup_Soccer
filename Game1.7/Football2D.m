classdef Football2D
    properties
        position % Position of the football [x, y]
        velocity % Velocity of the football [vx, vy]
        acceleration
        mass %mass in kg
        coeff_of_friction %coeff of friction between ball and field
        radius   % Radius of the football
        direction
        possessed
        
    end
    
    methods
        function obj = Football2D(pos, r)
            % Constructor method to initialize the properties
            obj.position          = pos;
            obj.velocity          = 0;
            obj.acceleration      = 0;
            obj.mass              = 0.15;
            obj.coeff_of_friction = 0.6;
            obj.radius            = r;
            obj.direction         = 0;
            obj.possessed         = 0;
        end
        
        function obj = move(obj, dt)
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
        
        function obj = kick(obj, dir, speed)
            % Kick the football in a specified direction and speed
            obj.velocity = obj.velocity + speed * dir;
        end

        function setToNewPosition(x,y)
            t = linspace(0, 2*pi, 100);
            x1 = obj.radius * cos(t) + x;
            y1 = obj.radius * sin(t) + y;
            fill(x1, y1, 'yellow', 'EdgeColor', 'none');
        end
        
     
        function ballPlot = draw(obj)
            % Draw the football using a filled circle
            ballPlot = plot(obj.position(1), obj.position(2));
            set(ballPlot, 'Marker', 'o');
            set(ballPlot, 'MarkerEdgeColor', [1, 1, 0]);
            set(ballPlot, 'MarkerFaceColor', [1,1,0]);
            set(ballPlot, 'MarkerSize', 8);
        end

        function updatePlot(obj, curPlot)
            set(curPlot(1), 'XData', obj.position(1), 'YData', obj.position(2))

        end
        function obj = calcPhysics(obj, dt)
            obj.acceleration = -obj.coeff_of_friction*9.81;
            obj.position = [obj.position(1) + obj.velocity*dt*cos(obj.direction) + 0.5*obj.acceleration*(dt^2)*cos(obj.direction), obj.position(2) + obj.velocity*dt*sin(obj.direction) + 0.5*obj.acceleration*(dt^2)*sin(obj.direction)];
            obj.velocity = obj.velocity + obj.acceleration*dt;
        end
    end
end



