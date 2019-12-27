function [ Flag_PowerValidity, TotalPower] = CheckPowerValidity( targetAdderObject, PowerConstraint )


    % FUNCTION DESCRIPTION:
    
    AdderWidth = size(targetAdderObject, 2);
    MaxPower = PowerConstraint;
    TotalPower = 0;
    
    %----------------------------------------------------------------------
    for i = 1 : AdderWidth
        TotalPower = TotalPower + targetAdderObject{i}.Power;
    end
    %----------------------------------------------------------------------
    if TotalPower > MaxPower 
        Flag_PowerValidity = false;
    else
        Flag_PowerValidity = true;
    end
    %----------------------------------------------------------------------
end

