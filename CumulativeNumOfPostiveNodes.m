function [ cumulativeNumOfP_Norm_CoBar, cumulativeNumOfP_Norm_Co, ...
           cumulativeNumOfP_Ab0_Cobar, cumulativeNumOfP_Ab0_Co, ...
           cumulativeNumOfP_Ab1_Cobar, cumulativeNumOfP_Ab1_Co] = ... 
           CumulativeNumOfPostiveNodes ... 
         ( previousNumOfP_Norm_CoBar, previousNumOfP_Norm_Co, ...
           previousNumOfP_Ab0_CoBar, previousNumOfP_Ab0_Co, ...
           previousNumOfP_Ab1_CoBar, previousNumOfP_Ab1_Co, ...
           previousNumOfN_Norm_CoBar, previousNumOfN_Norm_Co, ...
           previousNumOfN_Ab0_CoBar, previousNumOfN_Ab0_Co, ...
           previousNumOfN_Ab1_CoBar, previousNumOfN_Ab1_Co, ...
           previousNumOfZ_Co, previousNumOfZ_CoBar, ... 
           carryInProbability, currentBlock, ...
           inputDistributionA, inputDistributionB)
                                
    % FUNCTION DESCRIPTION: 
    % calculating the cumulative number of Positive, Negative, and Zero nodes 
        % from the first to current level

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
    
    % 0) MODIFY THIS SECTION 
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
    
        %----------------------------------------------------------------------
        %----------------------------------------------------------------------
    
    thisBlockNumOfN_CinBar_CoBar_Norm = 0;
    thisBlockNumOfN_CinBar_CoBar_Ab0 = 0;
    thisBlockNumOfN_CinBar_CoBar_Ab1 = 0;
    
    thisBlockNumOfN_CinBar_Co_Norm = 0;
    thisBlockNumOfN_CinBar_Co_Ab0 = 0;
    thisBlockNumOfN_CinBar_Co_Ab1 = 0;
    
    thisBlockNumOfN_Cin_CoBar_Norm = 0;
    thisBlockNumOfN_Cin_CoBar_Ab0 = 0;
    thisBlockNumOfN_Cin_CoBar_Ab1 = 0;
    
    thisBlockNumOfN_Cin_Co_Norm = 0;
    thisBlockNumOfN_Cin_Co_Ab0 = 0;
    thisBlockNumOfN_Cin_Co_Ab1 = 0;
    
        %----------------------------------------------------------------------
        %----------------------------------------------------------------------

    thisBlockNumOfZ_CinBar_CoBar = 0;
    thisBlockNumOfZ_CinBar_Co = 0;
    thisBlockNumOfZ_Cin_CoBar = 0;
    thisBlockNumOfZ_Cin_Co = 0;
    % 1) END --------------------------------------------------------------
    
    % 2)-------------------------------------------------------------------
    % calculating the number of Positive, Negative, and Zero edges at 
        % the current block
    
    [ thisBlockNumOfP_CinBar_CoBar_Norm, ...
    thisBlockNumOfP_CinBar_CoBar_Ab0, ...
    thisBlockNumOfP_CinBar_CoBar_Ab1, ...
    thisBlockNumOfP_CinBar_Co_Norm, ...
    thisBlockNumOfP_CinBar_Co_Ab0, ...
    thisBlockNumOfP_CinBar_Co_Ab1, ...
    thisBlockNumOfP_Cin_CoBar_Norm, ...
    thisBlockNumOfP_Cin_CoBar_Ab0, ...
    thisBlockNumOfP_Cin_CoBar_Ab1, ...
    thisBlockNumOfP_Cin_Co_Norm, ...
    thisBlockNumOfP_Cin_Co_Ab0, ...
    thisBlockNumOfP_Cin_Co_Ab1] = CurrentNumOfPositiveNodes ...
    ( PCin, currentBlock, inputDistributionA, inputDistributionB);


    [ thisBlockNumOfN_CinBar_CoBar_Norm, ...
    thisBlockNumOfN_CinBar_CoBar_Ab0, ...
    thisBlockNumOfN_CinBar_CoBar_Ab1, ...
    thisBlockNumOfN_CinBar_Co_Norm, ...
    thisBlockNumOfN_CinBar_Co_Ab0, ...
    thisBlockNumOfN_CinBar_Co_Ab1, ...
    thisBlockNumOfN_Cin_CoBar_Norm, ...
    thisBlockNumOfN_Cin_CoBar_Ab0, ...
    thisBlockNumOfN_Cin_CoBar_Ab1, ...
    thisBlockNumOfN_Cin_Co_Norm, ...
    thisBlockNumOfN_Cin_Co_Ab0, ...
    thisBlockNumOfN_Cin_Co_Ab1 ] = CurrentNumOfNegativeNodes ... 
    ( PCin, currentBlock, inputDistributionA, inputDistributionB);

    [ thisBlockNumOfZ_CinBar_CoBar, ...
    thisBlockNumOfZ_CinBar_Co, ...
    thisBlockNumOfZ_Cin_CoBar, ...
    thisBlockNumOfZ_Cin_Co] = CurrentNumOfZeroNodes ... 
    ( PCin, currentBlock, inputDistributionA, inputDistributionB);
    % 2) END --------------------------------------------------------------

    % 3)-------------------------------------------------------------------
    if (previousNumOfP_Norm_CoBar == 0 && previousNumOfP_Norm_Co == 0  && ... 
        previousNumOfP_Ab0_CoBar == 0  && previousNumOfP_Ab0_Co == 0   && ...
        previousNumOfP_Ab1_CoBar == 0  && previousNumOfP_Ab1_Co == 0   && ...
        previousNumOfN_Norm_CoBar == 0 && previousNumOfN_Norm_Co == 0  && ...
        previousNumOfN_Ab0_CoBar == 0  && previousNumOfN_Ab0_Co  == 0  && ...
        previousNumOfN_Ab1_CoBar == 0  && previousNumOfN_Ab1_Co == 0   && ...
        previousNumOfZ_Co == 0         && previousNumOfZ_CoBar  == 0       )
    
        cumulativeNumOfP_Norm_CoBar = thisBlockNumOfP_CinBar_CoBar_Norm + ...
                                      thisBlockNumOfP_Cin_CoBar_Norm;
                                  
        cumulativeNumOfP_Norm_Co    = thisBlockNumOfP_CinBar_Co_Norm    + ...
                                      thisBlockNumOfP_Cin_Co_Norm;
                                  
        cumulativeNumOfP_Ab0_Cobar  = 0;
        
        cumulativeNumOfP_Ab0_Co     = thisBlockNumOfP_CinBar_Co_Ab0     + ...
                                      thisBlockNumOfP_Cin_Co_Ab0;
        
        cumulativeNumOfP_Ab1_Cobar  = 0;
        
        cumulativeNumOfP_Ab1_Co     = thisBlockNumOfP_CinBar_Co_Ab1     + ...
                                      thisBlockNumOfP_Cin_Co_Ab1;
        return;
    end
    % 3) END --------------------------------------------------------------
    
    % 4)-------------------------------------------------------------------
    
    
    % 1) 
    cumulativeNumOfP_Norm_CoBar = ...
    previousNumOfP_Norm_CoBar * thisBlockNumOfP_CinBar_CoBar_Norm + ...
    ...
    previousNumOfP_Ab1_Co     * thisBlockNumOfN_Cin_CoBar_Norm    + ...
    ...
    previousNumOfN_Norm_CoBar * thisBlockNumOfP_CinBar_CoBar_Norm + ...
    ...
    previousNumOfP_Norm_CoBar * thisBlockNumOfZ_CinBar_CoBar      + ...
    previousNumOfP_Norm_Co    * thisBlockNumOfZ_Cin_CoBar         + ...
    previousNumOfP_Ab0_Co     * thisBlockNumOfZ_Cin_CoBar         + ...
    previousNumOfP_Ab1_Co     * thisBlockNumOfZ_Cin_CoBar         + ...
    ...
    previousNumOfZ_CoBar      * thisBlockNumOfP_CinBar_CoBar_Norm;
    
    
    % 2)
    cumulativeNumOfP_Norm_Co = ...
    previousNumOfP_Norm_CoBar * thisBlockNumOfP_CinBar_Co_Norm + ...
    previousNumOfP_Norm_Co    * thisBlockNumOfP_Cin_Co_Norm    + ...
    ...
    previousNumOfP_Ab1_Co     * thisBlockNumOfN_Cin_Co_Norm    + ...
    ...
    previousNumOfN_Norm_CoBar * thisBlockNumOfP_CinBar_Co_Norm + ...
    previousNumOfN_Norm_Co    * thisBlockNumOfP_Cin_Co_Norm    + ...
    previousNumOfN_Norm_CoBar * thisBlockNumOfP_CinBar_Co_Ab0  + ...
    previousNumOfN_Norm_Co    * thisBlockNumOfP_Cin_Co_Ab0     + ...
    previousNumOfN_Ab0_CoBar  * thisBlockNumOfP_CinBar_Co_Ab0  + ...
    previousNumOfN_Ab1_CoBar  * thisBlockNumOfP_CinBar_Co_Ab0  + ...
    previousNumOfN_Ab1_CoBar  * thisBlockNumOfP_CinBar_Co_Ab1  + ...
    ...
    previousNumOfP_Norm_CoBar * thisBlockNumOfZ_CinBar_Co      + ...
    previousNumOfP_Norm_Co    * thisBlockNumOfZ_Cin_Co         + ...
    previousNumOfP_Ab0_Co     * thisBlockNumOfZ_Cin_Co         + ...
    previousNumOfP_Ab1_Co     * thisBlockNumOfZ_Cin_Co         + ...
    ...
    previousNumOfZ_CoBar      * thisBlockNumOfP_CinBar_Co_Norm + ...
    previousNumOfZ_Co         * thisBlockNumOfP_Cin_Co_Norm;
    
    
    % 3)
    cumulativeNumOfP_Ab0_Cobar = 0;
    
    
    % 4) 
    cumulativeNumOfP_Ab0_Co = ...
    previousNumOfP_Ab0_Co     * thisBlockNumOfP_Cin_Co_Norm    + ...
    ...
    previousNumOfN_Ab0_CoBar  * thisBlockNumOfP_CinBar_Co_Ab1  + ...
    ...
    previousNumOfZ_CoBar      * thisBlockNumOfP_CinBar_Co_Ab0  + ...
    previousNumOfZ_Co         * thisBlockNumOfP_Cin_Co_Ab0;
    

    % 5)
    cumulativeNumOfP_Ab1_Cobar = 0;
    
    
    %6)
    cumulativeNumOfP_Ab1_Co =...
    previousNumOfP_Norm_CoBar * thisBlockNumOfP_CinBar_Co_Ab0 + ...
    previousNumOfP_Norm_Co    * thisBlockNumOfP_Cin_Co_Ab0    + ...
    previousNumOfP_Norm_CoBar * thisBlockNumOfP_CinBar_Co_Ab1 + ...
    previousNumOfP_Ab0_Co     * thisBlockNumOfP_Cin_Co_Ab0    + ...
    previousNumOfP_Ab1_Co     * thisBlockNumOfP_Cin_Co_Norm   + ...
    previousNumOfP_Ab1_Co     * thisBlockNumOfP_Cin_Co_Ab0    + ...
    ... 
    previousNumOfN_Norm_CoBar * thisBlockNumOfP_CinBar_Co_Ab1 + ...
    ...
    previousNumOfZ_CoBar      * thisBlockNumOfP_CinBar_Co_Ab1;
    
    % 4) END --------------------------------------------------------------
    
    %----------------------------------------------------------------------
end
