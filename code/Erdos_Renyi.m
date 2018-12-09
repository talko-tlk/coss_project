function [node_matrix]=Erdos_Renyi(node_number,node_expectation)
node_matrix=rand(node_number);
Indicator_compare=node_expectation/(node_number-1);
for i=1:node_number
    for j=i:node_number
        if (i==j)
            node_matrix(i,j)=0;
        else
            if (node_matrix(i,j)<1-Indicator_compare)
                node_matrix(i,j)=0;
                node_matrix(j,i)=0;
            else
                node_matrix(i,j)=1;
                node_matrix(j,i)=1;
            end
        end
    end
end