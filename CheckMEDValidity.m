function [ Flag_MEDValidity , TotalMED] = CheckMEDValidity( targetAdderObject, ...
                                                  MEDConstraint, ...
                                                  InputDistributionA, ...
                                                  InputDistributionB)


    % FUNCTION DESCRIPTION:
    
    AdderWidth = size(targetAdderObject, 2);
    MaxMED = MEDConstraint;
    DA = InputDistributionA;
    DB = InputDistributionB;
    
    TotalMED = 0;
    %----------------------------------------------------------------------
    [ TotalMED, ~ ] = LongTerm_MED_ER( targetAdderObject, DA, DB);
    %----------------------------------------------------------------------
    if TotalMED > MaxMED
        Flag_MEDValidity = false;
    else
        Flag_MEDValidity = true;
    end
    %----------------------------------------------------------------------
end

