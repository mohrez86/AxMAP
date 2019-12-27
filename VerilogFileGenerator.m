function [ StoredTexts ] = VerilogFileGenerator( selectedAdders, LocalAddress )
    
    % FUNCTION DESCRIPTION: 
    
    % Step 1) Variable Initialization -------------------------------------
    NumOfExperiments = size(selectedAdders, 1);
    % Step 1) END ---------------------------------------------------------
    
    for i = 1 : NumOfExperiments
        if ~isempty(selectedAdders{i})
            
            %for j  = 1 : size(selectedAdders{i}, 1)

                AdderObject = selectedAdders{i}{2, 1};
                IDString    = ['SUBJECT_', int2str(i)];
                ItsMED      = selectedAdders{i}{2, 2};
                ItsPower    = selectedAdders{i}{2, 3}; 
                ItsArea     = selectedAdders{i}{2, 4};

                [VerilogCode, FileName] = ConvertAdderIntoVerilogForm(AdderObject, IDString, ItsMED, ItsPower, ItsArea);

                VerilogTextGenerator( VerilogCode, FileName, LocalAddress );

            %end
        end
        
    end
    StoredTexts = 'TRUE';
end

