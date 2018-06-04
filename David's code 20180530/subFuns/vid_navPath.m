% For creating video animation of spraying process as calculated by
% sprayPathCalc (05/10/16 Dr. David Palmer)

%sprayList = [SnakeList,EllipseList];

%figure


video = VideoWriter('vid_navPath_temp.mp4','MPEG-4');
video.FrameRate = 30;
video.Quality = 100;

open(video)

hold off
plotCombustor_v1_highRes
    [p,~,pp] = pathRecur(navList(1),5);
    
    hold on
    plot3(pp(1,:),pp(2,:),pp(3,:),'r-','linewidth',3)
    plot3(p(1,:),p(2,:),p(3,:),'bd','linewidth',1)
hold off

daspect([1,1,1])
axis([-100 100 -50 150 0 150])
view(120,15)

frame = getframe(gcf);
        writeVideo(video,frame)
        frame = getframe(gcf);
        writeVideo(video,frame)
        frame = getframe(gcf);
        writeVideo(video,frame)

for j = 1:length(navList)

    plotCombustor_v1_highRes
    [p,~,pp] = pathRecur(navList(1),5);
    
    hold on
    plot3(pp(1,:),pp(2,:),pp(3,:),'r-','linewidth',3)
    plot3(p(1,:),p(2,:),p(3,:),'bd','linewidth',1)
    hold on
    
    [p,~,pp] = pathRecur(navList(j),5);
    
    hold on
    plot3(pp(1,:),pp(2,:),pp(3,:),'r-')
    plot3(p(1,:),p(2,:),p(3,:),'bd')
    
%     %% Plot Gun / Spray
%     gEnd = (R*[0;0;lengthGun])   + p(:,end);
%     sSta = (R*[0;0;spraypos])    + p(:,end);
%     sEnd = (R*[0;sprayoff;spraypos])   + p(:,end);
%     
%     plot3([p(1,end) gEnd(1)],[p(2,end) gEnd(2)],[p(3,end) gEnd(3)],'g*-')
%     
%     plot3([sSta(1) sEnd(1)],[sSta(2) sEnd(2)],[sSta(3) sEnd(3)],'m*-')
    
%     drawnow();
    hold off
    
    view(120,15)
    axis([-100 100 -50 150 0 150])
    
    frame = getframe(gcf);
        writeVideo(video,frame)
        frame = getframe(gcf);
        writeVideo(video,frame)
        frame = getframe(gcf);
        writeVideo(video,frame)
end

close(video)