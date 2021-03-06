function [ OutputSet ] = FormLargeBuildingBlocksWithCout(   requiredNumOfAdders, ...
                                                    numOfIterations, ...
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
    
    % Step 1) Variable initialization -------------------------------------
    OutputSetSize = requiredNumOfAdders;
    Iterate = numOfIterations;
    N = adderWidth;
    K = servedTiming;
    DA = InputDistributionA;
    DB = InputDistributionB;
    
    MaxPower = PowerConstraint;
    MaxArea = AreaConstraint;
    MaxMED = MEDConstraint; 
    
    OutputSet = cell(1, OutputSetSize);
    % Step 1) END ---------------------------------------------------------
    
    % Step 2) -------------------------------------------------------------
    j = 1;
    for i=1:Iterate
        [IsValid, FullSpec] = FormALargeBuildingBlockWithCout(N, K, MaxPower, MaxArea, MaxMED, ...
                              DA, DB, standardLogicLibrary, ...
                              standardLogicLibrary_CinBar_CoBar, ...
                              standardLogicLibrary_CinBar_Co, ...
                              standardLogicLibrary_Cin_CoBar, ...
                              standardLogicLibrary_Cin_Co);
        if isequal(IsValid, true)
            OutputSet{1, j} = FullSpec;
            j = j+1;
        else
            continue;
        end
        
        if (j > OutputSetSize)
            return;
        end
        
    end
    % Step 2) END ---------------------------------------------------------
end

