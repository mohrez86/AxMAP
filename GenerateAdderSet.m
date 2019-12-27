function [ AdderSet ] = GenerateAdderSet( DataBase, NumOfDesiredDesigns, StepIteration, ...
                                          BitWidth, MED_Const, POWER_Const, ...
                                          AREA_Const, DA, DB)
    
    AdderSet = cell(NumOfDesiredDesigns, 1);
    
    for i = 1 : NumOfDesiredDesigns
        ROWS = 1;
        while (ROWS == 1)
            
            [ SelectedAdder ] = FormNBitAddersFromDB( DataBase, 1,  ...
                                               StepIteration, BitWidth, ...
                                               MED_Const, POWER_Const, ...
                                               AREA_Const, DA, DB );

            ROWS = size(SelectedAdder, 1);
%             if ROWS > 1
%                 if ( (SelectedAdder{2,3} < 53) && (SelectedAdder{2,4} <9.5 ) )
%                     disp(i);
%                 else
%                     ROWS = 1;
%                 end
%             end

        end
        AdderSet{i} = SelectedAdder;
    end


end

