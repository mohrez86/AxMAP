function [ DB ] = GenerateDataBase(standardLogicLibrary, ...
                                   standardLogicLibrary_CinBar_CoBar, ...
                                   standardLogicLibrary_CinBar_Co, ...
                                   standardLogicLibrary_Cin_CoBar, ...
                                   standardLogicLibrary_Cin_Co)

    DB      = cell(1, 10);
    IsValid = false(1, 10);
    %================================= 1-Bit ==============================
    % 1- Blocks_1bit_NoCout
    
    
    while(~IsValid(1))
    [ DB{1} ] = FormLargeBuildingBlocksNoCout(40, 100000, 1, 1, 8, 3, 1, ...
                                              0.5, 0.5, ...
                                              standardLogicLibrary, ...
                                              standardLogicLibrary_CinBar_CoBar, ...
                                              standardLogicLibrary_CinBar_Co, ...
                                              standardLogicLibrary_Cin_CoBar, ...
                                              standardLogicLibrary_Cin_Co);
    
    [ IsValid(1) ] = CheckDBValidity( DB{1} );
    end
                                          
                                          
    % 2- Blocks_1bit
    while(~IsValid(2))
    [ DB{2} ] = FormLargeBuildingBlocksWithCout(40, 100000, 1, 1, 14, 3, 0.75, ...
                                              0.5, 0.5, ...
                                              standardLogicLibrary, ...
                                              standardLogicLibrary_CinBar_CoBar, ...
                                              standardLogicLibrary_CinBar_Co, ...
                                              standardLogicLibrary_Cin_CoBar, ...
                                              standardLogicLibrary_Cin_Co);
    [ IsValid(2) ] = CheckDBValidity( DB{2} );
    end
    %======================================================================                                      
    
    
    %================================= 2-Bit ==============================
    % 3- Blocks_2bit_NoCout
    while(~IsValid(3))
    [ DB{3} ] = FormLargeBuildingBlocksNoCout(40, 1000000, 2, 2, 14, 3, 2.5, ...
                                              ones(1, 2)/2, ones(1, 2)/2, ...
                                              standardLogicLibrary, ...
                                              standardLogicLibrary_CinBar_CoBar, ...
                                              standardLogicLibrary_CinBar_Co, ...
                                              standardLogicLibrary_Cin_CoBar, ...
                                              standardLogicLibrary_Cin_Co);
    [ IsValid(3) ] = CheckDBValidity( DB{3} );
    end
    
    % 4- Blocks_2bit
    while(~IsValid(4))
    [ DB{4} ] = FormLargeBuildingBlocksWithCout(40, 1000000, 2, 2, 19, 4, 1.5, ...
                                              ones(1, 2)/2, ones(1, 2)/2, ...
                                              standardLogicLibrary, ...
                                              standardLogicLibrary_CinBar_CoBar, ...
                                              standardLogicLibrary_CinBar_Co, ...
                                              standardLogicLibrary_Cin_CoBar, ...
                                              standardLogicLibrary_Cin_Co);
    [ IsValid(4) ] = CheckDBValidity( DB{4} );
    end
    %======================================================================  
    
    
    %================================= 3-Bit ==============================
    % 5- Blocks_3bit_NoCout
    while(~IsValid(5))
    [ DB{5} ] = FormLargeBuildingBlocksNoCout(40, 1000000, 3, 2, 19, 4, 5, ...
                                              ones(1, 3)/2, ones(1, 3)/2, ...
                                              standardLogicLibrary, ...
                                              standardLogicLibrary_CinBar_CoBar, ...
                                              standardLogicLibrary_CinBar_Co, ...
                                              standardLogicLibrary_Cin_CoBar, ...
                                              standardLogicLibrary_Cin_Co);
    [ IsValid(5) ] = CheckDBValidity( DB{5} );
    end
    
    % 6- Blocks_3bit
    while(~IsValid(6))
    [ DB{6} ] = FormLargeBuildingBlocksWithCout(40, 1000000, 3, 2, 25, 5, 2.5, ...
                                              ones(1, 3)/2, ones(1, 3)/2, ...
                                              standardLogicLibrary, ...
                                              standardLogicLibrary_CinBar_CoBar, ...
                                              standardLogicLibrary_CinBar_Co, ...
                                              standardLogicLibrary_Cin_CoBar, ...
                                              standardLogicLibrary_Cin_Co);
    [ IsValid(6) ] = CheckDBValidity( DB{6} );
    end
    %======================================================================  
                                          
    
    %================================= 4-Bit ==============================
    % 7- Blocks_4bit_NoCout
    while(~IsValid(7))
    [ DB{7} ] = FormLargeBuildingBlocksNoCout(40, 1000000, 4, 2, 25, 5, 8, ...
                                              ones(1, 4)/2, ones(1, 4)/2, ...
                                              standardLogicLibrary, ...
                                              standardLogicLibrary_CinBar_CoBar, ...
                                              standardLogicLibrary_CinBar_Co, ...
                                              standardLogicLibrary_Cin_CoBar, ...
                                              standardLogicLibrary_Cin_Co);
    [ IsValid(7) ] = CheckDBValidity( DB{7} );
    end
    
    % 8- Blocks_4bit
    while(~IsValid(8))
    [ DB{8} ] = FormLargeBuildingBlocksWithCout(40, 1000000, 4, 2, 30, 6, 4, ...
                                              ones(1, 4)/2, ones(1, 4)/2, ...
                                              standardLogicLibrary, ...
                                              standardLogicLibrary_CinBar_CoBar, ...
                                              standardLogicLibrary_CinBar_Co, ...
                                              standardLogicLibrary_Cin_CoBar, ...
                                              standardLogicLibrary_Cin_Co);
    [ IsValid(8) ] = CheckDBValidity( DB{8} );
    end
    %======================================================================  

    
    %================================= 5-Bit ==============================
    % 9- Blocks_5bit_NoCout
    while(~IsValid(9))
    [ DB{9} ] = FormLargeBuildingBlocksNoCout(40, 1000000, 5, 2, 30, 6, 12, ...
                                              ones(1, 5)/2, ones(1, 5)/2, ...
                                              standardLogicLibrary, ...
                                              standardLogicLibrary_CinBar_CoBar, ...
                                              standardLogicLibrary_CinBar_Co, ...
                                              standardLogicLibrary_Cin_CoBar, ...
                                              standardLogicLibrary_Cin_Co);
    [ IsValid(9) ] = CheckDBValidity( DB{9} );
    end
    
    % 10- Blocks_5bit
    while(~IsValid(10))
    [ DB{10} ] = FormLargeBuildingBlocksWithCout(40, 1000000, 5, 2, 36, 7, 9, ...
                                              ones(1, 5)/2, ones(1, 5)/2, ...
                                              standardLogicLibrary, ...
                                              standardLogicLibrary_CinBar_CoBar, ...
                                              standardLogicLibrary_CinBar_Co, ...
                                              standardLogicLibrary_Cin_CoBar, ...
                                              standardLogicLibrary_Cin_Co);
    [ IsValid(10) ] = CheckDBValidity( DB{10} );
    end
    %======================================================================  
    
end

