if ~exist('xSnakeList','var')
    disp('no xSnakeList variable found /n')
    
    if exist('navListFull','var')
        disp('converting navListFull /n')
        prep_navListFull
    else
        disp('no navListFull variable found /n')
        return
    end
    
end
    
    fid = fopen('exportedSnakeList.txt','w');
    
    for i = 1:length(xSnakeList)
        
        row = [i, xSnakeList(i).S, xSnakeList(i).bodyTh, xSnakeList(i).tipTh, xSnakeList(i).tipPh, xSnakeList(i).feed];
        
        fprintf(fid,'%d, ',i);
        fprintf(fid,'%d, ',xSnakeList(i).S);
        fprintf(fid,'%.6e, %.6e, %.6e, %.6e, %.6e, %.6e, %.6e, %.6e, %.6e, %.6e, ',xSnakeList(i).bodyTh);
        fprintf(fid,'%.6e, %.6e, %.6e, ',xSnakeList(i).tipTh);
        fprintf(fid,'%.6e, %.6e, %.6e, ',xSnakeList(i).tipPh);
        fprintf(fid,'%.6e ',xSnakeList(i).feed);
        fprintf(fid,'\r\n');
    end
    
    fclose(fid);