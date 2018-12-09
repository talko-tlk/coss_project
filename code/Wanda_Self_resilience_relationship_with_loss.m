%% To check the relatioinship of the recover_rate with the difference
clc;
clear all;
load('wanda.mat');
node_number=8;
a=4;b=3; %parameters to out of degree function to evluate the influence of one node to other nodes
out_degree=sum(node_matrix');
f_Oj=a*out_degree./(1+b*out_degree);
Mij=0.5*node_matrix;
tij=timedelay(node_number);
temp=f_Oj;
w=0.3;
dt=0.1; %time interval
T=36.5;
beta=0.025; %weak damping parameter;
x_initial=zeros(30,node_number); %without disturb
x_instant=[x_initial;0,0,0,-0.3,0,0,0,0];
diff1=[];
for recover_rate=0.15:0.01:0.80
    x_instant=[x_initial;0,0,0,-0.3,0,0,0,0];
    for t=dt:dt:T
        x=[];
        [size_element,size_nobody]=size(x_instant);
        for i=1:node_number
            sum_internal=0; %sum of internal influence;
            for j=1:node_number
                if (i~=j && node_matrix(j,i)~=0)
                    internal=Mij(j,i)*x_instant(size_element-int8(tij(j,i)/dt),j)*exp(-beta*tij(j,i))/f_Oj(j);
                    sum_internal=sum_internal+internal;
                end
            end
            alfa=2; %gain parameter
            theta=0; %threshold value
            y=sum_internal;%the input of sigmoidal function
            sig=sigmoidal(alfa,theta,y);
            dx=dt*(-x_instant(size_element,i)*recover_rate+sig*w);
    %         dx=dt*(-x_instant(size_element,i)/recover_rate+sig);
            x=[x,x_instant(size_element,i)+dx];
        end
        x_instant=[x_instant;x];
    end
    Xreal=[71.8,321.2,14.4,831.7,532,58.6,19.5,255.2]/365*0.1441*100;
    X_truevalue=Xreal.*(1+x_instant);
    diff1=[diff1,sum(sum(X_truevalue(31:end,:)))-sum(Xreal*365)];
end
figure
plot([0.15:0.01:0.80],diff1,'r');
xlabel('Recovery Rate'); ylabel('Difference/ (Million Swiss Franc)')