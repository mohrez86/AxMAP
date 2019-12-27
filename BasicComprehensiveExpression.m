classdef BasicComprehensiveExpression
    
    properties
        
        NumOfInputs;
        Hierarchy;     % 'Yes' or 'No'
        
        ListOfPrimaryInputs = nan(1, 6); %[A, A', B, B', C, C']
        NumOfPrimaryInputs;
        
        GateName;      % AND, OR, XOR, NAND, NOR, XNOR
        
        NumOfNonPrimaryInputs;
        Architecure;   % a list of BasicComprehensiveExpression Objects
        
        
        
        GatePower;
        GateArea;
        
        GateLevelDescription;
        
    end
    
    methods
        %============================= Constructor ========================
        % 1- Constructor
        function obj = BasicComprehensiveExpression(minimalMatrixExpression, varargin)
            
            if nargin == 1
                obj.Hierarchy = CheckHierarchy(obj, minimalMatrixExpression);
                obj.ListOfPrimaryInputs = CheckListOfPrimaryInputs(obj, minimalMatrixExpression);
                obj.GateName = CheckGateName(obj, minimalMatrixExpression);
                obj.NumOfInputs = CheckNumOfInputs(obj);
                obj.NumOfPrimaryInputs = CheckNumOfPrimaryInputs(obj);
                obj.NumOfNonPrimaryInputs = CheckNumOfNonPrimaryInputs(obj);
                obj.Architecure = CheckArchitecure(obj, minimalMatrixExpression);
                [obj.GatePower, obj.GateArea] = CheckPowerAndArea(obj);
                %obj = OptimizeThisCircuit(obj);
                %obj.GateLevelDescription = CheckGateLevelDescription(obj);
            elseif nargin == 2
                % Use "varargin{1}", instead of "minimalMatrixExpression", to construct the object you need!
                % Create an empty Object
                obj.Hierarchy = 0;
                obj.ListOfPrimaryInputs = 0;
                obj.GateName = 0;
                obj.NumOfInputs = 0;
                obj.NumOfPrimaryInputs = 0;
                obj.NumOfNonPrimaryInputs = 0;
                obj.Architecure = 0;
                obj.GatePower = 0;
                obj.GateArea = 0;
            end
        end % 1- Constructor END
        %==================================================================
        
        %========================== Check Hierarchy =======================
        % 2- Check Hierarchy
        function [IsHierarchical] = CheckHierarchy(obj, minimalMatrixExpression)
            
            IsHierarchical = 'No';
            
            if ( size(minimalMatrixExpression, 1) == 1 )
                IsHierarchical = 'No';
                return;
            else
                for i = 1 : size(minimalMatrixExpression, 1)
                    if ( sum(minimalMatrixExpression(i, :)) > 1 )
                        IsHierarchical = 'Yes';
                        return;
                    end
                end
            end

        end % 2- Check Hierarchy END
        %==================================================================
        
        %====================== CheckListOfPrimaryInputs ==================
        % 3- CheckListOfPrimaryInputs
        function PrimaryInputs = CheckListOfPrimaryInputs(obj, minimalMatrixExpression)
            PrimaryInputs = nan(1, 6);
            
            if isequal(obj.Hierarchy, 'No')
                if sum(minimalMatrixExpression(1, :)) == 0
                    return;
                end
                if sum(minimalMatrixExpression(1, :)) == 6
                    return;
                end
            end
            
            if isequal(obj.Hierarchy, 'No')
                
                for i = 1 : size(minimalMatrixExpression, 1)
                    for j = 1 : size(minimalMatrixExpression, 2)
                        if (minimalMatrixExpression(i, j) == 1)
                            PrimaryInputs(j) = 1;
                        end
                    end
                end
                
            else % obj.Hierarchy == 'Yes'
                
                for i = 1 : size(minimalMatrixExpression, 1)
                    if ( sum(minimalMatrixExpression(i, :)) == 1 )
                        
                        for j = 1 : size(minimalMatrixExpression, 2)
                            if (minimalMatrixExpression(i, j) == 1)
                                PrimaryInputs(j) = 1;
                            end
                        end
                        
                    end
                end
                
            end
            
        end % 3- CheckListOfPrimaryInputs END
        %==================================================================
        
        %==================================================================
        % 4- CheckGateName
        function Name = CheckGateName(obj, minimalMatrixExpression)
            % It's either an OR gate or an AND Gate
            
            Name = cell(1, 2);
            
            if isequal(obj.Hierarchy, 'No')
                if sum(minimalMatrixExpression(1, :)) == 0
                    Name{1} = 'LOGIC0';
                    Name{2} = uint8(0);
                    return;
                end
                if sum(minimalMatrixExpression(1, :)) == 6
                    Name{1} = 'LOGIC1';
                    Name{2} = uint8(0);
                    return;
                end
            end
            
            if isequal(obj.Hierarchy, 'No') 
                
                if ( size(minimalMatrixExpression, 1) == 1 ) % either AND or Buffer
                    
                    if ( sum(minimalMatrixExpression(1, :)) == 1 )
                        Name{1} = 'BUF';
                        Name{2} = uint8(1);
                    else
                        Name{1} = 'AND';
                        Name{2} = uint8( sum(minimalMatrixExpression(1, :)) );
                    end
                    
                else % More than one row => Then it is an OR gate, definately
                    
                    Name{1} = 'OR';
                    Name{2} = uint8( size(minimalMatrixExpression, 1) );
                    
                end
          
            else % Hierarchy == 'Yes'
                
                Name{1} = 'OR';
                Name{2} = size(minimalMatrixExpression, 1);
                
            end
            
        end % 4- CheckGateName END
        %==================================================================
        
        %======================== NumOfPrimaryInputs ======================
        % 5- NumOfPrimaryInputs
        function NumberOfPrimaryInputs = CheckNumOfPrimaryInputs(obj)
            
            NumberOfPrimaryInputs = 0;
            for i = 1 : 6
                
                if (obj.ListOfPrimaryInputs(i) == 1)
                    NumberOfPrimaryInputs = NumberOfPrimaryInputs + 1;
                end
                
            end
            
        end % 5- NumOfPrimaryInputs END
        %==================================================================
        
        %===================== CheckNumOfNonPrimaryInputs =================
        function NumberOfNonPrimaryInputs = CheckNumOfNonPrimaryInputs(obj)
            NumberOfNonPrimaryInputs = obj.NumOfInputs - obj.NumOfPrimaryInputs;
        end
        %==================================================================
        
        %========================== CheckArchitecure ======================
        % 6- CheckArchitecure
        function Arch = CheckArchitecure(obj, minimalMatrixExpression)
            
            Arch = cell(1, obj.NumOfNonPrimaryInputs);
            j = 1;
            
            if ( isequal(obj.Hierarchy, 'No') )
                return;
            
            else
            
                for i = 1 : size(minimalMatrixExpression, 1)
                    if ( sum(minimalMatrixExpression(i, :)) > 1 )
                        Arch{1, j} = BasicComprehensiveExpression(minimalMatrixExpression(i, :));
                        j = j + 1;
                    end
                end
                
            end
        end % 6 - CheckArchitecure END
        %==================================================================
        
        %=========================== CheckNumOfInputs =====================
        % 7- CheckNumOfInputs
        function NumberOfInputs = CheckNumOfInputs(obj)
            
            NumberOfInputs = obj.GateName{2};
            
        end
        %==================================================================
        
        %==================================================================
        % 8- CheckPower&Area
        function [WholePower, WholeArea] = CheckPowerAndArea(obj)
            nanGateLibrary = loadNanGateOpenCellLibrary_Typical;
            
            WholePower = 0;
            WholeArea  = 0;
            
            ThisGatePower = 0;
            ThisGateArea  = 0;
            
            MyArchPower = 0;
            MyArchArea  = 0;
            
            ThisNumOfNot= 0;
            
            ThisGateName = [obj.GateName{1}, int2str(obj.GateName{2}), '_X1' ];
                
                % find my gate in "nanGateLibrary" and its power and area
                for i = 1 : size(nanGateLibrary, 1)
                    if isequal(ThisGateName, nanGateLibrary{i, 1})
                        ThisGatePower = nanGateLibrary{i, 2};
                        ThisGateArea  = nanGateLibrary{i, 4};
                        break;
                    end
                end
                
                % find how many "INV" do I have in my primaryInputs and add their power and area too
                for i = 1 : size(obj.ListOfPrimaryInputs, 2)
                    if ( (obj.ListOfPrimaryInputs(i) == 1) ) 
                        if ( mod(i, 2) == 0 )
                        ThisNumOfNot = ThisNumOfNot + 1;
                        end
                    end
                end
                
                ThisGatePower = ThisGatePower + ThisNumOfNot * nanGateLibrary{4, 2};
                ThisGateArea  = ThisGateArea  + ThisNumOfNot * nanGateLibrary{4, 4};
                
            if isequal(obj.Hierarchy, 'No')
                
                WholePower = ThisGatePower;
                WholeArea  = ThisGateArea ;
                
            else % Hierarchy == 'Yes'
                
                %WholePower = ThisGatePower + MyArchPower;
                %WholeArea  = ThisGateArea  + MyArchArea;
                
                for i = 1 : size(obj.Architecure, 2)
                    MyArchPower = MyArchPower + obj.Architecure{i}.GatePower;
                    MyArchArea  = MyArchArea  + obj.Architecure{i}.GateArea ;
                end
                
                WholePower = ThisGatePower + MyArchPower;
                WholeArea  = ThisGateArea  + MyArchArea;
            end
        end
        %==================================================================
        
        %=========================== OptimizeThisCircuit ==================
        % X- OptimizeThisCircuit
        function OptimizedObj = OptimizeThisCircuit(obj)
            % OptimizedObj is an Object of "BasicComprehensiveExpression"
            % Here we should Optimize the current Object "obj" and store it in "Optimizedobj"
            
            % Create an Empty Object
%             OptObj = BasicComprehensiveExpression(0, 0);
            OptXORChild = BasicComprehensiveExpression(0, 0);
%             OptNANDChild = BasicComprehensiveExpression(0, 0);
            
            % Optimized Parameters
%             OptNumOfInputs;
%             OptHierarchy;
%             OptListOfPrimaryInputs;
%             OptNumOfPrimaryInputs;
%             OptGateName;
%             OptNumOfNonPrimaryInputs;
            OptArchitecture = 'NULL';
%             OptGatePower;
%             OptGateArea;
            
            RemovedObjetsIndexes = zeros(1, size(obj.Architecure, 2));
            % 1) XOR/XNOR 
            % 1.1) First we should check the XOR condition
            if ( (isequal(obj.Hierarchy, 'Yes')) &&  (size(obj.Architecure, 2)>1) )
                    
                for i = 1 : size(obj.Architecure, 2)-1
                        for j = i+1 : size(obj.Architecure, 2)
                            [Flag, GateType, ListOfInputs] = CheckXORCondition ...
                            (obj.Architecure{i}, obj.Architecure{j});
                            
                            if Flag == true
                                RemovedObjetsIndexes(i) = 1;
                                RemovedObjetsIndexes(j) = 1;
                                
                                % Create the Optimized Child
                                % Put it into obj.Architecture
                                
                                OptXORChild.Hierarchy = 'No';
                                OptXORChild.ListOfPrimaryInputs = ListOfInputs;
                                OptXORChild.GateName = GateType;
                                
                                OptXORChild.NumOfInputs = GateType{2};
                                OptXORChild.NumOfPrimaryInputs = GateType{2};
                                OptXORChild.NumOfNonPrimaryInputs = 0;
                                OptXORChild.Architecure = cell(1, 0);
                                OptXORChild.GatePower = 6.6200;
                                OptXORChild.GateArea = 1.5960;
                                
                                OptArchitecture = OptXORChild;
                                
                                break; % Since there's only ONE XOR/XNOR available
                            end

                        end
                end
                
                % 1.2) Replace the XOR with two AND gates
                if ~(isequal(OptArchitecture, 'NULL'))
                    newArch = cell(1, size(obj.Architecure, 2)-1);
                    newArch{1} = OptXORChild;
                    j = 2;
                    for i = 1 : size(obj.Architecure, 2)
                        if RemovedObjetsIndexes(i) == 0
                            newArch{j} = obj.Architecure{i};
                            j = j + 1;
                        end
                    end
                    
                    % Modify the Current Object
                    obj.Architecure = newArch;
                    obj.NumOfNonPrimaryInputs = obj.NumOfNonPrimaryInputs - 1;
                    obj.NumOfInputs = obj.NumOfInputs - 1;
                    if obj.NumOfInputs == 1
                        obj.GateName{1} = 'BUF';
                        obj.GateName{2} = uint8(1);
                    else
                        obj.GateName{2} = obj.GateName{2} - 1;
                    end
                    [obj.GatePower, obj.GateArea] = CheckPowerAndArea(obj);
                    
                end
                
                
            end
            
            
            
            % 2) NAND/NOR
            
            if ~isequal(obj.GateName{1}, 'BUF')
                
                % If obj.NumOfPrimaryInputs with no NOT > NumOfGates + NumOfPrimaryInputs with Not
                % Then Do nothing Other Wise 
                % Invert this gate and all its child gates and all its Primary Inputs
                
                NumOfPrimaryInputsWithNoNOT = 0;
                NumOfGates = 0;
                NumOfPrimaryInputsWithNOT = 0;
                
                % Find Num of Primary Inputs With No NOT
                % Find Num of Primary Inputs With NOT
                for i = 1 : size(obj.ListOfPrimaryInputs, 2)
                    if ( (obj.ListOfPrimaryInputs(i) == 1) ) 
                        if     ( mod(i, 2) == 1 )
                            NumOfPrimaryInputsWithNoNOT = NumOfPrimaryInputsWithNoNOT + 1;
                        elseif ( mod(i, 2) == 0 )
                            NumOfPrimaryInputsWithNOT = NumOfPrimaryInputsWithNOT + 1;
                        end
                    end
                end
                
                % Find Num Of Gates 
                if isequal(obj.Hierarchy, 'No')
                    NumOfGates = 0;
                else
                    NumOfGates =  size(obj.Architecure, 2);
                end
                
                if NumOfPrimaryInputsWithNoNOT < (NumOfGates + NumOfPrimaryInputsWithNOT)
                    % DUAL THIS GATE, INVERT ALL CHILD GATES AND ALL PRIMARY INPUTS
                    % 1) Dual This Gate
                    if     isequal (obj.GateName{1}, 'AND')
                        obj.GateName{1} = 'NOR';
                    elseif isequal (obj.GateName{1}, 'OR')
                        obj.GateName{1} = 'NAND';
                    elseif isequal (obj.GateName{1}, 'XOR')
                        obj.GateName{1} = 'XNOR';
                    elseif isequal (obj.GateName{1}, 'NAND')
                        obj.GateName{1} = 'OR';
                    elseif isequal (obj.GateName{1}, 'NOR')
                        obj.GateName{1} = 'AND';
                    elseif isequal (obj.GateName{1}, 'XNOR')
                        obj.GateName{1} = 'XOR';
                    end
                    
                    % INVERT ALL CHILD GATES
                    if isequal(obj.Hierarchy, 'Yes')
                        for i = 1 : size(obj.Architecure, 2)
                            if     isequal(obj.Architecure{i}.GateName{1}, 'AND')
                                obj.Architecure{i}.GateName{1} = 'NAND';
                            elseif isequal(obj.Architecure{i}.GateName{1}, 'OR')
                                obj.Architecure{i}.GateName{1} = 'NOR';
                            elseif isequal(obj.Architecure{i}.GateName{1}, 'XOR')
                                obj.Architecure{i}.GateName{1} = 'XNOR';
                            elseif isequal(obj.Architecure{i}.GateName{1}, 'NAND')
                                obj.Architecure{i}.GateName{1} = 'AND';
                            elseif isequal(obj.Architecure{i}.GateName{1}, 'NOR')
                                obj.Architecure{i}.GateName{1} = 'OR';
                            elseif isequal(obj.Architecure{i}.GateName{1}, 'XNOR')
                                obj.Architecure{i}.GateName{1} = 'XOR';
                            end
                        end
                    end
                    
                    % INVERT ALL PRIMARY INPUTS
                    for i = 1 : 2 : size(obj.ListOfPrimaryInputs, 2)
                        
                        if     (obj.ListOfPrimaryInputs(i) == 1)
                            
                            obj.ListOfPrimaryInputs(i+1) = 1;
                            obj.ListOfPrimaryInputs(i)   = NaN;
                            
                        elseif (obj.ListOfPrimaryInputs(i+1) == 1)
                            
                            obj.ListOfPrimaryInputs(i) = 1;
                            obj.ListOfPrimaryInputs(i+1) = NaN;
                            
                        end
                        
                    end
                    
                    
                end
                
                [obj.GatePower, obj.GateArea] = CheckPowerAndArea(obj);
                
            end
            
            for i = 1 : size(obj.Architecure, 2)
                [obj.Architecure{i}.GatePower, obj.Architecure{i}.GateArea] = ... 
                obj.Architecure{i}.CheckPowerAndArea();
            end
            [obj.GatePower, obj.GateArea] = CheckPowerAndArea(obj);
            OptimizedObj = obj;
            
        end % X- OptimizeThisCircuit
        %==================================================================
        
        %==================================================================
        % 10- CheckGateLevelDescription
        function GateLevelHDL = CheckGateLevelDescription(obj)
            
            Symbols = 'ABC';
            
            if     isequal(obj.GateName{1}, 'LOGIC0')
                GateLevelHDL = '1''b0';
                return;
            elseif isequal(obj.GateName{1}, 'LOGIC1')
                GateLevelHDL = '1''b1';
                return;
            end
            
            GateLevelHDL = cell(1, obj.GateName{2} + obj.GateName{2}-1);
            
            j = 1;
            
            for i = 2 : 2 : size(GateLevelHDL, 2)
                
                if      isequal(obj.GateName{1}, 'AND')
                    GateLevelHDL{i} = '&';
                elseif  isequal(obj.GateName{1}, 'OR')
                    GateLevelHDL{i} = '|';
                elseif  isequal(obj.GateName{1}, 'XOR')
                    GateLevelHDL{i} = '^';
                elseif  isequal(obj.GateName{1}, 'NAND')
                    GateLevelHDL{i} = '~&';
                elseif  isequal(obj.GateName{1}, 'NOR')
                    GateLevelHDL{i} = '~|';
                elseif  isequal(obj.GateName{1}, 'XNOR')
                    GateLevelHDL{i} = '~^';
                end
                
            end
            
            
            
            if isequal(obj.Hierarchy, 'Yes')
                
                
                % For Both Primary and Non-Primary Inputs
                % 1- Primary Inputs
                for i = 1 : size(obj.ListOfPrimaryInputs, 2)
                    
                    if obj.ListOfPrimaryInputs(i) == 1
                        GateLevelHDL{j} = '(';
                        if     ceil(i/2) == 1
                            if     ( mod(i, 2) == 1 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, 'A'];
                            elseif ( mod(i, 2) == 0 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, '~A'];
                            end
                        elseif ceil(i/2) == 2
                            if     ( mod(i, 2) == 1 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, 'B'];
                            elseif ( mod(i, 2) == 0 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, '~B'];
                            end
                        elseif ceil(i/2) == 3
                            if     ( mod(i, 2) == 1 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, 'C'];
                            elseif ( mod(i, 2) == 0 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, '~C'];
                            end
                        end
                        GateLevelHDL{j} = [GateLevelHDL{j}, ')'];
                        j = j + 2;
                    end
                    
                end
                
                
                % 2- Non-Primary Inputs
                for i = 1 : size(obj.Architecure, 2)
                    
                    
                    
                    GateLevelHDL{j} = '(';
                    
                    CurrentChildGateLevelHDL = ... 
                    cell(1, obj.Architecure{i}.GateName{2} + ...
                            obj.Architecure{i}.GateName{2}-1);
                        
                    h = 1;
                    
                    for k = 2 : 2 : size(CurrentChildGateLevelHDL, 2)
                        if      isequal(obj.Architecure{i}.GateName{1}, 'AND')
                            CurrentChildGateLevelHDL{k} = '&';
                        elseif  isequal(obj.Architecure{i}.GateName{1}, 'OR')
                            CurrentChildGateLevelHDL{k} = '|';
                        elseif  isequal(obj.Architecure{i}.GateName{1}, 'XOR')
                            CurrentChildGateLevelHDL{k} = '^';
                        elseif  isequal(obj.Architecure{i}.GateName{1}, 'NAND')
                            CurrentChildGateLevelHDL{k} = '~&';
                        elseif  isequal(obj.Architecure{i}.GateName{1}, 'NOR')
                            CurrentChildGateLevelHDL{k} = '~|';
                        elseif  isequal(obj.Architecure{i}.GateName{1}, 'XNOR')
                            CurrentChildGateLevelHDL{k} = '~^';
                        end
                    end
                        
                    for k = 1 : size(obj.Architecure{i}.ListOfPrimaryInputs, 2)
                        
                       
                       if obj.Architecure{i}.ListOfPrimaryInputs(k) == 1
                            CurrentChildGateLevelHDL{h} = '(';
                            if     ceil(k/2) == 1
                                if     ( mod(k, 2) == 1 )
                                    CurrentChildGateLevelHDL{h} = [CurrentChildGateLevelHDL{h}, 'A'];
                                elseif ( mod(k, 2) == 0 )
                                    CurrentChildGateLevelHDL{h} = [CurrentChildGateLevelHDL{h}, '~A'];
                                end
                            elseif ceil(k/2) == 2
                                if     ( mod(k, 2) == 1 )
                                    CurrentChildGateLevelHDL{h} = [CurrentChildGateLevelHDL{h}, 'B'];
                                elseif ( mod(k, 2) == 0 )
                                    CurrentChildGateLevelHDL{h} = [CurrentChildGateLevelHDL{h}, '~B'];
                                end
                            elseif ceil(k/2) == 3
                                if     ( mod(k, 2) == 1 )
                                    CurrentChildGateLevelHDL{h} = [CurrentChildGateLevelHDL{h}, 'C'];
                                elseif ( mod(k, 2) == 0 )
                                    CurrentChildGateLevelHDL{h} = [CurrentChildGateLevelHDL{h}, '~C'];
                                end
                            end
                            CurrentChildGateLevelHDL{h} = [CurrentChildGateLevelHDL{h}, ')'];
                            
                            h = h + 2;
                            
                        end
                        
                    end
                    GateLevelHDL{j} = [GateLevelHDL{j}, CurrentChildGateLevelHDL];
                    GateLevelHDL{j} = [GateLevelHDL{j}, ')'];
                    j = j + 2;
                end
                
                
            
            else % Hierarchy == 'No'
                
                % Only for Primary Inputs
                j = 1;
                for i = 1 : size(obj.ListOfPrimaryInputs, 2)
                    
                    if obj.ListOfPrimaryInputs(i) == 1
                        
                        GateLevelHDL{j} = '(';
                        
                        if     ceil(i/2) == 1
                            if     ( mod(i, 2) == 1 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, 'A'];
                            elseif ( mod(i, 2) == 0 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, '~A'];
                            end
                        elseif ceil(i/2) == 2
                            if     ( mod(i, 2) == 1 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, 'B'];
                            elseif ( mod(i, 2) == 0 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, '~B'];
                            end
                        elseif ceil(i/2) == 3
                            if     ( mod(i, 2) == 1 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, 'C'];
                            elseif ( mod(i, 2) == 0 )
                                GateLevelHDL{j} = [GateLevelHDL{j}, '~C'];
                            end
                        end
                        
                        GateLevelHDL{j} = [GateLevelHDL{j}, ')'];
                        
                        j = j + 2;
                        
                    end
                    
                    
                    
                end
                
            end
            
            TempGateLevelHDL = [];
            
            for i = 1 :  size(GateLevelHDL, 2)
                
                if      isequal(class(GateLevelHDL{i}), 'char')
                    TempGateLevelHDL = [TempGateLevelHDL, ' ', GateLevelHDL{i}];
                    
                elseif  isequal(class(GateLevelHDL{i}), 'cell')
                    
                    for j = 1 : size(GateLevelHDL{i}, 2)
                        
                        TempGateLevelHDL = [TempGateLevelHDL, ' ', GateLevelHDL{i}{j}];
                        
                    end
                    
                end
                
            end
            
            GateLevelHDL = TempGateLevelHDL;
            
        end
        %==================================================================
        
    end % END of METHODS
    
end

