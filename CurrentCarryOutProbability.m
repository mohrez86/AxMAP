function [carryOutProbability] = CurrentCarryOutProbability( carryInProbability, ...
                                                              currentBlock, ...
                                                              inputDistributionA, ...
                                                              inputDistributionB)
    
    %FUNCTION DESCRIPTION:
    % This function calculates the carry out probability of the current block
        % or the carry in probability of the next block
    
    Pcin = carryInProbability;
    DA = inputDistributionA;
    DB = inputDistributionB;
    truthTable = currentBlock.truthTable;
    
    
    % check if it generates carry out or not. If not, the carry out probabillity is 0
    if ( isequal(currentBlock.carryOut, 'No') )
        carryOutProbability = 0;
        return;
    else
        carryOutTruthTable = truthTable{2};
    end
    %----------------------------------------------------------------------
    
    % calculating the probability of the current carry out given the
        % probability of current carry in (Pcin) and probability of inputs
    PCoCin = 0;
    PCoCinBar = 0;
    
    if ( isequal(currentBlock.carryIn, 'No') )
        %------------------------------------------------------------------
        for i=1:numel(carryOutTruthTable) % or i=1:4
            if (carryOutTruthTable(i) == 1)
                
                binaryIndexOfInputPair = de2bi(i-1, 2*numel(DA));
                binaryIndexOfInputPair = binaryIndexOfInputPair(numel(binaryIndexOfInputPair):-1:1);
                
                if (binaryIndexOfInputPair(1) == 1) % FIRST input
                    pCurrentPositionA = DA(1);
                else
                    pCurrentPositionA = 1- DA(1);
                end

                if (binaryIndexOfInputPair(2) == 1) % SECOND input
                    pCurrentPositionB = DB(1);
                else
                    pCurrentPositionB = 1- DB(1);
                end

                PCoCinBar = PCoCinBar + pCurrentPositionA * pCurrentPositionB;
            end
        end
        %------------------------------------------------------------------
    else % currentBlock.carryIn = 'Yes'
        
        for i=1: numel(carryOutTruthTable) % or i=1:8
            if (carryOutTruthTable(i) == 1)
                
                binaryIndexOfInputPair = de2bi(i-1, 2*numel(DA)+1);
                binaryIndexOfInputPair = binaryIndexOfInputPair(numel(binaryIndexOfInputPair):-1:1);
                
                cinValue = binaryIndexOfInputPair(1);
                tempBinaryIndexOfInputPair  = binaryIndexOfInputPair(2:end);
                
                if (tempBinaryIndexOfInputPair(1) == 1) % FIRST input
                    pCurrentPositionA = DA(1);
                else
                    pCurrentPositionA = 1- DA(1);
                end

                if (tempBinaryIndexOfInputPair(2) == 1) % SECOND input
                    pCurrentPositionB = DB(1);
                else
                    pCurrentPositionB = 1- DB(1);
                end
                
                inputPairProbability = pCurrentPositionA * pCurrentPositionB;
                    
                if ( cinValue == 1 )
                    PCoCin = PCoCin + inputPairProbability;
                elseif ( cinValue == 0 )
                    PCoCinBar = PCoCinBar + inputPairProbability;
                end
                
            end
        end
        
    end
    %----------------------------------------------------------------------
    
    % calculating the probability of carry out
    
    carryOutProbability = Pcin * (PCoCin) + (1-Pcin) * (PCoCinBar);
    %----------------------------------------------------------------------
end

