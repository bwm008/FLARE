% Converts current tipList value into a struct suitable for the Export function
n = length(sprayList);
tipList(1:n) = struct( 'Th', zeros(1,3), 'Ph', zeros(1,3));  

for i = 1:n
    tipList(i).Th = (sprayList(i).Th  * -1)  * (180/pi);
    tipList(i).Ph = (sprayList(i).Ph  - pi)  * (180/pi);
end