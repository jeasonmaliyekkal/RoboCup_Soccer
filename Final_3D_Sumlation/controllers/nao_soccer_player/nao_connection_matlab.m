% Add the NAOqi and Webots API to the Matlab path
addpath('c:/naoqi/naoqi-sdk-matlab');
addpath('c:/webots/webots-matlab');

% Define the IP and port of the NAOqi middleware
ip = '127.0.0.1';
port = 9559;

% Connect to the NAOqi middleware
connection = ALProxy('ALMotion', ip, port);




% Initialize the walk parameters
% x = 0.5;      % Forward speed (m/s)
% y = 0;        % Lateral speed (m/s)
% theta = 0;    % Angular speed (rad/s)
% frequency = 0.5; % Frequency of the step
% 
% % Set the walk parameters
% connection.setWalkTargetVelocity(x, y, theta, frequency);
% 
% % Let the robot walk for 5 seconds
% pause(5);
% 
% % Stop the robot
% connection.stopMove();
% 
% % Disconnect from the NAOqi middleware
% connection.delete();