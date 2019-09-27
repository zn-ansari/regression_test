%run this script to load data, and normalize data
clear all
load('mnist35.mat')

%%normalize  data
trainx=double(trainx)/255;
testx=double(testx)/255;

n_train=length(trainy);%total number of training samples
n_test=length(testy);%total number of test samples

m_data=size(trainx,2);%dimension of original feature vector


trainx=[trainx ones(n_train,1)];%  add dummy feature 1
testx=[testx ones(n_test,1)];%  add dummy feature 1
theta=zeros(m_data+1,1);%initialize theta, dimension is 784+1, where the last entry is b
alpha=0.5;%step size 

% trainy(1:1000,1) = 1;
% trainy(1001:2000,1) = 0;
trainy(trainy==1) = 1;
trainy(trainy==-1) = 0;

testy(testy==1) = 1;
testy(testy==-1) = 0;

sindx = randperm(2000);
strainx = trainx(sindx,:);
strainy = trainy(sindx,:);

htheta = strainx*theta;
% % %loss_theta = (trainy - htheta)'*trainx;
etheta = exp(-htheta);
gtheta = 1./(1+etheta);
loss_theta =  strainx'*(strainy - gtheta);
l2_norm = norm(loss_theta,2);

flag = 0;
cnt = 0;
% 
while( flag == 0)
    for i = 1:2000        
%         theta = theta + strainx(i,:)'*(strainy(i)-htheta(i));
         i_htheta = strainx(i,:)*theta;
         i_etheta = exp(-i_htheta);
         i_gtheta = 1/(1+i_etheta);
         theta = theta + strainx(i,:)'*(strainy(i)-i_gtheta);
         if (mod(i,200)==0)
              htheta = strainx*theta;
              etheta = exp(-htheta);
              gtheta = 1./(1+etheta);
              loss_theta = strainx'*(strainy - gtheta);
              l2_norm = norm(loss_theta,2);
%               theta = theta + alpha.*loss_theta;
              if (l2_norm < 1e-5) 
                flag = 1;
                break;
              end
         end        
    end
    cnt = cnt + 1;
end


   trn_htheta = trainx*theta;
   trn_etheta = exp(-trn_htheta);
   trn_gtheta = 1./(1+trn_etheta);

tst_htheta = testx*theta;
tst_etheta = exp(-tst_htheta);
tst_gtheta = 1./(1+tst_etheta);
    
trn_gtheta(trn_gtheta<0.5) = 0;
trn_gtheta(trn_gtheta>0.5) = 1;

tst_gtheta(tst_gtheta<0.5) = 0;
tst_gtheta(tst_gtheta>0.5) = 1;

ctrn = sum(trainy~=trn_gtheta);
ctst = sum(testy~=tst_gtheta);

%calculating 0-1 loss percent
ctrnp = ctrn/2000 * 100;
ctstp = ctst/1902 * 100;

fprintf('The 0-1 error loss for stochastic gradient descent is calculated to be %.2f %% for the training dataset\n',ctrnp);
fprintf('The 0-1 error loss for stochastic gradient descent is calculated to be %.2f %% for the test dataset\n',ctstp);
fprintf('The whole dataset is used %.2f times\n',cnt);

