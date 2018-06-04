function [R] = Rot(angle,axis)
a = angle;
switch(axis)
    case {'X','x'}
        R = [ 1,      0,      0; ...
            0, cos(a),-sin(a); ...
            0, sin(a), cos(a)];
    case {'Y','y'}
        R = [ cos(a), 0, sin(a); ...
            0, 1,      0; ...
            -sin(a), 0, cos(a)];
    case {'Z','z'}
        R = [cos(a),-sin(a),  0; ...
            sin(a), cos(a),  0; ...
            0,      0,  1];
    otherwise
        R = eye(3);
        disp('Unknown Axis in Rot')
end
end
