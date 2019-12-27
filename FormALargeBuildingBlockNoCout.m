function [ Flag_Validity, FullSpecification] = FormALargeBuildingBlockNoCout( ...
                                                adderWidth, ...
                                                servedTiming, ...
                                                PowerConstraint, ...
                                                AreaConstraint, ...
                                                MEDConstraint, ...
                                                InputDistributionA, ...
                                                InputDistributionB, ...
                                                standardLogicLibrary, ...
                                                standardLogicLibrary_CinBar_CoBar, ...
                                                standardLogicLibrary_CinBar_Co, ...
                                                standardLogicLibrary_Cin_CoBar, ...
                                                standardLogicLibrary_Cin_Co)

    % FUNCTION DESCRIPTION: 
    % Randomly explore the design space and form an n-bit adder
    
    % Step 1) Variable initialization -------------------------------------
    N = adderWidth;
    K = servedTiming;
    DA = InputDistributionA;
    DB = InputDistributionB;
    
    MaxPower = PowerConstraint;
    MaxArea = AreaConstraint;
    MaxMED = MEDConstraint; 
    
    FullSpecification = cell(1, 6);
    
    % Step 1) END ---------------------------------------------------------
    
    % Step 2) Generating Random N-entry Sequences -------------------------
    
    % --------------------------------------------------------------------
    % --------------------------------------------------------------------
    % --------------------------------------------------------------------
    % ---------------------------------------------------------------------
    % 2.1) Generate the first adder, randomly -----------------------------
    %[ targetSequence ] = RandomSequenceGenerator( N, standardLogicLibrary );
    % 2.1) END ------------------------------------------------------------

    % 2.2) If a block is accurate then the sequence is invalid-------------
    
    % Flag_ApproximationValidity = CheckApproximationValidity(targetSequence);
    
    % 2.2) END ------------------------------------------------------------
    
    % 2.3) Create Adder Object based on the target Sequence ---------------
    
    %if isequal(Flag_ApproximationValidity, true)
    %    targetAdderObject = CreateTargetAdderObject(targetSequence, standardLogicLibrary);
    %else
    %    Flag_Validity =false;
    %    return;
    %end
    
    % 2.3) END ------------------------------------------------------------
    % --------------------------------------------------------------------
    % --------------------------------------------------------------------
    % --------------------------------------------------------------------
    targetAdderObject = CreateRandomAdderObjectNoCout(N, K, ...
                        standardLogicLibrary, ...
                        standardLogicLibrary_CinBar_CoBar, ...
                        standardLogicLibrary_CinBar_Co, ...
                        standardLogicLibrary_Cin_CoBar, ...
                        standardLogicLibrary_Cin_Co);
    
    % 2.4) Check for CarryChain Validity ----------------------------------
    %Flag_CarryChainValidity = CheckCarryChainValidity(targetAdderObject);
    %Flag_CarryChainValidity = 1;
    % 2.4) END ------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % --------------------------------------------------------------------
    % --------------------------------------------------------------------
    % 2.5) Check for Timing Validity --------------------------------------
    
%     if isequal(Flag_CarryChainValidity, true)
%         [Flag_TimingValidity, ThisTiming] =  CheckTimingValidity(targetAdderObject, K);
%     else
%         Flag_Validity =false;
%         return;
%     end
    
    % 2.5) END ------------------------------------------------------------
    % --------------------------------------------------------------------
    % --------------------------------------------------------------------
    % --------------------------------------------------------------------
    
    
    % 2.6) Check for Power Validity ---------------------------------------
    [Flag_PowerValidity, ThisPower]= CheckPowerValidity(targetAdderObject, MaxPower);
    % 2.6) END ------------------------------------------------------------
    
    % 2.7) Check for Area Validity ----------------------------------------
    if isequal(Flag_PowerValidity, true)
        [Flag_AreaValidity, ThisArea] = CheckAreaValidity(targetAdderObject, MaxArea);
    else
        Flag_Validity =false;
        return;
    end
    % 2.7) END ------------------------------------------------------------
    
    % 2.8) Check for MED Validity -----------------------------------------
    if isequal(Flag_AreaValidity, true)
        [Flag_MEDValidity, ThisMED ]= CheckMEDValidity(targetAdderObject, MaxMED, DA, DB);
    else
        Flag_Validity =false;
        return;
    end
    % 2.8) END ------------------------------------------------------------
    
    % 2.9) if all flags are true, output the object with full specification
    if isequal(Flag_MEDValidity, true)
        FullSpecification{1} = targetAdderObject;     % The Adder Block
        FullSpecification{2} = ThisMED;               % MED
        FullSpecification{3} = ThisPower;             % POWER
        FullSpecification{4} = ThisArea;              % AREA
        FullSpecification{5} = K;                     % TIMING
        FullSpecification{6} = [DA; DB];              % Input Distributions
        Flag_Validity = true;
    else
        Flag_Validity =false;
        return;
    end
    % 2.9) END ------------------------------------------------------------
    
    % Step 2) END ---------------------------------------------------------
end

