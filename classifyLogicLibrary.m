function [ standardLogicLibrary_CinBar_CoBar, standardLogicLibrary_CinBar_Co, ...
           standardLogicLibrary_Cin_CoBar, standardLogicLibrary_Cin_Co] = ...
           classifyLogicLibrary( standardLogicLibrary )

    % FUNCTION DESCRIPTION: 
    
    % Step 1) Variable Initialization--------------------------------------
    
    CinBar_CoBar = 0;
    CinBar_Co = 0;
    Cin_CoBar = 0;
    Cin_Co = 0;
    for i = 1 : size(standardLogicLibrary, 1)
        if ( isequal(standardLogicLibrary{i}.carryIn, 'No') && ...
             isequal(standardLogicLibrary{i}.carryOut, 'No')      )
            
            CinBar_CoBar = CinBar_CoBar + 1;
            
        elseif ( isequal(standardLogicLibrary{i}.carryIn, 'No') && ...
                 isequal(standardLogicLibrary{i}.carryOut, 'Yes')      )
             
            CinBar_Co = CinBar_Co + 1;
             
        elseif ( isequal(standardLogicLibrary{i}.carryIn, 'Yes') && ...
                 isequal(standardLogicLibrary{i}.carryOut, 'No')      )
             
            Cin_CoBar = Cin_CoBar + 1;
             
        else
            Cin_Co = Cin_Co + 1;
        end
    end % end of for
    % Step 1) END ---------------------------------------------------------
    
    % Step 2) Space Allocation --------------------------------------------
    standardLogicLibrary_CinBar_CoBar = cell(CinBar_CoBar, 1);
    standardLogicLibrary_CinBar_Co = cell(CinBar_Co, 1);
    standardLogicLibrary_Cin_CoBar = cell(Cin_CoBar, 1);
    standardLogicLibrary_Cin_Co = cell(Cin_Co, 1);
    % Step 2) END ---------------------------------------------------------
    
    % Step 3) Classify ----------------------------------------------------
    j = 1;
    k = 1;
    
    l = 1;
    m = 1;
    
    for i = 1 : size(standardLogicLibrary, 1)
        
        if ( isequal(standardLogicLibrary{i}.carryIn, 'No') && ...
             isequal(standardLogicLibrary{i}.carryOut, 'No')      )
            
            standardLogicLibrary_CinBar_CoBar{j} = standardLogicLibrary{i};
            j = j + 1;
            
        elseif ( isequal(standardLogicLibrary{i}.carryIn, 'No') && ...
                 isequal(standardLogicLibrary{i}.carryOut, 'Yes')      )
             
            standardLogicLibrary_CinBar_Co{k} = standardLogicLibrary{i};
            k = k + 1;
             
        elseif ( isequal(standardLogicLibrary{i}.carryIn, 'Yes') && ...
                 isequal(standardLogicLibrary{i}.carryOut, 'No')      )
             
            standardLogicLibrary_Cin_CoBar{l} = standardLogicLibrary{i};
            l = l + 1; 
            
        else
            standardLogicLibrary_Cin_Co{m} = standardLogicLibrary{i};
            m = m + 1;
            
        end
        
    end % end of for
    % Step 3) END ---------------------------------------------------------
end

