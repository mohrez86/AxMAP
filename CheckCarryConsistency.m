function [ Flag_CarryChainValidity ] = CheckCarryConsistency( targetAdderObject )

    % FUNCTION DESCRIPTION:
    
    Flag_CarryChainValidity = true;
    
    if isequal(targetAdderObject{1}.carryIn, 'Yes')
        Flag_CarryChainValidity = false;
        return;
%     elseif isequal(targetAdderObject{end}.carryOut, 'No')
%         Flag_CarryChainValidity = false;
%         return;
    else
        for i = 1 : size(targetAdderObject,2)-1
            if ( ( isequal(targetAdderObject{i}.carryOut, 'No') && ...
                 isequal(targetAdderObject{i+1}.carryIn, 'Yes') ) || ...
                 ( isequal(targetAdderObject{i}.carryOut, 'Yes') && ...
                 isequal(targetAdderObject{i+1}.carryIn, 'No') ) )
                
                Flag_CarryChainValidity = false;
                return;
             
            else
                continue;
            end
        end
    end

end

