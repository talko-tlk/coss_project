function [node_matrix]=Scale_Free(node_number,node_initiate,init_prob,newlink)
node_matrix=rand(node_initiate);
node_expectation=2;
Indicator_compare=init_prob;
for i=1:node_initiate
    for j=1:node_initiate
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
out_degree_Scale_Free=sum(node_matrix');
total_degree_Scale_Free=sum(out_degree_Scale_Free);
n=node_initiate;
node_newlink=newlink;
for t=1:node_number-node_initiate
    p_subsection=[];
    sum_p=0;
    for i=1:n
        p=out_degree_Scale_Free(i)/total_degree_Scale_Free;
        sum_p=sum_p+p;
        p_subsection=[p_subsection,sum_p];
    end
    index_occupy=zeros(1,n);
    NewLinkIndex_Scale_Free=[];
    Number_NewLinkIndex=length(NewLinkIndex_Scale_Free);
    while(Number_NewLinkIndex<node_newlink)
        m0=rand(1);
        
        for i=1:n-1
            if (index_occupy(i+1)~=1 && m0>p_subsection(i) && m0<= p_subsection(i+1))
                m0=i+1;
                NewLinkIndex_Scale_Free=[NewLinkIndex_Scale_Free,i+1];
                index_occupy(i+1)=1;
            end
        end
        if(index_occupy(1)~=1 && m0<=p_subsection(1))
            m0=1;
            NewLinkIndex_Scale_Free=[NewLinkIndex_Scale_Free,1];
            index_occupy(1,1)=1;
        end
        Number_NewLinkIndex=length(NewLinkIndex_Scale_Free);
    end
    n=n+1;
    node_matrix=[node_matrix;index_occupy];
    index_occupy=[index_occupy 0]';
    node_matrix=[node_matrix index_occupy];
    out_degree_Scale_Free=sum(node_matrix');
    total_degree_Scale_Free=sum(out_degree_Scale_Free);
end