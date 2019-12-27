function [Flag, GateType, ListOfPrimaryInputs] = CheckXORCondition( FirstObj, SecondObj )

    % FUNCTION DESCRIPTION: 
    % If they have the condition the flag will be set to 'true' 
    
    % Step 1) Variable Initialization -------------------------------------
    
    Flag = false;
    ListOfPrimaryInputs = nan(1, 6);
    GateType = cell(1, 2);
    
    FirstPrimaryInputs  = FirstObj.ListOfPrimaryInputs;
    SecondPrimaryInputs = SecondObj.ListOfPrimaryInputs;
    
    sum1 = 0;
    sum2 = 0;
    
     for i = 1 : 6
        if ( FirstPrimaryInputs(i) == 1 )
            sum1 = sum1 + 1;
        end
        if ( SecondPrimaryInputs(i) == 1 )
            sum2 = sum2 + 1;
        end
     end
     
     if (sum2 ~= 2) || (sum1 ~= 2)
         return;
     end
    
    
    IsCompatible = 'No';
    Count1 = 0;
    Count2 = 0;
    NoCount = 0;
    
    % check if they are compatible 
    if isequal(FirstObj.Hierarchy, 'Yes') || isequal(SecondObj.Hierarchy, 'Yes')
        return;
    else
        for i = 1 : 2 : 6
            if ( FirstPrimaryInputs(i) == 1 )
                if ( SecondPrimaryInputs(i+1) == 1 )
                    Count1 = Count1 + 1;
                    ListOfPrimaryInputs(i) = 1;
                end
            elseif ( FirstPrimaryInputs(i+1) == 1 )
                if ( SecondPrimaryInputs(i) == 1 )
                    Count2 = Count2 + 1;
                    ListOfPrimaryInputs(i) = 1;
                end
            end
            
            if     ( FirstPrimaryInputs(i+1) == 1 )
                if ( SecondPrimaryInputs(i+1) == 1 )
                    NoCount = NoCount + 1;
                end
            elseif ( FirstPrimaryInputs(i) == 1 )
                if ( SecondPrimaryInputs(i) == 1 )
                    NoCount = NoCount + 1;
                end
            end
        end
        
        if NoCount == 0
            if  ( (Count1 == 2 && Count2 == 0) || (Count1 == 0 && Count2 == 2))
                IsCompatible = 'Yes';
                Flag = true;
                GateType{1} = 'XNOR';
                GateType{2} = uint8(2);
            elseif (Count1 == 1 && Count2 == 1)
                IsCompatible = 'Yes';
                Flag = true;
                GateType{1} = 'XOR';
                GateType{2} = uint8(2);
            end
        end
    end
    
    % Step 1) END ---------------------------------------------------------
    
    % Step 2) Check -------------------------------------------------------
    % Step 2) END ---------------------------------------------------------

end

