function [snake] = nav_opt(snake, p1, p2)
i0 = [0; 0; 0];
i1 = [ -0.124; -0.124; 0];
i2 = [  0.124;  0.124; 3];
for k = 1:2
    if     snake.Th(k) - 0.124 < -84.4*(pi/180)
        i1(k) = -84.4*(pi/180) + snake.Th(k);
    elseif snake.Th(k) + 0.124 >  9.12*(pi/180)
        i2(k) = 9.12*(pi/180) - snake.Th(k);
    end
end

fun = @(dIn)nav_opt_fun(dIn,snake,p1,p2);
options = optimset('MaxFunEvals',5000,'algorithm','sqp','UseParallel','always','TolFun',0.0000001);%'active-set'
[dIn, fval] = fmincon(fun,i0,[],[],[],[],i1,i2,[],options);
snake.Th = snake.Th + [dIn(1), dIn(2), 0];
snake.P_i = snake.P_i + [0;0;dIn(3)];
disp(fval)
end

function [fval] = nav_opt_fun(dIn,snake,p1, p2)
    snake.Th = snake.Th + [dIn(1), dIn(2), 0];
    snake.P_i = snake.P_i + [0;0;dIn(3)];
    [p,~,~] = pathRecur(snake,10);
    d1 = euclidean(p1,p(:,4))^2;
    d2 = euclidean(p2,p(:,3))^2;
    fval = d1 + 10*d2; 
end