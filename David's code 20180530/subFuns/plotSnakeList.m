function plotSnakeList(SnakeList, Step, varargin )
if Step == 0
    for i = 1:length(SnakeList)
        if nargin <= 2
            plotSnakeList(SnakeList,i);
        else
            plotSnakeList(SnakeList,i,varargin{:});
        end
        hold on
    end
else
    [P,~,Path] = pathRecur(SnakeList(Step),50);
    if nargin <= 2
        plot3(Path(1,:),Path(2,:),Path(3,:),'r-','linewidth',0.5)
    else
        plot3(Path(1,:),Path(2,:),Path(3,:),varargin{:})
    end
    hold on
    plot3(P(1,:),P(2,:),P(3,:),'bd')
end

daspect([1,1,1])
view(80,0)
grid on
xlabel('X (mm)')
ylabel('Y (mm)')
zlabel('Z (mm)')
hold off

end