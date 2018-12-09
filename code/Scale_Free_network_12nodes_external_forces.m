%% with the external force
a1=100;b1=3;c1=2;
T=0.1:0.1:4;
figure
R=a1*power(T,b1).*exp(-c1*T);
plot(T,a1*power(T,b1).*exp(-c1*T));

node_matrix=node_matrix_Scale_Free;
a=4;b=3; %parameters to out of degree function to evluate the influence of one node to other nodes
out_degree=sum(node_matrix');
f_Oj=a*out_degree./(1+b*out_degree);
Mij=0.5*node_matrix;
tij=timedelay(node_number);
recover_rate_start=1/4;
temp=f_Oj;
dt=0.1; %time interval
T=50;
beta=0.025; %weak damping parameter;
beta2=1/5;
alpha2=0.58;
x_initial=zeros(30,node_number); %without disturb
x_instant=[x_initial;0,0,0,0,0,0,0,0,0,0,0,-0.3];
w=0.35;
% x_instant=[x_initial;zeros(1,450) -0.3 zeros(1,549)];
re_rate=[];
for t=dt:dt:T
    x=[];
    [size_element,size_nobody]=size(x_instant);
    if ((10*dt<t) && (t<51*dt))
        R=a1*power(t-10*dt,b1).*exp(-c1*(t-10*dt));
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
figure;
for i=1:node_number
    plot(-30:T/dt,x_instant(:,i));
    hold on
end
xlabel('Time/day'); ylabel('Disturbance')

threshold=-0.2;
figure
NumberofPointsFail=sum((x_instant<threshold)');
plot(-30:T/dt,NumberofPointsFail)
xlabel('Time/day'); ylabel('Damaged Point')
figure;
for i=1:node_number
    plot(dt:T/dt,re_rate(:,i));
    hold on
end
xlabel('Time/day'); ylabel('Recovery Rate')