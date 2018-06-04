clear
close all

figure
plotCombustor_v1_highRes

snake = struct(...
    'S', [23.5,           1,   55,          55,          55,          55,          55,          55,          55,          55,          55,          55],...
    'Th',[   0, 10*(pi/180), (pi/2)-0.0611, 10*(pi/180), 10*(pi/180), 10*(pi/180), 10*(pi/180), 10*(pi/180), 10*(pi/180), 10*(pi/180), 10*(pi/180), 10*(pi/180)],...
    'Ph',[   0,           0, pi/2,    (3*pi)/2,    (3*pi)/2,    (3*pi)/2,    (3*pi)/2,    (3*pi)/2,    (3*pi)/2,    (3*pi)/2,    (3*pi)/2,    (3*pi)/2],...
    'P_i', [0;0;(Front_OD - Rear_OD)/4],...
    'R_i',Rot(-10*(pi/180),'Y'));
%plotSnakeList(snake,1,'linewidth',2)

[p,R,pp] = pathRecur(snake,10);

hold on
plot3(pp(1,:),pp(2,:),pp(3,:),'r-','linewidth',3)
plot3(p(1,:),p(2,:),p(3,:),'bd','linewidth',1)