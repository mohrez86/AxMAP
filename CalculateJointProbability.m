function [ JointProbability ] = CalculateJointProbability( FirstInput, SecondInput, ... 
                                                           InputDistributionA, ... 
                                                           InputDistributionB)
    
    %----------------------------------------------------------------------
    Length = size(InputDistributionA, 2);
    DA = InputDistributionA;
    DB = InputDistributionB;
    
    A = de2bi(FirstInput, Length);
    B = de2bi(SecondInput, Length);
    tempA = 1;
    tempB = 1;
    %----------------------------------------------------------------------
    
    %----------------------------------------------------------------------
    for i = 1 : Length
        
        if (A(i) == 1)
            PA = DA(i);
        else
            PA = (1 - DA(i));
        end
        
        if (B(i) == 1)
            PB = DB(i);
        else
            PB = (1 - DB(i));
        end
        
        tempA = tempA * PA;
        tempB = tempB * PB;
    end
    
    JointProbability = tempA * tempB;
    %----------------------------------------------------------------------

end

