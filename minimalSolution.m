function minimalExpression = minimalSolution(Accumulator, formedRow)

% Note that accumulator can be matrix as well! In fact it often is!

% Create minimal expression matrix-----------------------------------------
minimalExpressionRows = size(Accumulator, 1) * size(formedRow, 1);
minimalExpressionColumns = size(Accumulator, 2);

minimalExpression = zeros(minimalExpressionRows, minimalExpressionColumns);
%--------------------------------------------------------------------------

% Multiply-----------------------------------------------------------------
for i=1:size(Accumulator, 1)
    for j=1:size(formedRow, 1)
        
        Index = (i-1)*size(formedRow, 1) + j;
        
        minimalExpression(Index, :) = Accumulator(i, :) | formedRow(j, :);
        
    end    
end
%--------------------------------------------------------------------------

% Simplify-----------------------------------------------------------------
 listOfDominatingRows = [];

    for i=1:size(minimalExpression, 1)
        for j=i+1:size(minimalExpression, 1)

            if (dominatingRowIdentifier(minimalExpression(i, :), minimalExpression(j, :)) == 0 )
                continue;
            elseif (dominatingRowIdentifier(minimalExpression(i, :), minimalExpression(j, :)) == 1 )
                listOfDominatingRows = [listOfDominatingRows, i];
            elseif (dominatingRowIdentifier(minimalExpression(i, :), minimalExpression(j, :)) == 2 )
                listOfDominatingRows = [listOfDominatingRows, j];
            end

        end
    end
    
    listOfDominatingRows = sort(unique(listOfDominatingRows));
    tempListOfDominatingRows = listOfDominatingRows;
    
        % Removing dominating rows if its list is not empty
    if (~isempty(listOfDominatingRows))
        
        for i=1:size(listOfDominatingRows, 2)
            minimalExpression(tempListOfDominatingRows(i), :) = [];
            tempListOfDominatingRows = [tempListOfDominatingRows(1:i), tempListOfDominatingRows(i+1:end)-1];
        end
        
    end
%--------------------------------------------------------------------------
end
