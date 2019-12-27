function [ currentNumOfPositive_CinBar_CoBar_Norm, ...
           currentNumOfPositive_CinBar_CoBar_Ab0, ...
           currentNumOfPositive_CinBar_CoBar_Ab1, ...
           currentNumOfPositive_CinBar_Co_Norm, ...
           currentNumOfPositive_CinBar_Co_Ab0, ...
           currentNumOfPositive_CinBar_Co_Ab1, ...
           currentNumOfPositive_Cin_CoBar_Norm, ...
           currentNumOfPositive_Cin_CoBar_Ab0, ...
           currentNumOfPositive_Cin_CoBar_Ab1, ...
           currentNumOfPositive_Cin_Co_Norm, ...
           currentNumOfPositive_Cin_Co_Ab0, ...
           currentNumOfPositive_Cin_Co_Ab1 ...
           ] = CurrentNumOfPositiveNodes( carryInProbability, ... 
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
    
    % 0) MODIFY THIS SECTION (DONE!)
    thisBlockNumOfP_CinBar_CoBar_Norm = 0;
    thisBlockNumOfP_CinBar_CoBar_Ab0 = 0;
    thisBlockNumOfP_CinBar_CoBar_Ab1 = 0;
    
    thisBlockNumOfP_CinBar_Co_Norm = 0;
    thisBlockNumOfP_CinBar_Co_Ab0 = 0;
    thisBlockNumOfP_CinBar_Co_Ab1 = 0;
    
    thisBlockNumOfP_Cin_CoBar_Norm = 0;
    thisBlockNumOfP_Cin_CoBar_Ab0 = 0;
    thisBlockNumOfP_Cin_CoBar_Ab1 = 0;
    
    thisBlockNumOfP_Cin_Co_Norm = 0;
    thisBlockNumOfP_Cin_Co_Ab0 = 0;
    thisBlockNumOfP_Cin_Co_Ab1 = 0;
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

                if ( errorTable(i) > 0 ) % 1) MODIFY THIS SECTION (DONE!)
                    if     (errorTable(i) == 1)
                        thisBlockNumOfP_CinBar_Co_Norm = thisBlockNumOfP_CinBar_Co_Norm + thisInputProbability;
                    elseif (errorTable(i) == 2) 
                        thisBlockNumOfP_CinBar_Co_Ab0 = thisBlockNumOfP_CinBar_Co_Ab0 + thisInputProbability;
                    elseif (errorTable(i) == 3)
                        thisBlockNumOfP_CinBar_Co_Ab1 = thisBlockNumOfP_CinBar_Co_Ab1 + thisInputProbability;
                    end
                end

            elseif ( carryOutTruthTable(i) == 0 ) % CinBar_CoBar

                if ( errorTable(i) > 0 ) % 2) MODIFY THIS SECTION (DONE!)
                    if     (errorTable(i) == 1)
                        thisBlockNumOfP_CinBar_CoBar_Norm = thisBlockNumOfP_CinBar_CoBar_Norm + thisInputProbability;
                    elseif (errorTable(i) == 2) 
                        thisBlockNumOfP_CinBar_CoBar_Ab0 = thisBlockNumOfP_CinBar_CoBar_Ab0 + thisInputProbability;
                    elseif (errorTable(i) == 3)
                        thisBlockNumOfP_CinBar_CoBar_Ab1 = thisBlockNumOfP_CinBar_CoBar_Ab1 + thisInputProbability;
                    end
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

                    if ( errorTable(i) > 0 ) % 3) MODIFY THIS SECTION (DONE!)
                        if     (errorTable(i) == 1)
                            thisBlockNumOfP_Cin_Co_Norm = thisBlockNumOfP_Cin_Co_Norm + thisInputProbability;
                        elseif (errorTable(i) == 2) 
                            thisBlockNumOfP_Cin_Co_Ab0 = thisBlockNumOfP_Cin_Co_Ab0 + thisInputProbability;
                        elseif (errorTable(i) == 3)
                            thisBlockNumOfP_Cin_Co_Ab1 = thisBlockNumOfP_Cin_Co_Ab1 + thisInputProbability;
                        end
                    end

                elseif ( carryOutTruthTable(i) == 0 ) %Cin_CoBar

                    if ( errorTable(i) > 0 ) % 4) MODIFY THIS SECTION (DONE!)
                        if     (errorTable(i) == 1)
                            thisBlockNumOfP_Cin_CoBar_Norm = thisBlockNumOfP_Cin_CoBar_Norm + thisInputProbability;
                        elseif (errorTable(i) == 2) 
                            thisBlockNumOfP_Cin_CoBar_Ab0 = thisBlockNumOfP_Cin_CoBar_Ab0 + thisInputProbability;
                        elseif (errorTable(i) == 3)
                            thisBlockNumOfP_Cin_CoBar_Ab1 = thisBlockNumOfP_Cin_CoBar_Ab1 + thisInputProbability;
                        end
                    end

                end
                
            elseif ( cinValue == 0 ) 
                
                thisInputProbability =  pCurrentPositionA * pCurrentPositionB;
                
                if ( carryOutTruthTable(i) == 1 ) %CinBar_Co

                    if ( errorTable(i) > 0 ) % 5) MODIFY THIS SECTION 
                        if     (errorTable(i) == 1)
                            thisBlockNumOfP_CinBar_Co_Norm = thisBlockNumOfP_CinBar_Co_Norm + thisInputProbability;
                        elseif (errorTable(i) == 2) 
                            thisBlockNumOfP_CinBar_Co_Ab0 = thisBlockNumOfP_CinBar_Co_Ab0 + thisInputProbability;
                        elseif (errorTable(i) == 3)
                            thisBlockNumOfP_CinBar_Co_Ab1 = thisBlockNumOfP_CinBar_Co_Ab1 + thisInputProbability;
                        end
                    end

                elseif ( carryOutTruthTable(i) == 0 ) %CinBar_CoBar

                    if ( errorTable(i) > 0 ) % 6) MODIFY THIS SECTION 
                        if     (errorTable(i) == 1)
                            thisBlockNumOfP_CinBar_CoBar_Norm = thisBlockNumOfP_CinBar_CoBar_Norm + thisInputProbability;
                        elseif (errorTable(i) == 2) 
                            thisBlockNumOfP_CinBar_CoBar_Ab0 = thisBlockNumOfP_CinBar_CoBar_Ab0 + thisInputProbability;
                        elseif (errorTable(i) == 3)
                            thisBlockNumOfP_CinBar_CoBar_Ab1 = thisBlockNumOfP_CinBar_CoBar_Ab1 + thisInputProbability;
                        end
                    end

                end
                
            end

        end
        
        
    end
    % 2) END --------------------------------------------------------------
    
    % 3)-------------------------------------------------------------------
        % 7) MODIFY THIS SECTION
        currentNumOfPositive_CinBar_CoBar_Norm = thisBlockNumOfP_CinBar_CoBar_Norm;
        currentNumOfPositive_CinBar_CoBar_Ab0 = thisBlockNumOfP_CinBar_CoBar_Ab0;
        currentNumOfPositive_CinBar_CoBar_Ab1 = thisBlockNumOfP_CinBar_CoBar_Ab1;
        
        currentNumOfPositive_CinBar_Co_Norm = thisBlockNumOfP_CinBar_Co_Norm;
        currentNumOfPositive_CinBar_Co_Ab0 = thisBlockNumOfP_CinBar_Co_Ab0;
        currentNumOfPositive_CinBar_Co_Ab1 = thisBlockNumOfP_CinBar_Co_Ab1;
        
        currentNumOfPositive_Cin_CoBar_Norm = thisBlockNumOfP_Cin_CoBar_Norm;
        currentNumOfPositive_Cin_CoBar_Ab0 = thisBlockNumOfP_Cin_CoBar_Ab0;
        currentNumOfPositive_Cin_CoBar_Ab1 = thisBlockNumOfP_Cin_CoBar_Ab1;
        
        currentNumOfPositive_Cin_Co_Norm = thisBlockNumOfP_Cin_Co_Norm;
        currentNumOfPositive_Cin_Co_Ab0 = thisBlockNumOfP_Cin_Co_Ab0;
        currentNumOfPositive_Cin_Co_Ab1 = thisBlockNumOfP_Cin_Co_Ab1;
    % 3) END --------------------------------------------------------------
    
end
