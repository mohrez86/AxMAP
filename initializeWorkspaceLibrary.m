function standardWorkspaceLibrary = initializeWorkspaceLibrary()% Here, we want to generate all possible single-bit approximate adders

% First questions is: How do we start?
AccurateFullAdderTruthTable = [0 1 1 2 1 2 2 3];
AccurateHalfAdderTruthTable = [0 1 1 2];

numberOfProperties = 9;

numberOfPrimaryBuildingBlocks = 2^16; %65536 = All possible single-bit approximate adders

standardWorkspaceLibrary = cell (numberOfPrimaryBuildingBlocks, numberOfProperties);

Length = 1; 
Delay = 1;

for i=1:256
    for j=1:256
        % Generating a truth table for sum---------------------------------
        sumTruthTable = de2bi(i-1, 8);
        sumTruthTable = sumTruthTable(8:-1:1);
        %------------------------------------------------------------------
        
        % Generating a truth table for carry Out---------------------------
        carryOutTruthTable = de2bi(j-1, 8);
        carryOutTruthTable = carryOutTruthTable(8:-1:1);
        %------------------------------------------------------------------
        
        % checking whether it generates carryOut or not--------------------
        if (sum(carryOutTruthTable) == 0)
            carryOut = 'No';
        else
            carryOut = 'Yes';
        end
        %------------------------------------------------------------------
        
        % checking whether it has carryIn or not---------------------------
        if(isequal(sumTruthTable(1:4), sumTruthTable(5:8)))
            if(isequal(carryOutTruthTable(1:4), carryOutTruthTable(5:8)))
                carryIn = 'No';
            else
                carryIn = 'Yes';
            end
        else
            carryIn = 'Yes';
        end
        %------------------------------------------------------------------
        
        % calculating the truthTable field---------------------------------
        if (strcmp(carryIn, 'Yes'))
            if (strcmp(carryOut, 'Yes'))
                truthTable = cell(2, 1);
                truthTable{1} = sumTruthTable;
                truthTable{2} = carryOutTruthTable;
            else % carryOut = 'No'
                truthTable = cell(1, 1);
                truthTable{1} = sumTruthTable;
            end 
        else % carryIn = 'No'
            if (strcmp(carryOut, 'Yes'))
                truthTable = cell(2, 1);
                truthTable{1} = sumTruthTable(1:4);
                truthTable{2} = carryOutTruthTable(1:4);
            else % carryOut = 'No'
                truthTable = cell(1, 1);
                truthTable{1} = sumTruthTable(1:4);
            end
        end
        %------------------------------------------------------------------
        
        % calculating the error Table field
        if (strcmp(carryIn, 'Yes'))
            if (strcmp(carryOut, 'Yes'))
                errorTable = (2*carryOutTruthTable + sumTruthTable) - AccurateFullAdderTruthTable;
            else % carryOut = 'No'
                errorTable = sumTruthTable - AccurateFullAdderTruthTable;
            end    
        else % carryIn = 'No'
            if (strcmp(carryOut, 'Yes'))
                errorTable = (2*carryOutTruthTable(1:4) + sumTruthTable(1:4)) - AccurateHalfAdderTruthTable;
            else
                errorTable = sumTruthTable(1:4) - AccurateHalfAdderTruthTable;
            end
        end
        %------------------------------------------------------------------
        % filling the standardWorkspaceLibrary database
        Index = (i-1) * 2^8 + (j-1) + 1;
        standardWorkspaceLibrary{Index, 1} = Length; % length
        standardWorkspaceLibrary{Index, 2} = Delay; % delay
        standardWorkspaceLibrary{Index, 3} = truthTable; % sum and carryOut binary truth tables
        standardWorkspaceLibrary{Index, 4} = errorTable; % integer error table
        standardWorkspaceLibrary{Index, 5} = carryOut; % cout = carryOut
        standardWorkspaceLibrary{Index, 6} = carryIn; % cin = carryIn 
        
        if (strcmp(carryIn, 'Yes') || strcmp(carryOut, 'Yes'))% cCL = carry Chain Length
            standardWorkspaceLibrary{Index, 7} = 1; 
        else
            standardWorkspaceLibrary{Index, 7} = 0; 
        end
        if (strcmp(carryIn, 'Yes') || strcmp(carryOut, 'Yes'))% cCSP = carry Chain Starting Position
            standardWorkspaceLibrary{Index, 8} = 1; 
        else
            standardWorkspaceLibrary{Index, 8} = 0; 
        end
        standardWorkspaceLibrary{Index, 9} = Index; % lCBB = list Of Constructive Building Blocks
    end
end