function [ currentNumOfZero_CinBar_CoBar, ...
           currentNumOfZero_CinBar_Co, ...
           currentNumOfZero_Cin_CoBar, ...
           currentNumOfZero_Cin_Co] = CurrentNumOfZeroNodes( carryInProbability, ... 
                                                             currentBlock, ...
                                                             inputDistributionA, ... 
                                                             inputDistributionB)
    % FUNCTION DESCRIPTION:
    % 1) Variable initialization----------------------------------------------
    DA = inputDistributionA;
    DB = inputDistributionB;
    errorTable = currentBlock.errorTable;
    
    if ( isequal(currentBlock.carryIn, 'No') )
        carryInProbability = 0;
    end
    PCin = carryInProbability;
                                      
    if (isequal(currentBlock.carryOut, 'No'))
        carryOutTruthTable = zeros(1, numel(errorTable));
    else
        carryOutTruthTable = currentBlock.truthTable{2};
    end
    
    thisBlockNumOfZ_CinBar_CoBar = 0;
    thisBlockNumOfZ_CinBar_Co = 0;
    thisBlockNumOfZ_Cin_CoBar = 0;
    thisBlockNumOfZ_Cin_Co = 0;
    % 1) END --------------------------------------------------------------
    
    % 2)-------------------------------------------------------------------
    % calculating the number of Positive, Negative, and Zero edges at 
        % the current block
    if ( isequal(currentBlock.carryIn, 'No') )
        %------------------------------------------------------------------
        for i=1:numel(errorTable) % or i=1:4
            
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

            thisInputProbability = pCurrentPositionA * pCurrentPositionB;

            if ( carryOutTruthTable(i) == 1 ) % CinBar_Co

                if ( errorTable(i) == 0 )
                    thisBlockNumOfZ_CinBar_Co = thisBlockNumOfZ_CinBar_Co + thisInputProbability;
                end

            elseif ( carryOutTruthTable(i) == 0 ) % CinBar_CoBar

                if ( errorTable(i) == 0 )
                    thisBlockNumOfZ_CinBar_CoBar = thisBlockNumOfZ_CinBar_CoBar + thisInputProbability;
                end

            end
            
        end
        %------------------------------------------------------------------
    else     % carryIn == 'Yes'
        
        for i=1: numel(errorTable) % or i=1:8
                
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

            if ( cinValue == 1 )
                thisInputProbability =  pCurrentPositionA * pCurrentPositionB;
                
                if ( carryOutTruthTable(i) == 1 ) % Cin_Co

                    if ( errorTable(i) == 0 )
                        thisBlockNumOfZ_Cin_Co = thisBlockNumOfZ_Cin_Co + thisInputProbability;
                    end

                elseif ( carryOutTruthTable(i) == 0 ) % Cin_CoBar

                    if ( errorTable(i) == 0 )
                        thisBlockNumOfZ_Cin_CoBar = thisBlockNumOfZ_Cin_CoBar + thisInputProbability;
                    end

                end
                
            elseif ( cinValue == 0 )  
                
                thisInputProbability =  pCurrentPositionA * pCurrentPositionB;
                
                if ( carryOutTruthTable(i) == 1 ) % CinBar_Co

                    if ( errorTable(i) == 0 )
                        thisBlockNumOfZ_CinBar_Co = thisBlockNumOfZ_CinBar_Co + thisInputProbability;
                    end

                elseif ( carryOutTruthTable(i) == 0 ) % CinBar_CoBar

                    if ( errorTable(i) == 0 )
                        thisBlockNumOfZ_CinBar_CoBar = thisBlockNumOfZ_CinBar_CoBar + thisInputProbability;
                    end

                end
                
            end

        end
        
        
    end
    % 2) END --------------------------------------------------------------
    
    % 3)-------------------------------------------------------------------
        currentNumOfZero_CinBar_CoBar = thisBlockNumOfZ_CinBar_CoBar;
        currentNumOfZero_CinBar_Co = thisBlockNumOfZ_CinBar_Co;
        currentNumOfZero_Cin_CoBar = thisBlockNumOfZ_Cin_CoBar;
        currentNumOfZero_Cin_Co = thisBlockNumOfZ_Cin_Co;
    % 3) END --------------------------------------------------------------
end

