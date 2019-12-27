function [ minimalBooleanExpression, minimalMatrixExpression ] = Petrick(binaryTruthTableVector)

%lgcExpr    return the simplist expression of a logic function
%   N: number of elements (<=10)
%   m: list of minterms 
%   d: list of don't care terms 

N = log2(length(binaryTruthTableVector));
jIndex = 1;

m = [];
for iIndex = 1:length(binaryTruthTableVector)
    if(binaryTruthTableVector(iIndex) == 1)
        m(jIndex) = iIndex - 1;
        jIndex = jIndex + 1;
    end
end
% Double Checked!

d = []; %comment this

if (max(max(m), max(d)) >= 2^N)
    disp('Error: N is too small!');
    return;
end
% Double Checked!

m = unique(sort(m));
d = unique(sort(d));
mLen = length(m);
dLen = length(d);

if mLen + dLen == 2^N,
	minimalBooleanExpression = '1';
    minimalMatrixExpression = ones(1, 2*N); % This line!!!
	return;
end
%d Double Checked!
if mLen + dLen == 0
    minimalBooleanExpression = '0';
    minimalMatrixExpression = zeros(1, 2*N);
    return;
end

% all k * N matrix except cmb_flg
binstr = [];
cmb_flg = zeros(mLen + dLen, 1);
nextbinstr = [];
final = [];

% initializing
bisntr1 = dec2bin(m, N);
binstr2 = dec2bin(d, N);
binstr = [bisntr1; binstr2];


% combining 
while 1,
    countnew = 0;
    Len = size(binstr, 1);
    for p = 1:(Len - 1),
        for q = (p + 1):Len,
            notEqual = (binstr(p,:) ~= binstr(q,:));
            if sum(notEqual) == 1,
                countnew = countnew + 1;
                cmb_flg(p) = 1;
                cmb_flg(q) = 1;
                tmp = binstr(p,:);
                tmp(notEqual) = '-';
                nextbinstr = [nextbinstr; tmp]; % may get repeated binstr
            end
        end
    end
    
    for k = 1:Len,
        if cmb_flg(k) == 0,
            final = [final; binstr(k,:)];
        end
    end
    
    if countnew == 0,
        break;
    end
    cmb_flg = zeros(countnew, 1);
    binstr = nextbinstr;
    binstr = unique(binstr, 'rows');    % eliminate repeated rows in time
    nextbinstr = [];
end
final = unique(final, 'rows');

% Petrick's Method 
% Forming the PI table----------------------
rslt = [];
rw = size(final, 1);
cl = mLen;
ptk = zeros(rw, cl);
for p = 1:cl,
    for q = 1:rw, 
        vec1 = dec2bin(m(p), N);
        vec2 = final(q, :);
        neq = (vec1 ~= vec2);
        tmp = unique(vec2(neq));
        if ((length(tmp) == 1) && (tmp(1) == '-')) || (isempty(tmp)),
            ptk(q, p) = 1;
        end
    end
end
% Check the output first

%dummy = 'Stop point';
ptk = ptk';
ptkCell = cell(size(ptk, 1)+1, size(ptk, 2)+1);

for i=1:size(ptk, 1)
    for j=1:size(ptk, 2)
        ptkCell{i+1, j+1} = ptk(i,j);
    end
end

ptkCell{1, 1} = 'Minterms - PIs';

% Writing the minterms in all rows of the Prime Implicant Table
for i=2:size(ptkCell, 1)
    ptkCell{i,1} = m(i-1);
end

% Writing the PIs in all columns of the Prime Implicant Table
for j=2:size(ptkCell, 2)
    ptkCell{1, j} = final(j-1, :);
end

PIs = [];
for i=1:size(final, 1)
    PIs = [PIs; final(i, :)];
end

%--------------------------------------------------------------------------
% Now the Prime Implicant Table is ready
% We must perform a 3 Step operation
% 1- First, we remove EPI columns and their covered minterm rows from the table 
% 2- Second, we remove the row dominating Rows from the table 
% 3- Third, we remove the column dominated Columns from the table 
% we perform step 1 to 3, until the table is either empty or there are rows
    % and columns suitable for removing
% All the removed PIs are stored in the result[]

    % 1st Step: Reducing the table---------------------------------------------
    
    result = [];
    ptkOld = [];
    tempFinal = final;
