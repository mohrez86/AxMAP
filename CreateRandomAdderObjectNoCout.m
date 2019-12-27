function [ targetAdderObjectNoCout ] = CreateRandomAdderObjectNoCout( adderWidth, ...
                                 servedTiming, ...
                                 standardLogicLibrary, ...
                                 standardLogicLibrary_CinBar_CoBar, ...
                                 standardLogicLibrary_CinBar_Co, ...
                                 standardLogicLibrary_Cin_CoBar, ...
                                 standardLogicLibrary_Cin_Co)

    % FUNCTION DESCRIPTION: 
    % Check Approximation Validity
    % Check Carry Chain Validity
    % Check Timing Validity
    
    
    
    % Step 1) Variable Initialization -------------------------------------    
    N = adderWidth;
    K = servedTiming;
    targetAdderObjectNoCout = cell(1, N);
    
    PreviousCarryOut = 0;
    
    CarryChainLength = 1;
    tempCarryChainLength = 1;
    
    CinBar_CoBar = size(standardLogicLibrary_CinBar_CoBar, 1);
    CinBar_Co = size(standardLogicLibrary_CinBar_Co, 1);
    Cin_CoBar = size(standardLogicLibrary_Cin_CoBar, 1);
    Cin_Co = size(standardLogicLibrary_Cin_Co, 1);
    
    % Step 1) END ---------------------------------------------------------
    
    % Step 2) N-bit Adder Object Generator --------------------------------
    
    % 2.1) First Stage ----------------------------------------------------
    % Phase 1 : Selection
    if (tempCarryChainLength == K) % Then this stage cannot generate Cout
        
        FirstStage = randi( (CinBar_CoBar), 1, 1 );
        targetAdderObjectNoCout{1} = standardLogicLibrary_CinBar_CoBar{FirstStage};
        tempCarryChainLength = 1;
        PreviousCarryOut = 0;
        
    else % CarryChainLength < K. So it can generate Cout or not
        
        FirstStage = randi( (CinBar_Co + CinBar_CoBar), 1, 1 );
        if (FirstStage > CinBar_Co) % then choose from CinBar_CoBar
            FirstStage = FirstStage - CinBar_Co;
            targetAdderObjectNoCout{1} = standardLogicLibrary_CinBar_CoBar{FirstStage};
            tempCarryChainLength =  1;
            PreviousCarryOut = 0;
        else % then choose from CinBar_Co
            targetAdderObjectNoCout{1} = standardLogicLibrary_CinBar_Co{FirstStage};
            tempCarryChainLength = tempCarryChainLength + 1;
            PreviousCarryOut = 1;
        end
        
    end
    
    % Phase 2 : Carry Chain Update
    if (tempCarryChainLength > CarryChainLength)
        CarryChainLength = tempCarryChainLength;
    end
    % 2.1) END-------------------------------------------------------------
    
    % 2.2) Second Stage to (N)th Stage ----------------------------------
    for i = 2 : N
        
        if (i == N) % Should Not Have COUT!!!
            if (PreviousCarryOut == 0) % then choose from CinBar_CoBar
                IthStage = randi(CinBar_CoBar, 1, 1 );
                targetAdderObjectNoCout{i} = standardLogicLibrary_CinBar_CoBar{IthStage};
            else % then choose from Cin_CoBar
                IthStage = randi(Cin_CoBar, 1, 1 );
                targetAdderObjectNoCout{i} = standardLogicLibrary_Cin_CoBar{IthStage};
            end
            if (tempCarryChainLength > CarryChainLength)
                    CarryChainLength = tempCarryChainLength;
            end
        else
            if (tempCarryChainLength == K) % Then this stage cannot generate Cout
                % Selection
                if (PreviousCarryOut == 0) % Then choose from CinBar_CoBar
                    IthStage = randi(CinBar_CoBar, 1, 1 );
                    targetAdderObjectNoCout{i} = standardLogicLibrary_CinBar_CoBar{IthStage};
                    tempCarryChainLength =  1;
                    PreviousCarryOut = 0;
                else % Then Choose from Cin_CoBar
                    IthStage = randi(Cin_CoBar, 1, 1 );
                    targetAdderObjectNoCout{i} = standardLogicLibrary_Cin_CoBar{IthStage};
                    tempCarryChainLength = 1;
                    PreviousCarryOut = 0;
                end
                % Carry Chain Update
                if (tempCarryChainLength > CarryChainLength)
                    CarryChainLength = tempCarryChainLength;
                end

            else % CarryChainLength < K. So it can generate Cout or not
                % Selection
                if (PreviousCarryOut == 0) % Then choose from CinBar

                    IthStage = randi((CinBar_Co + CinBar_CoBar), 1, 1);
                    if (IthStage > CinBar_Co) % then choose from CinBar_CoBar
                        IthStage = IthStage - CinBar_Co;
                        targetAdderObjectNoCout{i} = standardLogicLibrary_CinBar_CoBar{IthStage};
                        tempCarryChainLength =  1;
                        PreviousCarryOut = 0;
                    else % then choose from CinBar_Co
                        targetAdderObjectNoCout{i} = standardLogicLibrary_CinBar_Co{IthStage};
                        tempCarryChainLength = tempCarryChainLength + 1;
                        PreviousCarryOut = 1;
                    end

                else % Then choose from Cin
                    IthStage = randi((Cin_Co + Cin_CoBar), 1, 1);
                    if (IthStage > Cin_Co) % then choose from Cin_CoBar
                        IthStage = IthStage - Cin_Co;
                        targetAdderObjectNoCout{i} = standardLogicLibrary_Cin_CoBar{IthStage};
                        tempCarryChainLength =  1;
                        PreviousCarryOut = 0;
                    else % then choose from Cin_Co
                        targetAdderObjectNoCout{i} = standardLogicLibrary_Cin_Co{IthStage};
                        tempCarryChainLength = tempCarryChainLength + 1;
                        PreviousCarryOut = 1;
                    end
                end

                % Carry Chain Update
                if (tempCarryChainLength > CarryChainLength)
                    CarryChainLength = tempCarryChainLength;
                end
            end
            
        end
        
    end % end of for
    % 2.2) END ------------------------------------------------------------
    
    % 2.3) Last Stage -----------------------------------------------------
    
    
    
    % 2.3) END ------------------------------------------------------------
    
    % Step 2) END ---------------------------------------------------------
    
end

