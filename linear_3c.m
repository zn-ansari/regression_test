%run this script to load data, and normalize data
clear all;
load('3c.mat');


 X = rand(15,1);
 Y = X.^3-X.^2+1;

for i=1:6
subplot(3,2,i)
scatter(x,y,20,'t','blue');
hold on;
 scatter(X,Y,20,'s','blue','filled');
p = polyfit(x,y,i);
Y1 = polyval(p,x);
if i ~= 6
    plot(x,Y1,".-.");
else 
    plot(x,x.^3-x.^2+1,"--");
end
xlabel('X');
ylabel('Y');
switch i
    case 1
        title('degree 1 ');
    case 2
        title('degree 2 ');
    case 3
        title('degree 3 ');
    case 4
        title('degree 4 ');
    case 5
        title('degree 5 ');
    case 6
        title('underlying truth');
end
end

