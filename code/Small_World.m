function [node_matrix]=Small_World(node_number,K,p)
node_matrix = zeros(node_number, node_number);
for i=1:K/2
    node_matrix = node_matrix + diag(ones(1, length(diag(node_matrix, i))), i);
end
node_matrix = sparse(node_matrix);
for i=1:K/2
    node_matrix(i, (node_number-K/2+i):node_number) = 1;
end
node_matrix = node_matrix + node_matrix';
for i=1:K/2
    P = rand(1,node_number);
    P = find(P <= p);
    for j=1:length(P)
        while true
            x = fix(rand()*node_number)+1;
            if node_matrix(x, P(j)) == 0
                node_matrix(x, P(j)) = 1;
                node_matrix(P(j), x) = 1;
                break;
            end
        end
        
        if P(j) <= node_number-i
            node_matrix(node_number-i, P(j)) = 0;
            node_matrix(P(j), node_number-i) = 0;
        else
            node_matrix(P(j)-node_number+i, P(j)) = 0;
            node_matrix(P(j), P(j)-node_number+i) = 0;
        end
 
    end
end
clear i j P x
B3 =node_matrix^3;
B33 = B3(1:node_number+1:end);
B2 = node_matrix^2;
B22 = B2(1:node_number+1:end);
c = B33./(B22.*(B22-1));
c(isnan(c)) = 0;
C = mean(c);
clear B33 B3 B2 B22

Paths = graphallshortestpaths(tril(node_matrix), 'directed', false);
Paths = tril(Paths);
L = sum(sum(Paths)) / nchoosek(node_number, 2);