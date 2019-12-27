function [ Flag_AreaValidity, TotalArea ] = CheckAreaValidity( targetAdderObject, AreaConstraint )


    % FUNCTION DESCRIPTION:
    
    AdderWidth = size(targetAdderObject, 2);
    MaxArea = AreaConstraint;
    TotalArea = 0;
    
    %----------------------------------------------------------------------
    for i = 1 : AdderWidth
        TotalArea = TotalArea + targetAdderObject{i}.Area;
    end
    %----------------------------------------------------------------------
    if TotalArea > MaxArea 
        Flag_AreaValidity = false;
    else
        Flag_AreaValidity = true;
    end
    %----------------------------------------------------------------------
end

