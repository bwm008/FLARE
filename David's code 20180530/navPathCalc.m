plotCombustor_v1_highRes

snake = struct(...
    'S', [        55,             55,            55],...
    'Th',[         0, -84.4*(pi/180), 9.12*(pi/180)],...
    'Ph',[  (3*pi)/2,       (3*pi)/2,      (3*pi)/2],...
    'P_i', [0;0;-28],... %set by trial-and-error
    'R_i', eye(3));
[p,R,pp] = pathRecur(snake,10);

hold on
plot3(pp(1,:),pp(2,:),pp(3,:),'r-','linewidth',3)
plot3(p(1,:),p(2,:),p(3,:),'bd','linewidth',1)
axis([-100 100 -50 150 0 120])

point1 = p(:,4);
point2 = p(:,3);
navList(1) = snake;

for i = 2:(snake.S(1)*2) + 1
    pos = (i - 1)/2;
    angle = pos/(Mid_D/2);
    p1 = point1 + [0;0;-Front_OD/2];
    p2 = point2 + [0;0;-Front_OD/2];
    p1 = Rot(angle,'X') * p1;
    p2 = Rot(angle,'X') * p2;
    p1 = p1 + [0;0;Front_OD/2];
    p2 = p2 + [0;0;Front_OD/2];
    
    snake = nav_opt(snake, p1, p2);
    navList(i) = snake;
    if rem(i,5) == 0
       hold on
       plotSnakeList(snake,0,'g-')
       drawnow
    end
end