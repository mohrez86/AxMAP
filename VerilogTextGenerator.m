function VerilogTextGenerator( VerilogCode, FileName, LocalAddress )

    % FUNCTION DESCRIPTION
    
    fid = fopen([LocalAddress, FileName, '.v'], 'w');

    for i = 1 : size(VerilogCode, 1);
        fprintf(fid, '%s', VerilogCode{i}); 
        fprintf(fid, '%s\r\n', ' ');
    end

    fclose(fid);
    
end

