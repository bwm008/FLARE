function [ newPoint ] = RotAxis( axPoints, Point, Angle )
%% Transform to Z Axis
ax1 = axPoints(:,1);
ax2 = axPoints(:,2);
%shift to 0,0
trans = ax1;
ax1 = ax1 - trans;
ax2 = ax2 - trans;
Point = Point - trans;
%rotate to XZ plane
rotate1 = atan(ax2(2)/ax2(1));
ax2 = Rot( -rotate1, 'Z')* ax2;
Point = Rot( -rotate1, 'Z')* Point;
%rotate to Z axis
rotate2 = atan(ax2(1)/ax2(3));
ax2 = Rot( -rotate2, 'Y')* ax2;
Point = Rot( -rotate2, 'Y')* Point;
%% Rotate desired amount
newPoint = Rot( Angle, 'Z') * Point;
%% Transform back to original frame
%undo rotate2
newPoint = Rot( rotate2, 'Y')* newPoint;
%undo rotate1
newPoint = Rot( rotate1, 'Z')* newPoint;
%undo trans
newPoint = newPoint + trans;
end