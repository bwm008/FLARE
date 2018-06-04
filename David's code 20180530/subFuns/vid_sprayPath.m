sprayList = [SnakeList,EllipseList];

video = VideoWriter('vid_sprayPath_temp.mp4','MPEG-4');
video.FrameRate = 30;
video.Quality = 100;
open(video)

hold off
SnakeTipinEngine1
hold off

view(70,20)

frame = getframe(gcf);
writeVideo(video,frame);
frame = getframe(gcf);
writeVideo(video,frame);
frame = getframe(gcf);
writeVideo(video,frame);

for j = 1:length(sprayList)
    SnakeTipinEngine1
    [p,R,pp] = pathRecur(sprayList(j),5);
    
    hold on
    plot3(pp(1,:),pp(2,:),pp(3,:),'r-')
    plot3(p(1,:),p(2,:),p(3,:),'bd')
    
    %Plot Gun / Spray
    gEnd = (R*[0;0;lengthGun]) + p(:,end);
    sSta = (R*[0;0;spraypos])  + p(:,end);
    sEnd = (R*[0;sprayoff;spraypos]) + p(:,end);
    
    plot3([p(1,end) gEnd(1)],[p(2,end) gEnd(2)],[p(3,end) gEnd(3)],'g*-')
    plot3([sSta(1) sEnd(1)],[sSta(2) sEnd(2)],[sSta(3) sEnd(3)],'m*-')
    hold off
    
    view(115,25)
    
    frame = getframe(gcf);
    writeVideo(video,frame);
    frame = getframe(gcf);
    writeVideo(video,frame);
    frame = getframe(gcf);
    writeVideo(video,frame);
end

close(video)