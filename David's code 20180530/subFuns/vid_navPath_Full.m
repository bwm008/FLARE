% For creating video animation of spraying process as calculated by sprayPathCalc (05/10/16 Dr. David Palmer)

%sprayList = [SnakeList,EllipseList];
%figure

snakefull = struct(...
    'S',	55 * ones(1,13),...
    'Th',	0 * ones(1,13),...
    'Ph',   (3*pi)/2 * ones(1,13),...
    'P_i',	[0;0;(-28-(55*12))],... 
    'R_i',	eye(3));

for i = 1:13
    for j = 1:length(navList)
        snakefull.Th(14-i) = navList(j).Th(1);
        if i > 1 %If there are two sections
            snakefull.Th(15-i) = ...
            navList(j).Th(2);
        end
        if i > 2 %If there are three sections
            snakefull.Th(16-i) = ...
            navList(j).Th(3);
        end
        snakefull.P_i = navList(j).P_i + [0;0;-55*(13-i)];
        navListFull(j + (i-1)*length(navList)) = snakefull;
    end
end

video = VideoWriter('vid_navPath_Full_temp.mp4','MPEG-4');
video.FrameRate = 60;
video.Quality = 100;
open(video)

hold off
plotCombustor_v1_highRes
[p,~,pp] = pathRecur(navListFull(1),5);
hold on
plot3(pp(1,:),pp(2,:),pp(3,:),'r-','linewidth',3)
plot3(p(1,:),p(2,:),p(3,:),'bd','linewidth',1)
hold off
daspect([1,1,1])
axis([-100 100 -400 400 0 800])
view(90,0)
frame = getframe(gcf);
writeVideo(video,frame);
frame = getframe(gcf);
writeVideo(video,frame);
frame = getframe(gcf);
writeVideo(video,frame);

for j = 1:length(navListFull)
    plotCombustor_v1_highRes
%     [p,~,pp] = pathRecur(navListFull(1),5);
%     
%     hold on
%     plot3(pp(1,:),pp(2,:),pp(3,:),'r-','linewidth',3)
%     plot3(p(1,:),p(2,:),p(3,:),'bd','linewidth',1)
    hold on
    [p,R,pp] = pathRecur(navListFull(j),5);
    hold on
    plot3(pp(1,:),pp(2,:),pp(3,:),'r-','linewidth',3)
    plot3(p(1,:),p(2,:),p(3,:),'bd','linewidth',1)
    % Plot Gun / Spray
    lengthGun = 35;
    spraypos = lengthGun - 6;
    sprayoff = 55;
    
    gEnd = (R*[0;0;lengthGun]) + p(:,end);
    sSta = (R*[0;0;spraypos])  + p(:,end);
    sEnd = (R*[0;sprayoff;spraypos]) + p(:,end);
    
    plot3([p(1,end) gEnd(1)],[p(2,end) gEnd(2)],[p(3,end) gEnd(3)],'g*-')
    
    plot3([sSta(1) sEnd(1)],[sSta(2) sEnd(2)],[sSta(3) sEnd(3)],'m*-')
    
%     drawnow();
    hold off
    daspect([1,1,1])
    axis([-100 100 -400 400 0 800])
    view(90,0)
    
    frame = getframe(gcf);
    writeVideo(video,frame);
    frame = getframe(gcf);
    writeVideo(video,frame);
    frame = getframe(gcf);
    writeVideo(video,frame);
end

close(video)