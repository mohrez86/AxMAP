# AxMAP
AxMAP serves as a framework for illustrating the benefits of fast and input-aware error calculation in the efficiency of automatic circuit generation tools. The tool takes five input parameters. Power, area, and delay are considered as the designer's circuit budget constraints. The tolerable Mean Error Distance (MED) over a given pair of input patterns is regarded as the error constraint. AxMAP explores the design space and generates approximate adders using the random search algorithm. In each iteration, the selected design that satisfies the constraints is considered as a valid output. For more details, read our paper on AxMAP [[paper]](https://doi.org/10.1109/TC.2020.2968905).

# Setting up and using AxMAP

## Requirements
This code has been tested in MATLAB R2015b on a machine with a Corei5 2.5GHz processor and 8 GB of RAM with Windows 10 64-bit serving as the OS. However, using any versions of MATLAB higher than R2015b should be fine.

## Steps
1. Clone AxMAP:
```
git clone https://github.com/mohrez86/AxMAP
```
2. Open MATLAB, and change the current folder of MATLAB to the AxMAP repository, cloned on your machine.

3. In the MATLAB command window, type `edit AxMAP` to open the `AxMAP.m` in the MATLAB editor.

4. In the `AxMAP.m` file, go to line 14, and set the variable `LocalAddress` to the directory where you want to save the final Verilog files. For example:
```
LocalAddress = 'C:\VerilogDirectory\';
```

5. Save the changes made in step 4, and close the MATLAB editor.

6. In the MATLAB command window, type `AxMAP`, and press Enter. By running this script, the Verilog description of four adders are produced and stored in the directory saved in the variable `LocalAddress` (e.g., `C:\VerilogDirectory\`).

## Additional Information
AxMAP comprises several modules which are orchestrated by the `AxMAP.m` script. There are several variables that are initialized in line 6 to 14 of `AxMAP.m`:
```
NumOfDesiredDesigns = 4;
StepIteration       = 1000000;
BitWidth            = 8;
MED_Const           = 50;
POWER_Const         = 50;
AREA_Const          = 10;
InputPatternA       = ones(1, 8)/2;
InputPatternB       = ones(1, 8)/2;
LocalAddress        = 'F:\';
```

These variables are the parameters of AxMAP, which are explained as follows:
- `NumOfDesiredDesigns` indicates the number of adders AxMAP generates.
- `BitWidth` sets the bit-width of the adder circuits.
- `MED_Const` is a constraint that dictates the maximum amount of error allowed for a generated design, in terms of MED.
- `POWER_Const` is a constraint that dictates the maximum amount of dynamic power consumption allowed for a generated design.
- `AREA_Const` is a constraint that dictates the maximum amount of occupied silicon footprint allowed for a generated design.
- `InputPatternA` and `InputPatternB` are the input pattern of the first and the second inputs to each design.
