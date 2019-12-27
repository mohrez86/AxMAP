classdef BasicBuildingBlocks

    properties
        Length; 
        delay;
        truthTable;
        errorTable;
        carryOut; % type logical: determines that whether ... 
            %the block generates carryOut or not
        carryIn; % type logical: determines that whether ... 
            %the block recieves carryIn or not
        
        %carryInProbability;
        %carryOutPorbability;
        
        carryChainLength;
        carryChainStartingPosition;
        listOfStructuralBuildingBlocks; % Array of integers: contains the list and order of 
            % smaller building blocks constructing this larger bulding blocks
        gateLevelEquation;
        % Circuit and Error Characteristics
        UER; % Uniform Error Rate
        UMED; % Uniform Mean Error Distange
        
        % power estimation 
        Power;
        % area estimation (Later)
        Area;
        
        % Power-NUMED Product
        PNUMEDP;
        
        % UMRED; % Uniform Mean Relative Error Distance (Later)
        % UMSE; % Uniform Mean Squared Error Distance (Later)
        % PDP (Later)
    end
    
    methods
        
        % 1- Constructor
        function obj=BasicBuildingBlocks(Length, delay, truthTable, errorTable, carryOut, carryIn, ...
                carryChainLength, carryChainStartingPosition, listOfStructuralBuildingBlocks)
            obj.Length = Length;
            obj.delay = delay;
            obj.truthTable = truthTable;
            obj.errorTable = errorTable;
            obj.carryOut = carryOut;
            obj.carryIn = carryIn;
            obj.carryChainLength = carryChainLength; 
            obj.carryChainStartingPosition = carryChainStartingPosition;
            obj.listOfStructuralBuildingBlocks = listOfStructuralBuildingBlocks;
            
            obj.gateLevelEquation = implementThisBlock(obj);
            [obj.Power, obj.Area] = estimateCircuitMetrics(obj);
            
            obj.UER = calculateUER(obj);
            obj.UMED = calculateUMED(obj);
        end
        %------------------------------------------------------------------
        % 2- Calculating the output of this block for a given input pair (in1, in2)
            % Not needed right now!!!
        function [cout, sum] = Operate(obj, in1, in2, cin)
            
            if nargin == 3
                cin = 0;
            end
            
            if isequal(obj.carryIn, 'No')
                cin = 0;
                mintermIndex = bi2de([in2, in1]) + 1;
            else
                mintermIndex = bi2de([in2, in1, cin]) + 1;
            end

            sum = obj.truthTable{1}(mintermIndex);            
            %--------------------------------------
            if isequal(obj.carryOut, 'No')
                cout = 0;
            else
                cout = obj.truthTable{2}(mintermIndex);
            end
            %--------------------------------------
            
        end
        %------------------------------------------------------------------
        % 3- Calculating Non-Uniform Error Rate (NUER) of this Building Block(BB)
        function nonUniformErrorRate = NUER(obj, DA, DB, cinProbability)
            
            if nargin == 3
                cinProbability = 0;
            end
            
            if isequal(obj.carryIn, 'No')
                cinProbability = 0;
                L = 0;
            else 
                L = 1;
            end
            
            sumOfCorrectnessProbabilities = 0;
            
            for i=1:numel(obj.errorTable)
                % Calculating the index of the input pair of current
                        % causing current entry of errorTable
                binaryIndexOfInputPair = de2bi(i-1, 2*numel(DA)+L );
                binaryIndexOfInputPair = binaryIndexOfInputPair(numel(binaryIndexOfInputPair):-1:1);

                % Calculating the occurance probability of the above input
                    % pair
                if isequal(obj.carryIn, 'No')
                    probabilityOfCurrentInputPair = calculateProbability(obj, binaryIndexOfInputPair, DA, DB);
                else
                    probabilityOfCurrentInputPair = calculateProbability(obj, binaryIndexOfInputPair, DA, DB, cinProbability);
                end
                
                Pi = probabilityOfCurrentInputPair;
                
                if(obj.errorTable(i) == 0)
                    sumOfCorrectnessProbabilities = sumOfCorrectnessProbabilities + Pi;
                end
            end
            nonUniformErrorRate = 1 - sumOfCorrectnessProbabilities;
        end 
        %------------------------------------------------------------------
        % 4- Calculating Non-Uniform Mean Error Distance  (NUMED) of this Building Block(BB)
        function nonUniformMeanErrorDistance = NUMED(obj, DA, DB, cinProbability)
            
            if nargin == 3
                cinProbability = 0;
            end
            
            if isequal(obj.carryIn, 'No')
                cinProbability = 0;
                L = 0;
            else 
                L = 1;
            end
            
            nonUniformMeanErrorDistance = 0;
            
            for i=1:numel(obj.errorTable)
                
                % Calculating the index of the input pair of current
                    % causing current entry of errorTable
                
                binaryIndexOfInputPair = de2bi(i-1, 2*numel(DA)+L );
                binaryIndexOfInputPair = binaryIndexOfInputPair(numel(binaryIndexOfInputPair):-1:1);
                
                % Calculating the occurance probability of the above input
                    % pair
                if isequal(obj.carryIn, 'No')
                    probabilityOfCurrentInputPair = calculateProbability(obj, binaryIndexOfInputPair, DA, DB);
                else
                    probabilityOfCurrentInputPair = calculateProbability(obj, binaryIndexOfInputPair, DA, DB, cinProbability);
                end
                
                % Calculating the result of Pi * EDi
                Pi = probabilityOfCurrentInputPair;
                EDi = abs(obj.errorTable(i));
                
                nonUniformMeanErrorDistance = nonUniformMeanErrorDistance + Pi * EDi; 
            end
        end 
        %------------------------------------------------------------------
        % 5- Implements this block
        function booleanExpression = implementThisBlock(obj)
            [booleanExpression, ~] = QuineMcCluskey(obj.truthTable);
        end
        %------------------------------------------------------------------
        % 6- Estimating Power and Area using NanGate FreePDK 45nm
        function [power, area] = estimateCircuitMetrics(obj)
            [~, simplifiedMatrixExpressionForm] = QuineMcCluskey(obj.truthTable);
            
            
            power = 0;
            area = 0;
            
            for i = 1 : size(simplifiedMatrixExpressionForm, 1)
                ComprehensiveExprOBJ = BasicComprehensiveExpression(simplifiedMatrixExpressionForm{i});
                ComprehensiveExprOBJ = ComprehensiveExprOBJ.OptimizeThisCircuit;
                
                [p, a] = ComprehensiveExprOBJ.CheckPowerAndArea;
                
                power = power  + p;
                area  = area   + a;
            end
            
            
            
            %[power, area] = estimatePowerAndArea(simplifiedMatrixExpressionForm);
        end
        %------------------------------------------------------------------
        
    end
    
    methods(Access=private)
        
        % Calculating Uniform Error Rate (UER) of this Building Block(BB)
        function uniformErrorRate = calculateUER(obj)
            counter = 0;
            for i=1:numel(obj.errorTable)
                if (obj.errorTable(i) == 0)
                    counter = counter + 1;
                end
            end
            uniformErrorRate = 1- (counter/numel(obj.errorTable));
        end
        %------------------------------------------------------------------
        % Calculating Uniform Mean Error Distance (UMED) of this Building Block(BB)
        function uniformMeanErrorDistance = calculateUMED(obj)
            sumOfAbsoluteErrorDistances = 0;
            for i=1:numel(obj.errorTable)
                sumOfAbsoluteErrorDistances = sumOfAbsoluteErrorDistances + abs(obj.errorTable(i));
            end
            uniformMeanErrorDistance = sumOfAbsoluteErrorDistances / numel(obj.errorTable);
        end
        %------------------------------------------------------------------
        function probability = calculateProbability(obj, binaryIndexOfInputPair, DA, DB, cinProbability)
            
            if nargin == 4
                cinProbability = 0;
            end
            
            probability = 1;
            
            if isequal(obj.carryIn, 'No')
                for j=1:2:numel(binaryIndexOfInputPair)-1
                    if (binaryIndexOfInputPair(j) == 1) % FIRST input
                        pCurrentPositionA = DA(ceil(j/2));
                    else
                        pCurrentPositionA = 1- DA(ceil(j/2));
                    end

                    if (binaryIndexOfInputPair(j+1) == 1) % SECOND input
                        pCurrentPositionB = DB((j+1)/2);
                    else
                        pCurrentPositionB = 1- DB((j+1)/2);
                    end
                    probability = probability * pCurrentPositionA * pCurrentPositionB;
                end
            else
                cinValue = binaryIndexOfInputPair(1);
                tempBinaryIndexOfInputPair  = binaryIndexOfInputPair(2:end);
                
                for j=1:2:numel(tempBinaryIndexOfInputPair)-1
                    if (tempBinaryIndexOfInputPair(j) == 1) % FIRST i\nput
                        pCurrentPositionA = DA(ceil(j/2));
                    else
                        pCurrentPositionA = 1- DA(ceil(j/2));
                    end

                    if (tempBinaryIndexOfInputPair(j+1) == 1) % SECOND input
                        pCurrentPositionB = DB((j+1)/2);
                    else
                        pCurrentPositionB = 1- DB((j+1)/2);
                    end
                    probability = probability * pCurrentPositionA * pCurrentPositionB;
                end
                if ( cinValue == 1 )
                    probability = probability * cinProbability;
                elseif ( cinValue == 0 )
                    probability = probability * (1-cinProbability);
                end
            end
            
        end
        %------------------------------------------------------------------
    end
    
end

