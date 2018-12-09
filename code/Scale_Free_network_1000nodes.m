%% Generation of the net work: network2: Scale-Free network ()

clc;
clear all;
node_number=1000;
node_initiate=40;
init_prob=0.3;
newlink=10;

node_matrix_Scale_Free=Scale_Free(node_number,node_initiate,init_prob,newlink);
out_degree_Scale_Free=sum(node_matrix_Scale_Free'); %Outdegree of the network;
node_actual_Scale_Free=mean(out_degree_Scale_Free) %actual mean node outdegree of the network

% only to be used for the analysis of the network
figure(1)
[Hist_Scale_Free,Frequence_Scale_Free]=hist(out_degree_Scale_Free,15);
bar(Frequence_Scale_Free,Hist_Scale_Free);
% Value showing: 
for i = 1:length(Frequence_Scale_Free)
text(Frequence_Scale_Free(i),Hist_Scale_Free(i)+0.5,num2str(Hist_Scale_Free(i)),'Color','r');
end
xlabel('Out-degree'),ylabel('Frequency')

figure(2)
UniDegree_Scale_Free=unique(out_degree_Scale_Free);
for i=1:length(UniDegree_Scale_Free)
    DegreeNum_Scale_Free(i)=sum(out_degree_Scale_Free==UniDegree_Scale_Free(i));
end
loglog(UniDegree_Scale_Free, DegreeNum_Scale_Free ./ sum(DegreeNum_Scale_Free),'.','markersize',18)
xlabel('Out-degree'),ylabel('Probability')

% calculate the entropy of the network
percentage_out_degree_Scale_Free=DegreeNum_Scale_Free ./ sum(DegreeNum_Scale_Free);
entropy_Scale_Free=sum(-percentage_out_degree_Scale_Free.*log2(percentage_out_degree_Scale_Free))