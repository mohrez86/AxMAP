function [simplifiedBooleanExpressionForm, simplifiedMatrixExpressionForm] = QuineMcCluskey(binaryTruthTable)
    
    [numberOfBooleanFunctions, ~] = size(binaryTruthTable);
    simplifiedBooleanExpressionForm = cell(numberOfBooleanFunctions, 1);
    simplifiedMatrixExpressionForm = cell(numberOfBooleanFunctions, 1);
      
    for i=1:numberOfBooleanFunctions
        
        %[simplifiedBooleanExpressionForm{i}, ~] = Petrick(binaryTruthTable{i});
        
        [~, simplifiedMatrixExpressionForm{i}] = Petrick(binaryTruthTable{i});
        
        ComprehensiveExprOBJ = BasicComprehensiveExpression(simplifiedMatrixExpressionForm{i});
        OPTComprehensiveExprOBJ = ComprehensiveExprOBJ.OptimizeThisCircuit;
        simplifiedBooleanExpressionForm{i} = OPTComprehensiveExprOBJ.CheckGateLevelDescription;
    end

end

