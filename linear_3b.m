clear all;
X = [1,2];
Y = [1,3];

scatter(X,Y,50,'o','red','filled')
hold on;
p = polyfit(X,Y,1);

Y1 = polyval(p,X);

plot(X,Y1,".-.");


