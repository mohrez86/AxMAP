function dominatingRowIndex = dominatingRowIdentifier(firstRow, secondRow)
% if the firstRow diminates the secondRow => dominatingRowIndex = 1;
% if the secondRow diminates the firstRow => dominatingRowIndex = 2;
% if non of the rows are dominating each other => dominatingRowIndex = 0;
    %----------------------------------------------------------------------
    if ( (sum(firstRow) == sum(secondRow)) )
        if (~isequal(firstRow, secondRow))
            dominatingRowIndex = 0;
            return;
        else
            dominatingRowIndex = 1;
            return;
        end
    end
    %----------------------------------------------------------------------
    if (sum(firstRow) > sum(secondRow))
        dominatingRowIndex = isequal( (firstRow >= secondRow), ones(1, size(firstRow, 2)) );
        return;
    end
    %----------------------------------------------------------------------
    if (sum(firstRow) < sum(secondRow))
        if ( isequal( (firstRow <= secondRow), ones(1, size(firstRow, 2)) ) )
            dominatingRowIndex = 2;
            return;
        else
            dominatingRowIndex = 0;
            return;
        end
    end    
    %----------------------------------------------------------------------
end