while ( ~isequal(ptk, ptkOld))
    ptkOld = ptk;
    % finding and storing the EPIs into result
    listOfEPIIndexes = [];
    for i=1:size(ptk, 1)
        if (sum(ptk(i, :)) == 1) % if true, then the PI covering this minterm is EPI
            EPIIndex = find(ptk(i, :));
            result = [result; PIs(EPIIndex, :)];
            listOfEPIIndexes = [listOfEPIIndexes, EPIIndex];
        end
    end

    listOfEPIIndexes = sort(unique(listOfEPIIndexes));

    % removing the EPIs from ptk if it is not empty
    if (~isempty(listOfEPIIndexes))
        
        for j=1:size(listOfEPIIndexes, 2)
            coveredMintermsIndexes = find(ptk(:, listOfEPIIndexes(j)));    

            for i=1:size(coveredMintermsIndexes, 1)
                ptk(coveredMintermsIndexes(i), :) = [];
                
                coveredMintermsIndexes = [coveredMintermsIndexes(1:i); coveredMintermsIndexes(i+1:end)-1];
            end

            ptk(:, listOfEPIIndexes(j)) = [];
            % Removing its corresponding entry  from PI Table 
            
            if ( ~isempty(PIs) )
                PIs(listOfEPIIndexes(j), :) = [];
            end
            
            listOfEPIIndexes = [listOfEPIIndexes(1:j), listOfEPIIndexes(j+1:end)-1];
        end
        
    end
    
    if (isempty(ptk))
        break;
    end
    %--------------------------------------------------------------------------
    
    % If ptk is not empty, proceed
    
    % 2nd Step: Row Dominance--------------------------------------------------
        % Finding dominating rows
        
    listOfDominatingRows = [];

    for i=1:size(ptk, 1)
        for j=i+1:size(ptk, 1)

            if (dominatingRowIdentifier(ptk(i, :), ptk(j, :)) == 0 )
                continue;
            elseif (dominatingRowIdentifier(ptk(i, :), ptk(j, :)) == 1 )
                listOfDominatingRows = [listOfDominatingRows, i];
            elseif (dominatingRowIdentifier(ptk(i, :), ptk(j, :)) == 2 )
                listOfDominatingRows = [listOfDominatingRows, j];
            end

        end
    end
    
    listOfDominatingRows = sort(unique(listOfDominatingRows));
    tempListOfDominatingRows = listOfDominatingRows;
    
        % Removing dominating rows if its list is not empty
    if (~isempty(listOfDominatingRows))
        
        for i=1:size(listOfDominatingRows, 2)
            ptk(tempListOfDominatingRows(i), :) = [];
            tempListOfDominatingRows = [tempListOfDominatingRows(1:i), tempListOfDominatingRows(i+1:end)-1];
        end
        
    end
    %--------------------------------------------------------------------------
    % 3rd Step: Column Dominance-----------------------------------------------
        % Finding dominated columns
        
    listOfDominatedColumns = [];
    
    for i=1:size(ptk, 2)
        for j=i+1:size(ptk, 2)

            if ( dominatedColumnIdentifier(ptk(:, i), ptk(:, j))  == 0 )
                continue;
            elseif ( dominatedColumnIdentifier(ptk(:, i), ptk(:, j))  == 1 )
                listOfDominatedColumns = [listOfDominatedColumns, i];
            elseif ( dominatedColumnIdentifier(ptk(:, i), ptk(:, j)) == 2 )
                listOfDominatedColumns = [listOfDominatedColumns, j];
            end

        end
    end
    listOfDominatedColumns = sort(unique(listOfDominatedColumns));
    tempListOfDominatedColumns = listOfDominatedColumns;
        
        % Removing dominated columns if its list is not empty
    if(~isempty(listOfDominatedColumns))
        
        for j=1:size(listOfDominatedColumns, 2)
            ptk(:, tempListOfDominatedColumns(j)) = [];
            % Removing its corresponding entry  from the PI Table
            
            
            if ( ~isempty(PIs) )
                PIs(tempListOfDominatedColumns(j), :) = [];
            end
            
            tempListOfDominatedColumns = [tempListOfDominatedColumns(1:j), tempListOfDominatedColumns(j+1:end)-1];
        end
        
    end
    
    
end
%--------------------------------------------------------------------------
% 4- Solving the table
% Petrick's Method for minimization

% We need PIs array and ptk matrix to solve the table

% first we mark each PI as Pi

    PIsCell = cell(size(PIs,1), 2);

    for i=1:size(PIs, 1)

        PIsCell{i, 1} = PIs(i, :);
        PIsCell{i, 2} = ['P', num2str(i)];
    end



    if(~isempty(ptk))
        minimalExpression =  formCoveringPIs( ptk(1, :) );

        for i=2:size(ptk, 1)
            minimalExpression = minimalSolution(minimalExpression, formCoveringPIs(ptk(i, :)) );
        end
    end

%--------------------------------------------------------------------------

% Finding the minimal Boolean Expression using result and minimalExpression

%INPUTS
    %minimalExpression (Matrix)
    %PIs (Vertical Array)
    %result (Vertical Array)

%OUTPUT
    %minimalBooleanEquation
if(~isempty(ptk))
    
    minimalBooleanEquation = findMinimalBooleanEquation(minimalExpression, PIs);
%--------------------------------------------------------------------------
    for j=1:size(minimalBooleanEquation, 2)
        if( isequal(minimalBooleanEquation(1, j), 1) )
            result = [result; PIs(j, :)];
        end
    end
    
%--------------------------------------------------------------------------

end
%--------------------------------------------------------------------------
    result = unique(result, 'rows');
% Create algebraic boolean equations from the result
    % N is the number of vaiables aka maximum number of required alphabets
    Symbols = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 
    minimalBooleanExpression = [];
    
% minimal Expression in matrix form. This output is used for estimating
    % power and area and other electrical parameters
    minimalMatrixExpression = zeros(size(result, 1) , 2*N);

    for i=1:size(result, 1)
        for j=1:size(result, 2) % Or j=1:N
            
            if( isequal(result(i, j), '1') )
                minimalBooleanExpression = [minimalBooleanExpression, Symbols(1, j)];
                
                Index = ((j-1)*2) +1;
                minimalMatrixExpression(i, Index) = 1;
                
            elseif ( isequal(result(i, j), '0') )
                minimalBooleanExpression = [minimalBooleanExpression, Symbols(1, j), ''''];
                
                Index = ((j-1)*2) +2;
                minimalMatrixExpression(i, Index) = 1;
                
            end
            
        end
        
        if ( ~isequal(i, size(result, 1)) )
            minimalBooleanExpression = [minimalBooleanExpression, '+'];
        end
        
    end

    
    
    
    
    
    
%--------------------------------------------------------------------------
%---------------------------------THE END----------------------------------
end

