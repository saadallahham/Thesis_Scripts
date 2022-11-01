
clear all;
close all;
clc;


%% Loading the well logs:

% ========================================================================

%%% this process for each well that will use %%%

load W01.asc; % Vertical matrix of data

DEPTH_W01   = W01(:,1); 
FACIES_W01  = W01(:,2);  
GammaRay_W01 = W01(:,3);  
DENSITY_W01 = W01(:,4);  
SONICO_W01 = W01(:,5);  
Resistivity_W01 = W01(:,6);  
Neutron_Dec_W01 = W01(:,7); 
PERMEABILITY_W01 = W01(:,8); 
POROSITY_W01 = W01(:,9); 

save('W01.mat','DEPTH_W01','FACIES_W01','GammaRay_W01','DENSITY_W01','SONICO_W01','Resistivity_W01','Neutron_Dec_W01','PERMEABILITY_W01','POROSITY_W01');


[L_W01,C_W01] = size(DEPTH_W01); % L1 = Number of rows of the "Depth" matrix.

Train_W01 = zeros(L_W01,5); % Null array of input data (Input).
Target_W01 = zeros(L_W01,1); % Null vector of the target (Target).


for i = 1:L_W01
    Train_W01(i,1) = GammaRay_W01(i,1);
    Train_W01(i,2) = DENSITY_W01(i,1);
    Train_W01(i,3) = SONICO_W01(i,1);
    Train_W01(i,4) = Neutron_Dec_W01(i,1);
    Train_W01(i,5) = Resistivity_W01(i,1);
    Train_W01(i,6) = PERMEABILITY_W01(i,1);
    Target_W01(i,1) = PERMEABILITY_W01(i,1); 
end;


% change array to table
trainingData = array2table(Train_W01)

% create final data table
trainingData.Properties.VariableNames = {'GAMMARAY', 'DENSITY', 'SONICO', 'NEUTRON', 'RESISTIVITY_log', 'PERMEABILITY'};


