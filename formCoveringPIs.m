function formedExpression = formCoveringPIs( Matrix )
    
    % determining the dimension of formedExpression 
    formedExpressionRows = 0;
    
    for i=1:size(Matrix, 1)
        formedExpressionRows = formedExpressionRows + numel( find(Matrix(i, :)) );
    end
    
    formedExpressionColumns = size(Matrix, 2);
    %----------------------------------------------------------------------
    
    % creating the output matrix
    formedExpression = zeros(formedExpressionRows, formedExpressionColumns);
    %----------------------------------------------------------------------
    
    Index = 1;
    
    for i=1:size(Matrix, 1)
        
        coveringPIs = find(Matrix(i, :));
        
        for j = Index : Index + ( numel(coveringPIs) - 1 )
            
        end
        
    end
    
    for i=1:formedExpressionRows
        formedExpression(i, coveringPIs(i)) = 1;
    end


end

