function [cumulativeSADMinus_Norm_CoBar, ...
          cumulativeSADMinus_Norm_Co, ...
          cumulativeSADMinus_Ab0_CoBar, ...
          cumulativeSADMinus_Ab0_Co, ...
          cumulativeSADMinus_Ab1_CoBar, ...
          cumulativeSADMinus_Ab1_Co ...
          ] = ...
          CumulativeSADMinus ...
          ( previousSADPlus_Norm_CoBar, previousSADPlus_Norm_Co, ...
            previousSADPlus_Ab0_CoBar, previousSADPlus_Ab0_Co, ...
            previousSADPlus_Ab1_CoBar, previousSADPlus_Ab1_Co, ...
            ...
            previousSADMinus_Norm_CoBar, previousSADMinus_Norm_Co, ...
            previousSADMinus_Ab0_CoBar, previousSADMinus_Ab0_Co, ...
            previousSADMinus_Ab1_CoBar, previousSADMinus_Ab1_Co, ...
            ...
            previousNumOfP_Norm_CoBar, previousNumOfP_Norm_Co, ...
            previousNumOfP_Ab0_CoBar, previousNumOfP_Ab0_Co, ...
            previousNumOfP_Ab1_CoBar, previousNumOfP_Ab1_Co, ...
            ...
            previousNumOfN_Norm_CoBar, previousNumOfN_Norm_Co, ...
            previousNumOfN_Ab0_CoBar, previousNumOfN_Ab0_Co, ...
            previousNumOfN_Ab1_CoBar, previousNumOfN_Ab1_Co, ...
            ...
            previousNumOfZ_CoBar, previousNumOfZ_Co, ...
            ...
            carryInProbability, currentBlock, ...
            inputDistributionA, inputDistributionB, ...
            bitPosition)
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
    % 1) END---------------------------------------------------------------
    
    % 2) Calculating the current variables --------------------------------
    
    % 2.1) Current Sums
    [ CurrentSumPlus_CinBar_CoBar_Norm, ...
    CurrentSumPlus_CinBar_CoBar_Ab0, ...
    CurrentSumPlus_CinBar_CoBar_Ab1, ...
    CurrentSumPlus_CinBar_Co_Norm, ...
    CurrentSumPlus_CinBar_Co_Ab0, ...
    CurrentSumPlus_CinBar_Co_Ab1, ...
    CurrentSumPlus_Cin_CoBar_Norm, ...
    CurrentSumPlus_Cin_CoBar_Ab0, ...
    CurrentSumPlus_Cin_CoBar_Ab1, ...
    CurrentSumPlus_Cin_Co_Norm, ...
    CurrentSumPlus_Cin_Co_Ab0, ...
    CurrentSumPlus_Cin_Co_Ab1 ...
    ] = CurrentSumOfPositiveErrorValues ...
    ( PCin, currentBlock, inputDistributionA, inputDistributionB);
    

    [ CurrentSumMinus_CinBar_CoBar_Norm, ...
    CurrentSumMinus_CinBar_CoBar_Ab0, ...
    CurrentSumMinus_CinBar_CoBar_Ab1, ...
    CurrentSumMinus_CinBar_Co_Norm, ...
    CurrentSumMinus_CinBar_Co_Ab0, ...
    CurrentSumMinus_CinBar_Co_Ab1, ...
    CurrentSumMinus_Cin_CoBar_Norm, ...
    CurrentSumMinus_Cin_CoBar_Ab0, ...
    CurrentSumMinus_Cin_CoBar_Ab1, ...
    CurrentSumMinus_Cin_Co_Norm, ...
    CurrentSumMinus_Cin_Co_Ab0, ...
    CurrentSumMinus_Cin_Co_Ab1 ...
    ] = CurrentSumOfNegativeErrorValues ...
    ( carryInProbability, currentBlock, inputDistributionA, inputDistributionB);
    
    % 2.2) Current Nums
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
    
    if ( bitPosition == 0 )
        cumulativeSADMinus_Norm_CoBar = CurrentSumMinus_CinBar_CoBar_Norm + ...
                                        CurrentSumMinus_Cin_CoBar_Norm;
        
        cumulativeSADMinus_Norm_Co    = CurrentSumMinus_CinBar_Co_Norm    + ...
                                        CurrentSumMinus_Cin_Co_Norm;
        
        cumulativeSADMinus_Ab0_CoBar  = CurrentSumMinus_CinBar_CoBar_Ab0  + ...
                                        CurrentSumMinus_Cin_CoBar_Ab0;
        
        cumulativeSADMinus_Ab0_Co     = 0;
        
        cumulativeSADMinus_Ab1_CoBar  = CurrentSumMinus_CinBar_CoBar_Ab1  + ...
                                        CurrentSumMinus_Cin_CoBar_Ab1;
        
        cumulativeSADMinus_Ab1_Co     = 0;
        
        return;
    end

    % 3) ------------------------------------------------------------------
    
    % 1)
    cumulativeSADMinus_Norm_CoBar = ...
    previousSADMinus_Norm_CoBar   * thisBlockNumOfN_CinBar_CoBar_Norm + ...
    previousSADMinus_Norm_Co      * thisBlockNumOfN_Cin_CoBar_Norm    + ...
    previousSADMinus_Norm_CoBar   * thisBlockNumOfZ_CinBar_CoBar      + ...
    previousSADMinus_Norm_Co      * thisBlockNumOfZ_Cin_CoBar         + ...
    previousSADMinus_Ab0_CoBar    * thisBlockNumOfZ_CinBar_CoBar      + ...
    previousSADMinus_Ab1_CoBar    * thisBlockNumOfZ_CinBar_CoBar      + ...
    ...
    previousNumOfN_Norm_CoBar     * CurrentSumMinus_CinBar_CoBar_Norm * (2^bitPosition) + ...
    previousNumOfN_Norm_Co        * CurrentSumMinus_Cin_CoBar_Norm    * (2^bitPosition) + ...
    previousNumOfZ_CoBar          * CurrentSumMinus_CinBar_CoBar_Norm * (2^bitPosition) + ...
    previousNumOfZ_Co             * CurrentSumMinus_Cin_CoBar_Norm    * (2^bitPosition) + ...
    ...
    previousSADMinus_Ab1_CoBar    * thisBlockNumOfP_CinBar_CoBar_Norm - ...
    previousNumOfN_Ab1_CoBar      * CurrentSumPlus_CinBar_CoBar_Norm  * (2^bitPosition) + ...
    ...
    abs(...
    previousSADPlus_Norm_CoBar    * thisBlockNumOfN_CinBar_CoBar_Norm - ...
    previousNumOfP_Norm_CoBar     * CurrentSumMinus_CinBar_CoBar_Norm * (2^bitPosition)) + ...
    abs(...
    previousSADPlus_Norm_Co       * thisBlockNumOfN_Cin_CoBar_Norm    - ...
    previousNumOfP_Norm_Co        * CurrentSumMinus_Cin_CoBar_Norm    * (2^bitPosition)) + ...
    abs(...
    previousSADPlus_Norm_CoBar    * thisBlockNumOfN_CinBar_CoBar_Ab0  - ...
    previousNumOfP_Norm_CoBar     * CurrentSumMinus_CinBar_CoBar_Ab0  * (2^bitPosition)) + ...
    abs(...
    previousSADPlus_Norm_Co       * thisBlockNumOfN_Cin_CoBar_Ab0     - ...
    previousNumOfP_Norm_Co        * CurrentSumMinus_Cin_CoBar_Ab0     * (2^bitPosition)) + ...
    abs(...
    previousSADPlus_Ab0_Co        * thisBlockNumOfN_Cin_CoBar_Ab0     - ...
    previousNumOfP_Ab0_Co         * CurrentSumMinus_Cin_CoBar_Ab0     * (2^bitPosition)) + ...
    abs(...
    previousSADPlus_Ab1_Co        * thisBlockNumOfN_Cin_CoBar_Ab0     - ...
    previousNumOfP_Ab1_Co         * CurrentSumMinus_Cin_CoBar_Ab0     * (2^bitPosition)) + ...
    abs(...
    previousSADPlus_Ab1_Co        * thisBlockNumOfN_Cin_CoBar_Ab1     - ...
    previousNumOfP_Ab1_Co         * CurrentSumMinus_Cin_CoBar_Ab1     * (2^bitPosition));
    
    

    % 2)
    cumulativeSADMinus_Norm_Co = ...
    previousSADMinus_Norm_Co      * thisBlockNumOfN_Cin_Co_Norm       + ... 
    previousSADMinus_Norm_CoBar   * thisBlockNumOfZ_CinBar_Co         + ...
    previousSADMinus_Norm_Co      * thisBlockNumOfZ_Cin_Co            + ...
    previousSADMinus_Ab0_CoBar    * thisBlockNumOfZ_CinBar_Co         + ...
    previousSADMinus_Ab1_CoBar    * thisBlockNumOfZ_CinBar_Co         + ...
    ...
    previousNumOfN_Norm_Co        * CurrentSumMinus_Cin_Co_Norm       * (2^bitPosition) + ...
    previousNumOfZ_Co             * CurrentSumMinus_Cin_Co_Norm       * (2^bitPosition) + ...
    ...
    previousSADMinus_Ab1_CoBar    * thisBlockNumOfP_CinBar_Co_Norm    - ...
    previousNumOfN_Ab1_CoBar      * CurrentSumPlus_CinBar_Co_Norm     * (2^bitPosition) + ...
    ...
    abs(...
    previousSADPlus_Norm_Co       * thisBlockNumOfN_Cin_Co_Norm       - ...
    previousNumOfP_Norm_Co        * CurrentSumMinus_Cin_Co_Norm       * (2^bitPosition));
    

    
    % 3) 
    cumulativeSADMinus_Ab0_CoBar = ...
    previousSADMinus_Ab0_CoBar    * thisBlockNumOfN_CinBar_CoBar_Norm + ...
    ...
    previousNumOfN_Ab0_CoBar      * CurrentSumMinus_CinBar_CoBar_Norm * (2^bitPosition) + ...
    previousNumOfZ_CoBar          * CurrentSumMinus_CinBar_CoBar_Ab0  * (2^bitPosition) + ...
    previousNumOfZ_Co             * CurrentSumMinus_Cin_CoBar_Ab0     * (2^bitPosition) + ...
    ...
    abs(...
    previousSADPlus_Ab0_Co        * thisBlockNumOfN_Cin_CoBar_Ab1     - ...
    previousNumOfP_Ab0_Co         * CurrentSumMinus_Cin_CoBar_Ab1     * (2^bitPosition));
    

    
    % 4)
    cumulativeSADMinus_Ab0_Co = 0;
    
    
    % 5)
    cumulativeSADMinus_Ab1_CoBar = ...
    previousSADMinus_Norm_CoBar   * thisBlockNumOfN_CinBar_CoBar_Ab0  + ...
    previousSADMinus_Norm_Co      * thisBlockNumOfN_Cin_CoBar_Ab0     + ...
    previousSADMinus_Norm_Co      * thisBlockNumOfN_Cin_CoBar_Ab1     + ...
    previousSADMinus_Ab0_CoBar    * thisBlockNumOfN_CinBar_CoBar_Ab0  + ...
    previousSADMinus_Ab1_CoBar    * thisBlockNumOfN_CinBar_CoBar_Norm + ...
    previousSADMinus_Ab1_CoBar    * thisBlockNumOfN_CinBar_CoBar_Ab0  + ...
    ...
    previousNumOfN_Norm_CoBar     * CurrentSumMinus_CinBar_CoBar_Ab0  * (2^bitPosition) + ... 
    previousNumOfN_Norm_Co        * CurrentSumMinus_Cin_CoBar_Ab0     * (2^bitPosition) + ...
    previousNumOfN_Norm_Co        * CurrentSumMinus_Cin_CoBar_Ab1     * (2^bitPosition) + ...
    previousNumOfN_Ab0_CoBar      * CurrentSumMinus_CinBar_CoBar_Ab0  * (2^bitPosition) + ...
    previousNumOfN_Ab1_CoBar      * CurrentSumMinus_CinBar_CoBar_Norm * (2^bitPosition) + ...
    previousNumOfN_Ab1_CoBar      * CurrentSumMinus_CinBar_CoBar_Ab0  * (2^bitPosition) + ...
    previousNumOfZ_Co             * CurrentSumMinus_Cin_CoBar_Ab1     * (2^bitPosition) + ...
    ...
    abs(...
    previousSADPlus_Norm_Co       * thisBlockNumOfN_Cin_CoBar_Ab1     - ...
    previousNumOfP_Norm_Co        * CurrentSumMinus_Cin_CoBar_Ab1     * (2^bitPosition));
    
    
    
    % 6) 
    cumulativeSADMinus_Ab1_Co = 0;
    
    % 3) END --------------------------------------------------------------
    %---------------------------------THE END -----------------------------
    
end

