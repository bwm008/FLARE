SnakeTipinEngine1

gun = struct('length',lengthGun,'spraypos',spraypos,'sprayoff',sprayoff,'rot',0);
initialRes = 20;
Initial = [linspace(Initial(1,1),Initial(1,2),initialRes);...
           linspace(Initial(2,1),Initial(2,2),initialRes);...
           linspace(Initial(3,1),Initial(3,2),initialRes)];

SnakeList(1) = snake;
for i = 2:length(Initial)
    p_f = Initial(:,i);
    r_f = eye(3);
    snake = spray_opt(snake, p_f, r_f, gun);
    
    SnakeList(i) = snake;
    
    if rem(i,5) == 0
       [p,R,~] = pathRecur(snake,1);
       sEnd = (R*[0;sprayoff;spraypos]) + p(:,end);
       hold on
       plot3(sEnd(1),sEnd(2),sEnd(3),'m*')
    end

end

Ellipse = circshift(Ellipse,-eSta,2);

Med = [linspace(Initial(1,end),Ellipse(1,1),initialRes);...
    linspace(Initial(2,end),Ellipse(2,1),initialRes);...
    linspace(Initial(3,end),Ellipse(3,1),initialRes)];
MedSnakeList(1) = snake;
for i = 2:length(Med)
    p_f = Med(:,i);
    r_f = eye(3);
    disp(i)
    snake = spray_opt(snake, p_f, r_f, gun);
    MedSnakeList(i) = snake;
    if rem(i,5) == 0
       [p,R,~] = pathRecur(snake,1);
       sEnd = (R*[0;sprayoff;spraypos]) + p(:,end);
       hold on
       plot3(sEnd(1),sEnd(2),sEnd(3),'y*')
    end
end

% Ellipse = [Ellipse, Ellipse, Ellipse];
for i = 1:length(Ellipse)
    p_f = Ellipse(:,i);
    r_f = eye(3);
    disp(i)
    snake = spray_opt(snake, p_f, r_f, gun);
    EllipseList(i) = snake;
    if rem(i,5) == 0
       [p,R,~] = pathRecur(snake,1);
       sEnd = (R*[0;sprayoff;spraypos]) + p(:,end);
       hold on
       plot3(sEnd(1),sEnd(2),sEnd(3),'c*')
    end
end