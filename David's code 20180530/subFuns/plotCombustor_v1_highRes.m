% Quick Script to plot the inner and outer surfaces of the combustor as
% rings

res = 100;

%Parameters - Trent 900
Front_OD = 800;
Front_ID = 800 - (2*85);

Rear_OD = 541 + (2*113);
Rear_ID = 541;

Mid_D = 676;

Entrance_D = 21.5;

Depth = 145; %Guess

% %Parameters - Trent XWB 84K
% Front_OD = 802;
% Front_ID = 802 - (2*86);
%
% Rear_OD = 553 + (2*92);
% Rear_ID = 553;
%
% Mid_D = 700;
%
% Depth = 145;

F_O = [Front_OD/2; 0; 0];
F_I = [Front_ID/2; 0; 0];

R_O = [Rear_OD/2; 0; 0];
R_I = [Rear_ID/2; 0; 0];

M   = [  Mid_D/2; 0; 0];

Ent = [ Entrance_D/2; 0; 0];


for i = 2:res + 1
    F_O(:,i) = Rot(((2*pi)/res)*(i-1),'Z')*F_O(:,1);
    F_I(:,i) = Rot(((2*pi)/res)*(i-1),'Z')*F_I(:,1);
    
    R_O(:,i) = Rot(((2*pi)/res)*(i-1),'Z')*R_O(:,1);
    R_I(:,i) = Rot(((2*pi)/res)*(i-1),'Z')*R_I(:,1);
    
    M(:,i) = Rot(((2*pi)/res)*(i-1),'Z')*M(:,1);
    
    Ent(:,i) = Rot(((2*pi)/res)*(i-1),'Z')*Ent(:,1);
end

for i = 1:res + 1
    F_O(:,i) = Rot((pi/2),'Y')*F_O(:,i);
    F_I(:,i) = Rot((pi/2),'Y')*F_I(:,i);
    
    F_O(:,i) = F_O(:,i) + [ -(Depth/2);0; Front_OD/2];
    F_I(:,i) = F_I(:,i) + [ -(Depth/2);0; Front_OD/2];
    
    R_O(:,i) = Rot((pi/2),'Y')*R_O(:,i);
    R_I(:,i) = Rot((pi/2),'Y')*R_I(:,i);
    
    R_O(:,i) = R_O(:,i) + [ (Depth/2);0; Front_OD/2];
    R_I(:,i) = R_I(:,i) + [ (Depth/2);0; Front_OD/2];
    
    M(:,i) = Rot((pi/2),'Y')*M(:,i);
    
    M(:,i) = M(:,i) + [ 0;0; Front_OD/2];
    
    oSlope = R_O(:,1) - F_O(:,1);
    oAngle = atan(oSlope(3)/oSlope(1));
    
    Ent(:,i) = Rot(-oAngle,'Y')*Ent(:,i);
    Ent(:,i) = Ent(:,i) + [ 0;0; abs(Front_OD - Rear_OD)/4];
    
end

for i = 1:res
    
    O_x(:,i) = [F_O(1,i); R_O(1,i); R_O(1,i+1); F_O(1,i+1)];
    O_y(:,i) = [F_O(2,i); R_O(2,i); R_O(2,i+1); F_O(2,i+1)];
    O_z(:,i) = [F_O(3,i); R_O(3,i); R_O(3,i+1); F_O(3,i+1)];
    
    I_x(:,i) = [F_I(1,i); R_I(1,i); R_I(1,i+1); F_I(1,i+1)];
    I_y(:,i) = [F_I(2,i); R_I(2,i); R_I(2,i+1); F_I(2,i+1)];
    I_z(:,i) = [F_I(3,i); R_I(3,i); R_I(3,i+1); F_I(3,i+1)];
    
end

% plot3(F_O(1,:),F_O(2,:),F_O(3,:),'b-')
% hold on
% plot3(F_I(1,:),F_I(2,:),F_I(3,:),'r-')
% hold on
%
% plot3(R_O(1,:),R_O(2,:),R_O(3,:),'b-')
% hold on
% plot3(R_I(1,:),R_I(2,:),R_I(3,:),'r-')
% hold on

plot3([-100,100],[0,0],[Front_OD/2,Front_OD/2],'k--','linewidth',1)
hold on
plot3(M(1,:),M(2,:),M(3,:),'b--','linewidth',1)
hold on
plot3(Ent(1,:),Ent(2,:),Ent(3,:),'k-','linewidth',2)
hold on
plot3([Ent(1,floor(res/8)),Ent(1,floor(5*res/8))],[Ent(2,floor(res/8)),Ent(2,floor(5*res/8))],[Ent(3,floor(res/8)),Ent(3,floor(5*res/8))],'k--')
hold on
plot3([Ent(1,floor(3*res/8)),Ent(1,floor(7*res/8))],[Ent(2,floor(3*res/8)),Ent(2,floor(7*res/8))],[Ent(3,floor(3*res/8)),Ent(3,floor(7*res/8))],'k--')
hold on


fill3(O_x, O_y, O_z,[0.8 0.8 0.8],'FaceAlpha',0.5)
fill3(I_x, I_y, I_z,[0.8 0.8 0.8])

grid on
daspect([1,1,1])

