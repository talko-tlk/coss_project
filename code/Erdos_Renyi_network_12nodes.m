clc;
clear all;
node_number=12; 
node_expectation=4; %expected out-degree of each node;

node_matrix_Erdos_Renyi=Erdos_Renyi(node_number,node_expectation); %generation of the Erdos-Renyi network
out_degree_Erdos_Renyi=sum(node_matrix_Erdos_Renyi'); %Outdegree of the network;
node_actual_Erdos_Renyi=mean(out_degree_Erdos_Renyi) %actual mean node outdegree of the network

% only to be used for the analysis of the network
figure(1)
[Hist_Erdos_Renyi,Frequence_Erdos_Renyi]=hist(out_degree_Erdos_Renyi,15);
bar(Frequence_Erdos_Renyi,Hist_Erdos_Renyi);
% Value showing: 
for i = 1:length(Frequence_Erdos_Renyi)
text(Frequence_Erdos_Renyi(i),Hist_Erdos_Renyi(i)+0.5,num2str(Hist_Erdos_Renyi(i)),'Color','r');
end
xlabel('Out-degree'),ylabel('Frequency')


figure(2)
UniDegree_Erdos_Renyi=unique(out_degree_Erdos_Renyi);
for i=1:length(UniDegree_Erdos_Renyi)
    DegreeNum_Erdos_Renyi(i)=sum(out_degree_Erdos_Renyi==UniDegree_Erdos_Renyi(i));
end
loglog(UniDegree_Erdos_Renyi, DegreeNum_Erdos_Renyi ./ sum(DegreeNum_Erdos_Renyi),'.','markersize',18)
xlabel('Out-degree'),ylabel('Probability')


% calculate the entropy of the network
percentage_out_degree_Erdos_Renyi= DegreeNum_Erdos_Renyi ./ sum(DegreeNum_Erdos_Renyi);
entropy_Erdos_Renyi=sum(-percentage_out_degree_Erdos_Renyi.*log2(percentage_out_degree_Erdos_Renyi))