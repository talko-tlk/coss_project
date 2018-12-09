clc;
clear all;
node_number=12;
node_neighbour=4;
P_reconnect=0.2;
node_matrix_Small_World=Small_World(node_number,node_neighbour,P_reconnect);
out_degree_Small_World=sum(node_matrix_Small_World'); %Outdegree of the network;
node_actual_Small_World=mean(out_degree_Small_World) %actual mean node outdegree of the network

figure(1)
[Hist_Small_World,Frequence_Small_World]=hist(out_degree_Small_World,15);
bar(Frequence_Small_World,Hist_Small_World);
% Value showing: ����ѭ����Ҫ��Ϊ�˵õ���״ͼ��y��ֵ�������������ֵ���ɫ��
for i = 1:length(Frequence_Small_World)
text(Frequence_Small_World(i),Hist_Small_World(i)+0.5,num2str(Hist_Small_World(i)),'Color','r');
end
xlabel('Out-degree'),ylabel('Frequency')
figure(2)
UniDegree_Small_World=unique(out_degree_Small_World);
for i=1:length(UniDegree_Small_World)
    DegreeNum_Small_World(i)=sum(out_degree_Small_World==UniDegree_Small_World(i));
end
loglog(UniDegree_Small_World, DegreeNum_Small_World ./ sum(DegreeNum_Small_World),'.','markersize',18)
xlabel('Out-degree'),ylabel('Probability')

% calculate the entropy of the network
percentage_out_degree_Small_World=DegreeNum_Small_World ./ sum(DegreeNum_Small_World);
entropy_Small_World=sum(-percentage_out_degree_Small_World.*log2(percentage_out_degree_Small_World))