ipaddress='192.168.206.203';
%The simulated robot (built 3D scene) runs on the virtual machine 192.168.206.203
robotType='Gazebo' 
rosshutdown; %shut down the ROS connection if there exists
% Ip adress for ROS master
% Run on a virtual machine and let matlab try to establish communication with the ROS master on this ip address
rosinit(ipaddress) 

% create a subscriber for the ROS topic. 
% Used to obtain ROS related data
scanner = rossubscriber('scan')
%get the next message
laseredata=receive(scanner, 5)
%get the latest data
laserdata=scanner.LatestMessage

myloc = GazeboGPS;
%get the initial location of the robot
[x0,y0,theta0]=getPose(myloc);

%create a publisher to control the robot. 
% Send data to the robot through matlab to control how the robot moves
velcmd = rospublisher('/mobile_base/commands/velocity')
vel = rosmessage(velcmd)
%Drive the robot to move
vel.Linear.X = 0.2;
vel.Angular.Z = 0.5;
send(velcmd, vel)

%get new location
[x1,y1,theta1]=getPose(myloc);

%Here you can add the control algorithm of the model to drive how the robot moves
%%fill the code


rosshutdown;






