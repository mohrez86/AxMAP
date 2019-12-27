function [ Flag_ApproximationValidity ] = CheckApproximationValidity( targetSequence )


    % FUNCTION DESCRIPTION: 
    
    for i=1:numel(targetSequence)
        if (targetSequence(i) == 26904)
            Flag_ApproximationValidity = false;
            return;
        end
    end
    Flag_ApproximationValidity = true;

end

