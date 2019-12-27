function [ SelectedAdder ] = FormNBitAddersFromDB( DataBase, HowMany,  Iterations, BitWidth, ...
                                               MED_Constraint, POWER_Constraint, ...
                                               AREA_Constraint, ...
                                               DA, DB )

    
    % FUNCTION DESCRIPTION
    
    % Step 1) Variable Initialization -------------------------------------
    SelectedAdder = cell(1, 4); % [NBitAdder] [its med] [its power] [its area]
    
    SelectedAdder{1, 1} = 'Adder Object';
    SelectedAdder{1, 2} = 'MED';
    SelectedAdder{1, 3} = 'POWER';
    SelectedAdder{1, 4} = 'AREA';
    
    tempSelectedAdder = cell(1, 4);
    %currentN = 0;
    %Width = 0;
    %LBW =  0; % Last Block Width 
    CurrentNBitAdder = cell(1, BitWidth);
    CurrentIndex = 1;
    
    % Step 1) END ---------------------------------------------------------
    
    % Step 2) Search "DB" and Form ----------------------------------------
    
    for LBW = 1 : 5
        
        for I = 1 : uint8(Iterations/5)

            % 2.1) LSBs =======================================================
            Remainder = double(BitWidth - LBW);
            while ( Remainder )

                %% Choose a 1 to 5 bit block
                Width = randi([1, 10], 1);
                if (mod(Width, 2) == 0)
                    Width = Width - 1;
                end
                ChosenBlockLength = uint8(ceil(Width/2));

                while (ChosenBlockLength > Remainder)
                    Width = randi([1, 10], 1);
                    if (mod(Width, 2) == 0)
                        Width = Width - 1;
                    end
                    ChosenBlockLength = uint8(ceil(Width/2));
                end


                WhichBlock = randi([1, 40], 1);
                
                %The Block is chosen, 
                    %Its length is in "ChosenBlockLength" and
                    %its implementation is in "DataBase{Width}{WhichBlock}" 
                    
                %%
                for i = 1 : ChosenBlockLength
                    CurrentNBitAdder{CurrentIndex} = DataBase{Width}{WhichBlock}{1}{i};
                    CurrentIndex = CurrentIndex + 1;
                end

                Remainder = double(Remainder) -  double(ChosenBlockLength);

            end
            % 2.1) END ========================================================


            % 2.2) MSB ========================================================
            WhichBlock = randi([1, 40], 1);
            for i = 1 : LBW
                CurrentNBitAdder{CurrentIndex} = DataBase{2*LBW}{WhichBlock}{1}{i};
                CurrentIndex = CurrentIndex + 1;
            end
            % 2.2) END ========================================================

            % Now the CurrentNBitAdder is ready!
            CurrentIndex = 1;
            %% Debug code starts
%             for xx = 1 : N
%                 if isempty(CurrentNBitAdder{xx})
%                    disp('Empty'); 
%                 end
%             end
%             CurrentNBitAdder
            %% Debug Code ends
            
            [ itsMed, ~ ] = LongTerm_MED_ER( CurrentNBitAdder, DA, DB);
            
            if itsMed < MED_Constraint
            
                [Flag_PowerValidity, itsPower] = CheckPowerValidity( CurrentNBitAdder, POWER_Constraint );
                [~ , itsArea]   = CheckAreaValidity(CurrentNBitAdder, AREA_Constraint);
                
                if Flag_PowerValidity == true
                    tempSelectedAdder{1, 1} = CurrentNBitAdder;
                    tempSelectedAdder{1, 2} = itsMed;
                    tempSelectedAdder{1, 3} = itsPower;
                    tempSelectedAdder{1, 4} = itsArea;

                    SelectedAdder = [SelectedAdder; tempSelectedAdder];

                    if size(SelectedAdder, 1) == (HowMany + 1)
                        return;
                    end
                end
                
            end
            
            CurrentNBitAdder = cell(1, BitWidth);
            
        end
        
    end
    
    
    % Step 2) END ---------------------------------------------------------
end

