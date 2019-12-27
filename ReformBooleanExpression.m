function [ ReformedExpression ] = ReformBooleanExpression( CurrentBlock, BitPosition )


    %FUNCTION DESCRIPTION
    
    %Step 1) Variable Initialization --------------------------------------
    OldExp = CurrentBlock.gateLevelEquation;
    %NewExp = cell(size(CurrentBlock.gateLevelEquation, 1), 1);
    %Step 1) END ----------------------------------------------------------
    
    %Step 2) Reform -------------------------------------------------------
    if isequal(CurrentBlock.carryIn, 'No')
        
        for i = 1 : size(CurrentBlock.gateLevelEquation, 1)
            
            k = 1;
            for j = 1 : size(CurrentBlock.gateLevelEquation{i}, 2)
                
                if     isequal( CurrentBlock.gateLevelEquation{i}(j), 'A' )
                    
                    OldExp{i} = [OldExp{i}(1:k), '[', int2str(BitPosition), ']', ...
                              OldExp{i}(k+1:end)];
                    k = k + size( ['[', int2str(BitPosition), ']'], 2);
                elseif isequal( CurrentBlock.gateLevelEquation{i}(j), 'B' )
                    
                    OldExp{i} = [OldExp{i}(1:k), '[', int2str(BitPosition), ']', ...
                              OldExp{i}(k+1:end)];
                    k = k + size( ['[', int2str(BitPosition), ']'], 2);
                end
                
                k = k + 1;
            end
            
        end
    
    else % CarryIn == 'Yes' then change (A => C), (B => A), and (C => B)
        
        for i = 1 : size(CurrentBlock.gateLevelEquation, 1)
            
            k = 1;
            for j = 1 : size(CurrentBlock.gateLevelEquation{i}, 2)
                
                if     isequal( CurrentBlock.gateLevelEquation{i}(j), 'A' )
                    
                    OldExp{i} = [OldExp{i}(1:k-1), 'C', int2str(BitPosition), ...
                              OldExp{i}(k+1:end)];
                    k = k + size( [int2str(BitPosition)], 2);
                    
                elseif isequal( CurrentBlock.gateLevelEquation{i}(j), 'B' )
                    
                    OldExp{i} = [OldExp{i}(1:k-1), 'A', '[', int2str(BitPosition), ']', ...
                              OldExp{i}(k+1:end)];
                    k = k + size( ['[', int2str(BitPosition), ']'], 2);
                    
                elseif isequal( CurrentBlock.gateLevelEquation{i}(j), 'C' )
                    
                    OldExp{i} = [OldExp{i}(1:k-1), 'B', '[', int2str(BitPosition), ']', ...
                              OldExp{i}(k+1:end)];
                    k = k + size( ['[', int2str(BitPosition), ']'], 2);
                    
                end
                k = k + 1;
            end
        end
        
    end
    %Step 2) END ----------------------------------------------------------
    
    ReformedExpression = OldExp;

end

