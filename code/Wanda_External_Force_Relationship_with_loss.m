%%
clc;
clear all;
a1=100;b1=3;c1=2;
T=0.1:0.1:4;
w=0.3;
R=a1*power(T,b1).*exp(-c1*T);
% plot(T,a1*power(T,b1).*exp(-c1*T));
load('wanda.mat');
node_number=8;
a=4;b=3; %parameters to out of degree function to evluate the influence of one node to other nodes
out_degree=sum(node_matrix');
f_Oj=a*out_degree./(1+b*out_degree);
Mij=0.5*node_matrix;
tij=timedelay(node_number);
temp=f_Oj;
dt=0.1; %time interval
T=36.5;
beta=0.025; %weak damping parameter;
x_initial=zeros(30,node_number); %without disturb

re_rate=[];
beta2=1/5;
alpha2=0.58;
recover_rate_start=1/4;
diff1=[];
T_response=10*dt;
for a1=10:10:400
    x_instant=[x_initial;0,0,0,-0.3,0,0,0,0];
    for t=dt:dt:T
        x=[];
        [size_element,size_nobody]=size(x_instant);
        if ((T_response<t) && (t<T_response+40*dt))
            R=a1*power(t-T_response,b1).*exp(-c1*(t-T_response));
            allocation_R=out_degree/sum(out_degree)*R;
        end
        temp_rate=[];
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
            if ((10*dt<t) && (t<51*dt))
               recover_rate=1/((1/recover_rate_start-beta2)*exp(-alpha2*allocation_R(i))+beta2);
            else
                recover_rate=recover_rate_start;
            end
            temp_rate=[temp_rate recover_rate];
            dx=dt*(-x_instant(size_element,i)*recover_rate+sig*w);
    %         dx=dt*(-x_instant(size_element,i)/recover_rate+sig);
            x=[x,x_instant(size_element,i)+dx];
        end
        re_rate=[re_rate;temp_rate];
        x_instant=[x_instant;x];
    end
    Xreal=[71.8,321.2,14.4,831.7,532,58.6,19.5,255.2]/365;
    X_truevalue=Xreal.*(1+x_instant);
    X_sum=sum(X_truevalue(31:end,:));
    diffX=sum(X_sum-Xreal*365);
    diff1=[diff1 diffX];
end
plot(10:10:400,diff1)
xlabel('External Force Amplitude Parameter');
ylabel('Difference/(0.1*Billion Yuan)')