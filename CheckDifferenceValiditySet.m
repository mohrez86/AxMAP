function [ DifferentSecondExperiment_MEDPowerArea, Flag, NumOfSame, SamePairVector ] = ...
         CheckDifferenceValiditySet( SecondExperiment_MEDPowerArea )

    % FUNCTION DESCRIPTION
    NumOfAdders = size(SecondExperiment_MEDPowerArea{2}, 2);
    
    NumOfSame      = 0;
    SamePairVector = [];
    
    MAP1 = zeros(1, 3);
    MAP2 = zeros(1, 3);
    
    DifferentSecondExperiment_MEDPowerArea = SecondExperiment_MEDPowerArea;
    
    Flag = true;
    %% 
    for i = 1 : NumOfAdders - 1
        for j = i+1 : NumOfAdders
            
                
                MAP1(1,1) = SecondExperiment_MEDPowerArea{2}(1, i); % POWER
                MAP1(1,2) = SecondExperiment_MEDPowerArea{3}(1, i); % AREA
                MAP1(1,3) = SecondExperiment_MEDPowerArea{4}(1, i); % MED
                
                MAP2(1,1) = SecondExperiment_MEDPowerArea{2}(1, j); % POWER
                MAP2(1,2) = SecondExperiment_MEDPowerArea{3}(1, j); % AREA
                MAP2(1,3) = SecondExperiment_MEDPowerArea{4}(1, j); % MED
                
                %------------------------------------------------------
                if isequal(MAP1, MAP2)
                    NumOfSame      = NumOfSame + 1; 
                    SamePairVector = [SamePairVector; i, j]; 
                    Flag  = false;
                end
                %------------------------------------------------------
            
        end
    end
end

