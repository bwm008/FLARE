% Converts current navListFull value into a struct suitable for the Export function
n = length(navListFull);
xSnakeList(1:n) = struct('S',navListFull(1).S(1), 'bodyTh', zeros(1,10), 'tipTh', zeros(1,3), 'tipPh', zeros(1,3), 'feed', 0);  

for i = 1:n
    xSnakeList(i).bodyTh    = navListFull(i).Th(1:10)   * -1;
    xSnakeList(i).tipTh     = navListFull(i).Th(11:13)  * -1;
    xSnakeList(i).tipPh     = navListFull(i).Ph(11:13)  - pi;
    xSnakeList(i).feed      = navListFull(i).P_i(3)     + 688;
    
end