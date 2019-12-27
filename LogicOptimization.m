function [ OptimizedMatrixExpression ] = LogicOptimization( minimalMatrixExpression )

    % FUNCTION DESCRIPTION
    
    % Performing 2 Optimization Techniques: 
        % 1) XOR/XNOR
        % 2) NAND/NOR 
        
    % Step 1) Variable Initialization -------------------------------------
    
    NumOfVariables = size(minimalMatrixExpression, 2)/2;
    
    [ROWS, COLS] = size(minimalMatrixExpression);
    
    PrimaryMatForm = minimalMatrixExpression;
    
    
    % Step 1) END ---------------------------------------------------------
    
    % Step 2) XOR/XNOR ----------------------------------------------------
    for i = 1 : ROWS-1
        for j = i+1 : ROWS
            % Return pairs with XOR/XNOR condition
            [Flag, DiffFlagVector] = CheckXORCondition( PrimaryMatForm(i, 1:end), ...
                                                        PrimaryMatForm(j, 1:end));
            if Flag == true 
                
            end
        end
    end
    % Step 1) END ---------------------------------------------------------

end

