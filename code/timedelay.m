function [AnsMatrix] = timedelay(node_number)
% The time delays tij are X^2-distributed,
% where we have chosen ¦Ì = 4 for the number of degrees freedom of the X^2-function.
% However, the distribution was stretched multiplying by factor 0.05 and shifted by
% adding the value 1.2 in order to get an average delay of tij = 1.4.
start=0;
ending=10;
interval=(ending-start)/node_number;
x=start:interval:ending-interval;
cdf=chi2cdf(x,4); %Chi-square cumulative distribution function,computes the chi-square cdf 
                %at each of the values in x using the corresponding degrees of freedom in v.              
%plot(x,cdf)
RandMatrix=rand(node_number,node_number);
AnsMatrix=zeros(node_number,node_number);
for i=1:node_number
    for j=1:node_number
        Val=RandMatrix(i,j);
        for k=1:node_number
        if Val>=cdf(1,k)
            timedelay_value=interval*k;
        end
        AnsMatrix(i,j)=0.05*(timedelay_value)+1.2;
        AnsMatrix(i,j)=floor(10*AnsMatrix(i,j))/10;
        end
        if(i==j)
            AnsMatrix(i,j)=0;
            AnsMatrix(i,j)=floor(10*AnsMatrix(i,j))/10;
        end
    end
end
timedelay_mean=sum(sum(AnsMatrix))/node_number/(node_number-1)
end

