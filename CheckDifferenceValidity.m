function [ DifferentMorningResult, Flag, NumOfSame ] = ...
         CheckDifferenceValidity( MorningResults_Uniform )

    % FUNCTION DESCRIPTION
    NumOfAdders = size(MorningResults_Uniform, 1);
    AdderWidth  = size(MorningResults_Uniform{1}{2,1}, 2);
    
    NumOfSame   = 0;
    Count       = 0;
    SameTables  = 0;
    
    DifferentMorningResult = MorningResults_Uniform;
    Flag = true;
    %% 
    for i = 1 : NumOfAdders - 1 
        for j = i+1 : NumOfAdders
            if (i ~= j)
                
                Adder1 = MorningResults_Uniform{i}{2,1};
                Adder2 = MorningResults_Uniform{j}{2,1};
                    %------------------------------------------------------
                    for k = 1 : AdderWidth
                        %--------------------------------------------------
                        if ( size(Adder1{k}.truthTable, 1) == ...
                             size(Adder2{k}.truthTable, 1)       )
                            %----------------------------------------------
                            for n = 1 : size(Adder1{k}.truthTable, 1)
                                %------------------------------------------
                                if isequal(Adder1{k}.truthTable{n}, Adder2{k}.truthTable{n})
                                    SameTables = SameTables + 1;
                                end
                                %------------------------------------------
                            end
                            
                            if size(Adder1{k}.truthTable, 1) == 1
                                
                                if SameTables == 1
                                    Count = Count + 1; 
                                end
                                
                            elseif size(Adder1{k}.truthTable, 1) == 2
                                
                                if SameTables == 2
                                    Count = Count + 1; 
                                end
                                
                            end
                            
                            SameTables = 0;
                            
                            %----------------------------------------------
                        end
                        %--------------------------------------------------
                    end
                    %------------------------------------------------------
                    
                    if (Count == 8 )
                        % These two blocks are the same;
                        NumOfSame = NumOfSame + 1;
                        Flag      = false;
                    end
                    
                    Count = 0;
                    
            end
        end
    end
end

