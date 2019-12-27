function [ Flag_TimingValidity , LongestChainLength] = CheckTimingValidity( targetAdderObject, servedTiming )

    % FUNCTION DESCRIPTION:
    
    AdderWidth = size(targetAdderObject, 2);
    K = servedTiming;
    Chain = zeros(1, AdderWidth-1);
    LongestChainLength = 0;
    Counter = 0;
    %----------------------------------------------------------------------
    for i = 1 : AdderWidth-1
        if ( isequal(targetAdderObject{i}.carryOut, 'Yes') && ...
             isequal(targetAdderObject{i+1}.carryIn, 'Yes')      )
            Chain(1, i) = 1;
        else
            Chain(1, i) = 0;
        end
    end
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    for i = 1: AdderWidth-1
        if Chain(1, i) == 1
            Counter = Counter + 1;
            if (Counter > LongestChainLength)
                LongestChainLength = Counter;
            end
        else
            Counter = 0;
        end
    end
    %----------------------------------------------------------------------
    LongestChainLength = LongestChainLength + 1;
    
    if LongestChainLength > K 
        Flag_TimingValidity = false;
    else
        Flag_TimingValidity = true;
    end
    %----------------------------------------------------------------------
end

