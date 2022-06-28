# Build Steps for CMSIS-NN Library
To generate and run C code for deep neural networks on Cortex&reg;-M hardware, you must have the CMSIS-NN (Cortex Microcontroller Software Interface Standard - Neural Networks) library. The following describes the build steps for CMSIS-NN on Windows&reg; and Linux&reg; platforms that use a cross-compiler toolchain.

## Requirements 

### Makefile
To build the CMSIS-NN static library, you must first create a Makefile. Create a copy of the `Makefile.mk` file in this repository and save it to your computer. **To avoid errors during code generation, you must supply the appropriate CFLAGS variable for your target hardware.** The Makefile shared here includes several CFLAGS variables pre-validated for popular Cortex-M development boards supported by MATLAB&reg;.

For example, for an STM32F746G-Discovery board, define `CFLAGS` in the Makefile as:

```
CFLAGS = -fPIC -c -mcpu=cortex-m7 -Ofast -DNDEBUG -mfloat-abi=hard -mfpu=fpv5-sp-d16
```
If you do not see your hardware target listed, you must create a custom CFLAGS variable with the necessary `-mcpu`, `-mfloat-abi`, and `-mfpu` flags.

### Toolchain
We recommend using the same toolchain for building your MATLAB-based application and the CMSIS-NN library. We have validated the CMSIS-NN library build processes below using the following toolchains:
* Linux platforms: GNU ARM&reg; Embedded Toolchain version 8.3.0
* Windows platforms: GNU ARM&reg; Embedded Toolchain version 10.3.1


## Linux Install Steps
1. Install the open-source, AArch32 bare-metal target (arm-eabi) GNU Arm Embedded Toolchain (v8.3.0) provided by ARM (https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a/downloads/8-3-2019-03).
2. Download the source code for CMSIS version 5.7.0 (available at https://github.com/ARM-software/CMSIS_5/archive/refs/tags/5.7.0.zip).
3. Unzip the CMSIS source code to a folder and follow these steps to build and generate the static library:
     * Open a Linux terminal.
     * Change directory to the CMSIS-NN source folder by running the below command. Here, ```<CMSIS Root folder>``` refers to the extracted CMSIS folder.
     ```
     cd <CMSIS Root folder>/CMSIS/NN
     ```
     * Copy your `Makefile.mk` file to the current directory (```<CMSIS Root folder>/CMSIS/NN```). Ensure the `CFLAGS` variable is correctly defined for your hardware target in the Makefile.
     * At the terminal, run the makefile by using the `make` command:
     ```
     make -f Makefile.mk
     ```
     * Running the makefile creates the static library `libcmsisnn.a` in the ```<CMSIS Root folder>/CMSIS/NN/lib``` folder.
4. Configure the MATLAB environment to generate code that uses the CMSIS-NN library:
     * At `/usr/local/`, create a folder named `cmsisnn`.
     * Copy the header files located at ```<CMSIS Root folder>/CMSIS/DSP/Include``` and ```<CMSIS Root folder>/CMSIS/NN/Include``` to the location `/usr/local/cmsisnn/include`.
     * Copy the generated static library located at ```<CMSIS Root folder>/CMSIS/NN/Include``` to the location `/usr/local/cmsisnn/lib`.
     * Open a Linux terminal and use the below command to create a `CMSISNN_PATH` environment variable:
     ```
     export CMSISNN_PATH=/usr/local/cmsisnn
     ```
    
## Windows Install Steps
1. Install the open-source GNU Arm Embedded Toolchain provided by ARM (available at https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-win32.exe).
2. Download and install the `make` tool. We have tested this step with Cygwin (available at https://www.cygwin.com/install.html). Within the Cygwin installer, during package selection, find the `make` package under "Devel". Open the dropdown list and replace the default selection "Skip" with the version number of `make` to install. Finish the installation process.
3. Download the source code for CMSIS version 5.7.0 (available at https://github.com/ARM-software/CMSIS_5/archive/refs/tags/5.7.0.zip).
4. Unzip the source code to a folder, and follow these steps to build and generate the static library: 
     * Open a Windows command prompt.
     * Change directory to the CMSIS-NN source folder by running the below command. Here, ```<CMSIS Root folder>``` refers to the location where the CMSIS folder was extacted.
     ```
     cd <CMSIS Root folder>\CMSIS\NN 
     ```
     * Copy your `Makefile.mk` file to the current directory (```<CMSIS Root folder>\CMSIS\NN```). Ensure the `CFLAGS` variable is correctly defined for your hardware target in the Makefile.
     * At the command prompt, run the Makefile with the `make` command:
     ```
     make -f Makefile.mk
     ```
     * Running the Makefile creates the static library `libcmsisnn.a` in the ```<CMSIS Root folder>\CMSIS\NN\lib``` folder.
5. Configure the MATLAB environment to generate code that uses the CMSIS-NN library:
     * Create a folder named `cmsisnn` in an arbitrary location. Ensure the file path does not include any space. For example, we validated the following steps with the file path `C:\cmsisnn`. 
     * Copy the header files located at ```<CMSIS Root folder>\CMSIS\DSP\Include``` and ```<CMSIS Root folder>\CMSIS\NN\Include``` to the location `..\cmsisnn\include` in the new folder you created in the previous step.
     * Copy the generated static library located at ```<CMSIS Root folder>\CMSIS\NN\Include``` to the location `..\cmsisnn\lib`.
     * Create a Windows system environment variable named `CMSISNN_PATH` with the value ```<filepath>\cmsisnn```:
          * For Windows 10, right-click the start menu and select System.
          * Click System Info.
          * Click Advanced System Settings.
          * In the Advanced tab, click Environment Variables.
          * Click New.
          * You will be presented with a prompt to enter a new environment variable. In the Variable name field, enter `CMSISNN_PATH`. In the Variable value field, enter the file path to the `cmsisnn` folder you created. 
