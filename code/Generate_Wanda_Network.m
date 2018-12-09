%% Generate Wanda_Network£¨wanda£©
clc;
clear all;
node_number=8;
node_initiate=4;
init_prob=0.6;
newlink=2;
node_matrix=Scale_Free(node_number,node_initiate,init_prob,newlink);