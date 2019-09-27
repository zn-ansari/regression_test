clear all;
theta = [0,0];
thetax = zeros(1000,2);
Jthetax = zeros(1000,2);


for i=1:1000
    Jtheta = 0.5*[5*theta(1) + 3*theta(2) - 7, 3*theta(1) + 2*theta(2) - 4];
    theta = theta - 0.1*Jtheta;
    thetax(i,:) = theta;
    Jthetax(i,:) = Jtheta;
end