function TEAM34PS05Q3
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Days = zeros (12,1);
Augsix = 7*30+6;
for k = 1:12
    Days(k) = 30*(k-1)+15;
end
Rad = [144; 188; 245; 311; 351; 359; 308; 287; 260; 211; 159; 131];
figure
scatter(Days,Rad)

end

