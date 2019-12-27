function dominatingColumnIndex = dominatedColumnIdentifier( firstColumn, secondColumn )
% if the firstColumn is diminated by the secondColumn => dominatingColumnIndex = 1;
% if the secondColumn is diminated by the firstColumn => dominatingColumnIndex = 2;
% if non of the columns are dominated by each other => dominatingColumnIndex = 0;
    %----------------------------------------------------------------------
    if ( (sum(firstColumn) == sum(secondColumn)) )
        if (~isequal(firstColumn, secondColumn))
            dominatingColumnIndex = 0;
            return;
        else
            dominatingColumnIndex = 1;
            return;
        end
    end
    %----------------------------------------------------------------------
    if (sum(firstColumn) > sum(secondColumn))
        if ( isequal( (firstColumn >= secondColumn), ones(size(firstColumn, 1), 1) ) )
            dominatingColumnIndex = 2;
            return;
        else
            dominatingColumnIndex = 0;
            return;
        end
    end
    %----------------------------------------------------------------------
    if (sum(firstColumn) < sum(secondColumn))
        if ( isequal( (firstColumn <= secondColumn), ones(size(firstColumn, 1), 1) ) )
            dominatingColumnIndex = 1;
            return;
        else
            dominatingColumnIndex = 0;
            return;
        end
    end    
    %----------------------------------------------------------------------
end

