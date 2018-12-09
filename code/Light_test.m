%% 
% This is the main function to run; it is recommended to run it in section
% You can do it by pressing ctrl+enter in the section you selected or you
% could tap on the button in the top

%% First Part -Generation of the network(1000nodes)
% This part is used to generate the 1000-node Erdos_Renyi network and to
% evaluate its peroformance and out-degree distribution
% Note: the network is generated randomly, so every time you run it, you
% will run into a different network with similar properties
    %% 1-1 Erdos_Renyi
        Erdos_Renyi_network_1000nodes; % Generation of the Erdos_Renyi_network
    
    
    %% 1-2 Scale_Free
        Scale_Free_network_1000nodes;  % Generation of the Scale_Free_network

%% Second Part -Analysis of the network with and without external forces(12nodes)
% This part is used to analysis the 12-nodes network resilience without or
% with external resource simulation
% Note: the network is generated randomly, so every time you run it, you
% will run into a different network with similar properties 
    %% 2-1 Erdos_Renyi
        %% 2-1-1 Generation of the 12-node Erdos_Renyi
            Erdos_Renyi_network_12nodes
         
        %% 2-1-2 Erdos_Renyi_self_resilience
            Erdos_Renyi_network_12nodes_self_resilience; % Analyse the 12node Erdos_Renyi_network without external forces
         
        %% 2-1-3 Erdos_Renyi_external_forces
            Erdos_Renyi_network_12nodes_external_forces; % Analyse the 12node Erdos_Renyi_network with external forces
     
    %% 2-2 Scale_Free    
        %% 2-2-1 Generation of the 12-node Scale_Free
            Scale_Free_network_12nodes
         
        %% 2-2-2 Erdos_Renyi_self_resilience
            Scale_Free_network_12nodes_self_resilience; % Analyse the 12node Erdos_Renyi_network without external forces
         
        %% 2-2-3 Erdos_Renyi_external_forces
            Scale_Free_network_12nodes_external_forces; % Analyse the 12node Erdos_Renyi_network with external forces
    
%% Third Part -Analysis of the network of Wanda
% This part is used to analysis the 8-nodes network resilience without or
% with external resource simulation based on the conditions of Wanda, a Chinese grand firm.
% Note: the network is generated randomly, so every time you run it, you
% will run into a different network with similar properties  But to ensure the load of data is correct, we would use the same network for the analysising but some parameters are different
% So there may be a little differnce from what you get and the result shown
% by us

    %% 3-1 Generation of the Wanda Network
        Generate_Wanda_Network; %use this once, later the network in use will be the one we generated before, so we will load the data from the wanda.mat
        
    %% 3-2 Self_resilience_discussion
        %% 3-2-1 Wanda_Self_resilience
            Wanda_Self_resilience
            
        %% 3-2-2 Wanda_Self_resilience_relationship_with_loss
            Wanda_Self_resilience_relationship_with_loss
            
    %% 3-3 External_Force_discussion
        %% 3-3-1 Wanda_external_force
            Wanda_external_force
         
        %% 3-3-2 Wanda_Response_time_Relaionship_with_loss
            Wanda_Response_time_Relaionship_with_loss
        
        %% 3-3-3 Wanda_External_Force_Relationship_with_loss
            Wanda_External_Force_Relationship_with_loss
        
        