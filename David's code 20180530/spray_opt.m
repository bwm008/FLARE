function [snake] = spray_opt(snake, p_f, r_f, gun)
i0 = [0; 0; 0; 0; 0; 0];
i1 = [ -0.124; -0.124; -0.124; -pi; -pi; -pi];
i2 = [  0.124;  0.124;  0.124;  pi;  pi;  pi];
for k = 1:3
    if     snake.Th(k) - 0.124 < -pi/2
        i1(k) = -pi/2 + snake.Th(k);
    elseif snake.Th(k) + 0.124 >  pi/2
        i2(k) = pi/2 - snake.Th(k);
    end
end

fun = @(dIn)spray_opt_fun(dIn,snake,p_f,r_f,gun);
options = optimset('MaxFunEvals',5000,'algorithm','sqp','UseParallel','always','TolFun',0.0000001);%'active-set'
[dIn, fval] = fmincon(fun,i0,[],[],[],[],i1,i2,[],options);
snake.Th = snake.Th + dIn(1:3)';
snake.Ph = snake.Ph + dIn(4:6)';
disp(fval)
end

function [fval] = spray_opt_fun(dIn,snake,p_f,r_f, gun)
    snake.Th = snake.Th + dIn(1:3)';
    snake.Ph = snake.Ph + dIn(4:6)';
    
    [p,R,~] = pathRecur(snake,10);
    spraySta = (R*[0;0;gun.spraypos])    + p(:,end);
    sprayEnd = (R*[0;gun.sprayoff;gun.spraypos])   + p(:,end);
    
    drift = euclidean(p_f, sprayEnd)^2;
    angle = 10* euclidean2(sprayEnd(1:2),spraySta(1:2))^2;
    fval = drift + angle; 
end