clc;

HowMany = 400;
MEDLimit = 40.1;

MorningResults_Uniform = cell(HowMany, 1);

% D = cell(7, 1);
% 
% D{1}  = AllClusters{3,  1};
% D{2}  = AllClusters{7,  1};
% D{3}  = AllClusters{8,  1};
% D{4}  = AllClusters{9,  1};
% D{5} = AllClusters{12, 1};
% D{6} = AllClusters{15, 1};
% D{7} = AllClusters{20, 1};



for i = 1 : HowMany
    ROWS = 1;
    while (ROWS == 1)
        [ LIB_8BITS ] = FormNBitAddersFromDB( DB, 1,  20000, 8, MEDLimit, ones(1, 8)/2, ones(1, 8)/2 );
        
        %for j = 
%         MED = LongTerm_MED_ER(LIB_8BITS{2,1}, D{6}, D{6});
%         if MED > MEDLimit
%             ROWS = 1;
%         end
%         %end
%         if MED > MEDLimit
%             continue;
%         end
        
        ROWS = size(LIB_8BITS, 1);
        if ROWS > 1
            if ( (LIB_8BITS{2,3} < 53) && (LIB_8BITS{2,4} <9.5 ) )
                disp(i);
            else
                ROWS = 1;
            end
        end
        
    end
    MorningResults_Uniform{i} = LIB_8BITS;
end