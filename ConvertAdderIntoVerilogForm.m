function [VerilogCode, FileName] = ConvertAdderIntoVerilogForm(AdderObject, IDString, ItsMED, ItsPower, ItsArea) 

    %FUNCTION DESCRIPTION 
    
    % Step 1) Variable Initialization -------------------------------------
    N = size(AdderObject, 2);
    
    MED = ItsMED;
    P   = ItsPower;
    A   = ItsArea;
    
    WireIndexes = zeros(1, N);
    
    LINES = cell(6,1);
    tempLINE = cell(1, 1);
    
    FileName = ['ID_', IDString];
    
    LINES{1} = ['module ', FileName, '(A, B, SUM, COUT);']; 
    LINES{2} = '// Input & Output Declarations ============================';
    LINES{3} = ['input ', '[', int2str(N-1), ':0] A, B;'];  
    LINES{4} = ['output ', '[', int2str(N-1), ':0] SUM;'];
    LINES{5} = ['output COUT;'];
    LINES{6} = '// Wires ==================================================';
    % Step 1) END ---------------------------------------------------------
    
    % Step 2) How Many Wires Do We Have? ----------------------------------
    for i = 1 : N-1
        
        if isequal(AdderObject{i}.carryOut, 'Yes')
            WireIndexes(i) = 1;
            
            tempLINE = ['wire C', int2str(i), ';'];
            LINES = [LINES; tempLINE];
        end
        
        
    end
    
    tempLINE = '// Body ===================================================';
    LINES = [LINES; tempLINE];
    % Step 2) END ---------------------------------------------------------
    
    % Step 3) Reform Boolean Expression -----------------------------------
    for i = 1 : N
        bitPosition = i - 1;
        [ ReformedExpression ] = ReformBooleanExpression( AdderObject{i}, bitPosition );
        
        if (i < N)
            if isequal(AdderObject{i}.carryOut, 'Yes')
                tempLINE = ['assign ', 'SUM[', int2str(bitPosition), '] = ', ...
                           ReformedExpression{1}, ';'];
                LINES = [LINES; tempLINE];
                
                tempLINE = ['assign ', 'C', int2str(i), ' = ', ...
                           ReformedExpression{2}, ';'];
                       
                LINES = [LINES; tempLINE];
                       
            else
                tempLINE = ['assign ', 'SUM[', int2str(bitPosition), '] = ', ...
                           ReformedExpression{1}, ';'];
                LINES = [LINES; tempLINE];
            end
        elseif (i == N)
            if isequal(AdderObject{i}.carryOut, 'Yes')
                tempLINE = ['assign ', 'SUM[', int2str(bitPosition), '] = ', ...
                           ReformedExpression{1}, ';'];
                LINES = [LINES; tempLINE];
                
                tempLINE = ['assign ', 'COUT = ', ...
                           ReformedExpression{2}, ';'];
                       
                LINES = [LINES; tempLINE];
                       
            else
                tempLINE = ['assign ', 'SUM[', int2str(bitPosition), '] = ', ...
                           ReformedExpression{1}, ';'];
                LINES = [LINES; tempLINE];
            end
        end
        
    end
    % Step 3) END ---------------------------------------------------------
    tempLINE = '// MODULE ENDS HERE!';
    LINES = [LINES; tempLINE];
    tempLINE = 'endmodule';
    LINES = [LINES; tempLINE];
    
    %VerilogCode = cell(1, 1);
    %VerilogCod{1} = ['MED= ', '   POWER= ', ]
    %VerilogCode = [VerilogCode; LINES];
    
    VerilogCode = LINES;
end