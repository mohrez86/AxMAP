function minimalSolution = findMinimalBooleanEquation( minimalExpression, PIs )

% minimalExpression: is a matrix containing the last remaining PIs
% PIs: is a vertical array containing the equation of remaining PIs
% result: is a vertical array containig all EPIs

% Local standard cell Library----------------------------------------------

% AND (6T), OR (6T), NAND (4T), NOR (4T), NOT (2T)

% localStandardCellLibrary = cell(5, 2);
% 
% localStandardCellLibrary{1,1} = 'AND';
% localStandardCellLibrary{1,2} = 6;
% 
% localStandardCellLibrary{2,1} = 'OR';
% localStandardCellLibrary{2,2} = 6;
% 
% localStandardCellLibrary{3,1} = 'NAND';
% localStandardCellLibrary{3,2} = 4;
% 
% localStandardCellLibrary{4,1} = 'NOR';
% localStandardCellLibrary{4,2} = 4;
% 
% localStandardCellLibrary{5,1} = 'NOT';
% localStandardCellLibrary{5,2} = 2;

%--------------------------------------------------------------------------
% Counting the transistors of Prime Implicants of PIs array 

    costOfPIs = zeros(size(PIs, 1), 1);

    for i=1:size(PIs, 1)
        for j=1:size(PIs, 2)
            if ( isequal(PIs(i, j), '0') || isequal(PIs(i, j), '1') )
                costOfPIs(i, 1) =  costOfPIs(i, 1) + 1;
            end
        end
    end
%--------------------------------------------------------------------------
% Finding the minimum number of products

    minimumRow = Inf;

    for i=1:size(minimalExpression, 1)
        if ( sum(minimalExpression(i,:)) < minimumRow )
            minimumRow = sum(minimalExpression(i,:));
        end
    end
%--------------------------------------------------------------------------
% Finding indexes of all solutions with minimum number of products
    listOfMinimumExpressionIndexes = [];
    for i=1:size(minimalExpression, 1)
        if ( sum(minimalExpression(i,:)) == minimumRow )
            listOfMinimumExpressionIndexes = [listOfMinimumExpressionIndexes, i];
        end
    end
%--------------------------------------------------------------------------
% Finding the minimum cost of all above minimal solutions
    costsOfminimalExpressions = zeros(size(listOfMinimumExpressionIndexes, 2), 1);
    
    for i=1:size(listOfMinimumExpressionIndexes, 2)
        for j=1:size(minimalExpression, 2)
            
            
            if ( isequal( minimalExpression(listOfMinimumExpressionIndexes(i), j), 1) )
                costsOfminimalExpressions(i, 1) = costsOfminimalExpressions(i, 1) + costOfPIs(j, 1);
            end
            
        end
    end
%--------------------------------------------------------------------------
% Selecting the solution with minimum cost
    
    for i=1:size(costsOfminimalExpressions, 1)        
        if ( isequal(costsOfminimalExpressions(i, 1), min(costsOfminimalExpressions)) )
            IndexOfMinimumIndex = i;
            break;
        end
    end
    minimumIndex = listOfMinimumExpressionIndexes (1, IndexOfMinimumIndex);
    minimalSolution = minimalExpression(minimumIndex, :);
%--------------------------------------------------------------------------
%---------------------------------THE END----------------------------------
end

