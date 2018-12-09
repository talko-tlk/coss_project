clc;
clear all;
node_number=12;
node_initiate=6;
init_prob=0.6;
newlink=3;
node_matrix_Scale_Free=Scale_Free(node_number,node_initiate,init_prob,newlink);
out_degree_Scale_Free=sum(node_matrix_Scale_Free'); %Outdegree of the network;
node_actual_Scale_Free=mean(out_degree_Scale_Free) %actual mean node outdegree of the network

% only to be used for the analysis of the network
figure(1)
[Hist_Scale_Free,Frequence_Scale_Free]=hist(out_degree_Scale_Free,15);
bar(Frequence_Scale_Free,Hist_Scale_Free);
% Value showing: 以下循环主要是为了得到柱状图的y轴值。可以设置数字的颜色。
for i = 1:length(Frequence_Scale_Free)
text(Frequence_Scale_Free(i),Hist_Scale_Free(i)+0.5,num2str(Hist_Scale_Free(i)),'Color','r');
end
xlabel('out-degree'),ylabel('Frequency')

figure(2)
UniDegree_Scale_Free=unique(out_degree_Scale_Free);
for i=1:length(UniDegree_Scale_Free)
    DegreeNum_Scale_Free(i)=sum(out_degree_Scale_Free==UniDegree_Scale_Free(i));
end
loglog(UniDegree_Scale_Free, DegreeNum_Scale_Free ./ sum(DegreeNum_Scale_Free),'.','markersize',18)
xlabel('k'),ylabel('P(k)')

% calculate the entropy of the network
percentage_out_degree_Scale_Free=DegreeNum_Scale_Free ./ sum(DegreeNum_Scale_Free);
entropy_Scale_Free=sum(-percentage_out_degree_Scale_Free.*log2(percentage_out_degree_Scale_Free))
