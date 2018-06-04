plotCombustor_v1_highRes
hold on

angR = (3*55)/(Mid_D/2);

R_i = Rot(-angR,'X');
P_i = (R_i * [0;0;Mid_D/2])     +    [0;0;Front_OD/2];
R_i = Rot(-(angR - (pi/2)),'X');

snake = struct(...
    'S', [           55,          55,          55],...
    'Th',[  9.12*(pi/180), 9.12*(pi/180), 9.12*(pi/180)],...
    'Ph',[     (3*pi)/2,    (3*pi)/2,    (3*pi)/2],...
    'P_i', P_i,...
    'R_i', R_i);

%plotSnakeList(snake,1,'linewidth',2)
[p,R,pp] = pathRecur(snake,10);

hold on
plot3(pp(1,:),pp(2,:),pp(3,:),'r-','linewidth',3)
plot3(p(1,:),p(2,:),p(3,:),'bd','linewidth',1)
%% Gun Settings
lengthGun = 35;
spraypos = lengthGun - 6;
sprayoff = 55;
%% SprayPath Settings
heightRadius = 10; % X-axes
radialRadius = 40; % Y-axes
heightOffset = 0;
radialOffset = 15;

t = -pi:(2*pi/res):pi;
Ellipse = [heightRadius*cos(t) + heightOffset;radialRadius*sin(t) + radialOffset;0*t + (-(Front_OD - Rear_OD)/4) + (Front_OD)];
%% Plot Gun / Spray
gEnd = (R*[0;0;lengthGun])   + p(:,end);
sSta = (R*[0;0;spraypos])    + p(:,end);
sEnd = (R*[0;sprayoff;spraypos])   + p(:,end);
eSta = find(Ellipse(2,:) == min(Ellipse(2,:)));
Initial = [sEnd, Ellipse(:,eSta)];
plot3([p(1,end) gEnd(1)],[p(2,end) gEnd(2)],[p(3,end) gEnd(3)],'g-','linewidth',2)
plot3([sSta(1) sEnd(1)],[sSta(2) sEnd(2)],[sSta(3) sEnd(3)],'m-','linewidth',2)
plot3(Initial(1,:),Initial(2,:),Initial(3,:),'g--','linewidth',1)
plot3(Ellipse(1,:),Ellipse(2,:),Ellipse(3,:),'c--','linewidth',1)
axis([-100 100 -100 250 600 800])