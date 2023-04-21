% Parameter Estimation
% Annotations updated 10-November-2019, EJR

function [out] = hgf_softmax_mu3

% Load data set.
load('/Volumes/psr/Woodward_Lab/Julia/ResearchProjects/BeliefUpdating/Tasks/PRL-master/analysis/frompraveen/PRL_JMSpilot.mat');

%  Data set has 'ans' in it.  Remove.
clearvars ans;

%  Get list of all variables in workspace.
test = whos;

global mu02 mu03

%  Turn names into cell array.
for i = 1:size(test,1) 
    names{i,1} = test(i).name;
    sub_names{i,1} = names{i,1}(1,1:5);
end

%  Create list of all unique subject names.
unique_sub_names = unique(sub_names);

%  Create output cell array.

out{1,1} = 'Subject Number';
out{1,2} = 'Version';
out{1,3} = 'est_1';
out{1,4} = 'est_2'; 
out{1,5} = 'mu02_1'; 
out{1,6} = 'mu03_1';
out{1,7} = 'kappa2_1';
out{1,8} = 'omega2_1';
out{1,9} = 'omega3_1';
out{1,10} = 'BIC_1'; 
out{1,11} = 'mu02_2'; 
out{1,12} = 'mu03_2';
out{1,13} = 'kappa2_2';
out{1,14} = 'omega2_2';
out{1,15} = 'omega3_2';
out{1,16} = 'BIC_2';

%  Loop through all subjects, perform parameter estimations
for sub = 1:size(unique_sub_names,1)
    
    %  Current subject number is...
    current_sub = unique_sub_names{sub,1};
    
    %  Save in outcome variable.
    out{sub+1,1} = current_sub;
    
    %  Give me all variables corresponding to the current subject.
    sub_vars = find_in_cellstr(names,current_sub);
    
    %  Give us names of choices_1, choices_2, outcomes_1, and outcomes_2
    %  variables for this subject.
    current_choices_1_name = find_in_cellstr(sub_vars,'choices_1');
    current_choices_2_name = find_in_cellstr(sub_vars,'choices_2');
    current_outcomes_1_name = find_in_cellstr(sub_vars,'outcomes_1');
    current_outcomes_2_name = find_in_cellstr(sub_vars,'outcomes_2');
    
    current_est1 = tapas_fitModel(eval(current_choices_1_name{1,1}), eval(current_outcomes_1_name{1,1}), 'tapas_hgf_ar1_binary_mab_config_1', 'tapas_softmax_mu3_config');
    
    %  Save as est_1 in outcome variable.
    out{sub+1,3} = current_est1;
    
    %  Assign values to out variable.
    
    % Mu at 2nd level:
    out{sub+1,5} = current_est1.p_prc.mu_0(2);
    mu02 = current_est1.p_prc.mu_0(2);
    
    % Mu at 3rd level:
    out{sub+1,6} = current_est1.p_prc.mu_0(3);
    mu03 = current_est1.p_prc.mu_0(3);
    
    % Kappa at 2nd level:
    out{sub+1,7} = current_est1.p_prc.ka(2);
    
    % Omega at 2nd level:
    out{sub+1,8} = current_est1.p_prc.om(2);
    
    % Omega at 3rd level:
    out{sub+1,9} = current_est1.p_prc.om(3);
    
    % BIC:
    out{sub+1,10} = current_est1.optim.BIC; 
    
    current_est2 = tapas_fitModel(eval(current_choices_2_name{1,1}), eval(current_outcomes_2_name{1,1}), 'tapas_hgf_ar1_binary_mab_config_2', 'tapas_softmax_mu3_config');
    
    %  Save as est1 in outcome variable.
    out{sub+1,4} = current_est2;
    
    %  Assign values to out variable.
    
    % Mu at 2nd level:
    out{sub+1,11} = current_est2.p_prc.mu_0(2);
        
    % Mu at 3rd level:
    out{sub+1,12} = current_est2.p_prc.mu_0(3);
    
    
    % Kappa at 2nd level:
    out{sub+1,13} = current_est2.p_prc.ka(2);
    
    % Omega at 2nd level:
    out{sub+1,14} = current_est2.p_prc.om(2);
    
    % Omega at 3rd level:
    out{sub+1,15} = current_est2.p_prc.om(3);
    
    % BIC:
    out{sub+1,16} = current_est2.optim.BIC; 
    
    
end

%MT###_V#_est_1=tapas_fitModel(MT###_V#_choices_1, MT###_V#_outcomes_1, 'tapas_hgf_ar1_binary_mab_config_1','tapas_softmax_mu3_config');

%Update config file 'tapas_hgf_ar1_binary_mab_config_2', line 147
%Set c.mu_0mu = MT###_V#_est_1.p_prc.mu_0

%MT###_V#_est2=tapas_fitModel(MT###_V#_choices_2, MT###_V#_outcomes_2, 'tapas_hgf_ar1_binary_mab_config_2','tapas_softmax_mu3_config');

end
