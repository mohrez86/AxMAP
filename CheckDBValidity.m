function [ IsValid ] = CheckDBValidity( DB_Entry )
    
    IsValid = 0;
    
    NumOfBlocks = size(DB_Entry, 2);
    BlockWidth  = size(DB_Entry{1}{1});
    
    errors = 0;
    
    for i = 1:NumOfBlocks
        for j = 1:BlockWidth
            if isempty(DB_Entry{1, i}{1, j})
                errors = errors + 1;
            end
        end
    end
    
    if errors == 0
        IsValid = true;
    end

end

