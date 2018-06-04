function [P,R,Path ] = pathRecur(Snake,n )

NumSec = length(Snake.S);
%% ReEntrant Stage

if (NumSec == 1)
    R_i = Snake.R_i;
    P_ii = Snake.P_i;
    P_i = Snake.P_i;
    
    Segment.S = Snake.S(1);
    Segment.Th = Snake.Th(1);
    Segment.Ph = Snake.Ph(1);

else
    xSnake.S = Snake.S(1:NumSec-1);
    xSnake.Th = Snake.Th(1:NumSec-1);
    xSnake.Ph = Snake.Ph(1:NumSec-1);
    xSnake.P_i = Snake.P_i;
    xSnake.R_i = Snake.R_i;
    
    [P_i,R_i,Path_i] = pathRecur(xSnake,n);
    
    Segment.S = Snake.S(NumSec);
    Segment.Th = Snake.Th(NumSec);
    Segment.Ph = Snake.Ph(NumSec);
    
    P_ii = P_i(:,size(P_i,2));%get last value of P_i
end
%% Function Body
if Segment.Th < 0
    Segment.Th = abs(Segment.Th);
    Segment.Ph = pi + Segment.Ph;
end
if Segment.Ph < 0
    Segment.Ph = Segment.Ph + (2*pi);
end
[xf,yf,zf] = singleKin(Segment.S,Segment.Th,Segment.Ph);

P = R_i * [xf;yf;zf];
P = P + P_ii;
P = [P_i,P];
R = R_i * singleR(Segment.Th,Segment.Ph);
%get Path array for section
Path = singleArc([xf;yf;zf],Segment.S,Segment.Th,Segment.Ph,n);
%update Path by rotation and offset
for i = 1:1:n+1;
    Path(:,i) = R_i * Path(:,i);
    Path(:,i) = Path(:,i) + P_ii;    
end
%Update Path array if not base
if NumSec ~= 1
    Path_ii = Path_i(:,1:size(Path_i,2)-1);
    Path = [Path_ii, Path] ;
end

end

%% Sub-F
function [x,y,z] = singleKin(S,Th,Ph)
if Th == 0
    x = 0;
    y = 0;
    z = S;
else
    r = S/Th;
    x = r*cos(Ph)*(1-cos(Th));
    y = r*sin(Ph)*(1-cos(Th));
    z = r*sin(Th);
end
end

function [R] = singleR(Th,Ph)
R = Rot(Ph,'Z')*Rot(Th,'Y')*Rot(-Ph,'Z');
end

function [Path] = singleArc(endP,S,Th,Ph,n)
Path = zeros(3,n+1);

if Th == 0
    x = zeros(1,n+1);
    y = zeros(1,n+1);
    z = linspace(0,S,n+1);
    Path = [x; y; z];
else
    radius = S/Th;
    dashP = Rot(-Ph,'Z') * endP; %Consider Section is on XZ plane for ease
    %Place start and finish in polar coordinates
    [TH1,~] = cart2pol(0 -radius, 0); 
    [TH2,~] = cart2pol(dashP(1) -radius , dashP(3));
    % Interpolate between
    theta = linspace(TH1,TH2,n+1);
    rho = ones(1,n+1) * radius;
    % Return to Cartesian
    [x,z] = pol2cart(theta,rho);
    x = x + radius; %Offset X values
    y = zeros(1,n+1); % On XZ Plane so Y = 0
    %z = z;
    
    % Undo rotation,
    for i = 1:1:n+1
        Path(:,i) = Rot(Ph,'Z') * [x(i);y(i);z(i)];
    end
end
end

function [R] = Rot(angle,axis)
a = angle;
switch(axis)
    case {'X'}
        R = [ 1,      0,      0; ...
            0, cos(a),-sin(a); ...
            0, sin(a), cos(a)];
    case {'Y'}
        R = [ cos(a), 0, sin(a); ...
            0, 1,      0; ...
            -sin(a), 0, cos(a)];
    case {'Z'}
        R = [cos(a),-sin(a),  0; ...
            sin(a), cos(a),  0; ...
            0,      0,  1];
    otherwise
        R = eye(3);
end
end