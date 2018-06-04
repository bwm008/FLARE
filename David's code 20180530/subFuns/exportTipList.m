if ~exist('tipList','var')
    disp('no tipList variable found')
else
    fid = fopen('exportedTipList.txt','w');
    for i = 1:length(tipList)
        row = [i, tipList(i).Th, tipList(i).Ph];
        fprintf(fid,'%d, ',i);
        fprintf(fid,'%.6e, %.6e, %.6e, ',tipList(i).Th);
        fprintf(fid,'%.6e, %.6e, %.6e ' ,tipList(i).Ph);
        fprintf(fid,'\r\n');
    end
    fclose(fid);
end