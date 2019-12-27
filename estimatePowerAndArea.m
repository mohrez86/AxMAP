function [Power, Area] = estimatePowerAndArea(simplifiedMatrixExpressionForm)

% Load NanGate library

    nanGateLibrary = loadNanGateOpenCellLibrary_Typical;

% simplifiedMatrixExpressionForm is a Cell containing several matrices

    numberOfBooleanFunctions = size(simplifiedMatrixExpressionForm, 1);
    
    
    gateCostMatrixForm = cell(numberOfBooleanFunctions, 1);
        
    for n=1:numberOfBooleanFunctions
        
        [Rows, Columns] = size(simplifiedMatrixExpressionForm{n});
        % Rows, if more than 1, is the number of inputs for the OR gate
        
        gateCostMatrixForm{n,1} = zeros(Rows, 2);
        % in the first column, the number of NOT gates are stored
        % in the second column, the number of inputs of AND gate is stored
        
        for  i=1:Rows
            for j=1:Columns
                
                % 1- storing the number of NOT gates
                if ( simplifiedMatrixExpressionForm{n}(i, j) == 1 )
                    
                    if( mod(j, 2) == 0 )
                        gateCostMatrixForm{n,1}(i, 1) = gateCostMatrixForm{n,1}(i, 1) + 1;
                    end
                    
                end
                
                % 2- storing the number of inputs for AND gate
                gateCostMatrixForm{n,1}(i, 2)= sum(simplifiedMatrixExpressionForm{n}(i, :)); 
                
            end
        end
    end
    
    %----------------------------------------------------------------------
    % Estimating Power and Area
    
    
    % CASE 1 : NOT Gates---------------------------------------------------
    notPower = 0; 
    notArea = 0;
    
    numOfNOTGates = 0;
    
    for n=1:numberOfBooleanFunctions
        numOfNOTGates = numOfNOTGates + sum ( gateCostMatrixForm{n}(:, 1) );
    end
        notPower = numOfNOTGates * nanGateLibrary{4, 2};
        notArea = numOfNOTGates * nanGateLibrary{4, 4};
    %----------------------------------------------------------------------
    % CASE 2 : AND Gates---------------------------------------------------
    andPower = 0;
    andArea = 0;
    
    %numOfANDGates = 0;
    
    numOfAND2 = 0;
    numOfAND3 = 0;
    numOfAND4 = 0;
    
    for n=1:numberOfBooleanFunctions
        for i=1:size(gateCostMatrixForm{n}, 1)
            
            temp = gateCostMatrixForm{n}(i, 2);
            
            if ( temp > 1 )
                while ( temp > 4)
                    
                    numOfAND4 = numOfAND4 + floor(temp/4);
                    
                    temp = temp - floor(temp/4) * 4 + floor(temp/4);
                end
                    
                if(temp == 4)
                    numOfAND4 = numOfAND4 + 1;
                elseif (temp == 3)
                    numOfAND3 = numOfAND3 + 1;
                elseif (temp == 2)
                    numOfAND2 = numOfAND2 + 1;
                end
            end

        end
    end 
    
    andPower = (numOfAND2 * nanGateLibrary{6, 2}) + ... 
               (numOfAND3 * nanGateLibrary{7, 2}) + ... 
               (numOfAND4 * nanGateLibrary{8, 2});
    andArea = (numOfAND2 * nanGateLibrary{6, 4}) + ...
              (numOfAND3 * nanGateLibrary{7, 4}) + ... 
              (numOfAND4 * nanGateLibrary{8, 4});
    
    %----------------------------------------------------------------------
    % CASE 3 : OR Gates----------------------------------------------------
    
    
    orPower = 0;
    orArea = 0;
    
    numOfOR2 = 0;
    numOfOR3 = 0;
    numOfOR4 = 0;
    
    for n=1:numberOfBooleanFunctions
        temp = size(gateCostMatrixForm{n}, 1);
        if ( temp > 1)
            while (temp > 4)
                numOfOR4 = numOfOR4 + floor(temp/4);
                
                temp = temp - floor(temp/4) * 4 + floor(temp/4);
            end
            
            if(temp == 4)
                numOfOR4 = numOfOR4 + 1;
            elseif (temp == 3)
                numOfOR3 = numOfOR3 + 1;
            elseif (temp == 2)
                numOfOR2 = numOfOR2 + 1;
            end
            
        end
    end
    
    orPower = (numOfOR2 * nanGateLibrary{9, 2}) + ... 
               (numOfOR3 * nanGateLibrary{10, 2}) + ... 
               (numOfOR4 * nanGateLibrary{11, 2});
    orArea = (numOfOR2 * nanGateLibrary{9, 4}) + ...
              (numOfOR3 * nanGateLibrary{10, 4}) + ... 
              (numOfOR4 * nanGateLibrary{11, 4});
    %----------------------------------------------------------------------
    Power = notPower + andPower + orPower;
    Area = notArea + andArea + orArea;
    %----------------------------------------------------------------------
end