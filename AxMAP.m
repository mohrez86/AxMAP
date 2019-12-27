%% Algorithm
clear;
close all;
clc;

NumOfDesiredDesigns = 4;
StepIteration       = 1000000;
BitWidth            = 8;
MED_Const           = 50;
POWER_Const         = 50;
AREA_Const          = 10;
InputPatternA       = ones(1, 8)/2;
InputPatternB       = ones(1, 8)/2;
LocalAddress        = 'F:\';

% 1- initialize workspace library (Database)
standardWorkspaceLibrary = initializeWorkspaceLibrary;

% 2- Convert each row of the standardWorkspaceLibrary into an object of
    % BasicBuildingBlocks class
standardLogicLibrary = initializeLogicLibrary(standardWorkspaceLibrary);
%findMinimumMEDBlockIndex;

% 3- Classify the standard logic library
[ standardLogicLibrary_CinBar_CoBar, standardLogicLibrary_CinBar_Co, ...
standardLogicLibrary_Cin_CoBar, standardLogicLibrary_Cin_Co] = ...
classifyLogicLibrary( standardLogicLibrary );


% 4- Generate DataBase of 1 to 5-bit building blocks
[ DataBase ] = GenerateDataBase(standardLogicLibrary, ...
                                   standardLogicLibrary_CinBar_CoBar, ...
                                   standardLogicLibrary_CinBar_Co, ...
                                   standardLogicLibrary_Cin_CoBar, ...
                                   standardLogicLibrary_Cin_Co);

% 5- Generate a set of novel adders named "AdderSet"
[ AdderSet ] = GenerateAdderSet( DataBase, NumOfDesiredDesigns, StepIteration, ...
                                          BitWidth, MED_Const, POWER_Const, ...
                                          AREA_Const, InputPatternA, InputPatternB);
% 6- Generate Verilog HDL of "AdderSet"
VerilogFileGenerator( AdderSet, LocalAddress );
