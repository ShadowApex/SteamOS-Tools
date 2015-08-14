<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Usage](#usage)
- [General](#general)
- [Source build information](#source-build-information)
- [Testing](#testing)
  - [Testing machine specifications](#testing-machine-specifications)
  - [Latest Testing Results](#latest-testing-results)
- [General](#general-1)
  - [PSX/PS1 BIOS Files](#psxps1-bios-files)
- [Disc Images](#disc-images)
- [Input (General)](#input-general)
- [Input](#input)
  - [Input (Xbox 360 Controllers)](#input-xbox-360-controllers)
  - [Input (Sony PS3 Controllers)](#input-sony-ps3-controllers)
- [Shaders](#shaders)
- [Tested / known working cores](#tested--known-working-cores)
- [Troubleshoting](#troubleshoting)
  - [I Can't find my shader core!](#i-cant-find-my-shader-core)
  - [My game won't launch from detect core!](#my-game-wont-launch-from-detect-core)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

***
#Usage
***

Building Retroarch and Libretro cores from source is called from the main `desktop-software` script.

```
./desktop-software.sh install retroarch-src
```

However, if you wish to built a specific core, you can specify the core name as so:

```
./desktop-software.sh install retroarch-src mame
```

For a list of cores, please reference this [libretro-super](https://github.com/libretro/libretro-super/blob/master/libretro-build.sh#L91) file. 

***
#General
***
After running the retroarch-src type, currently you must still perform the following as of 20150427:

1. Add "Retroarch-Src" as a "non-Steam" game using the "+" icon on the Libary section of SteamOS
2. Configure your joypad via Retroarch > Settings > Input Settings (use bind all to configure all buttons at once)
3. Transfer any ROMs you had on your system, into appropriate folder structures under `/home/steam/ROMs`

***
#Source build information
***

Below you can find related information pertaining to building Retroarch/Libretro from source. This will only include items outside the automatic build script invoked by `desktop-software.sh`.

***
#Testing
***

##Testing machine specifications

**SteamOS-Test**  
* CPU: Intel Core 2 Quad Q9550
* RAM: 6 GB DDR2
* HDD: Seagate 7400 RPM
* GPU: Nvidia GT 640

**SteamOS Primary**  
* CPU: Intel Core i5 2500k
* RAM: 8 GB DDR3
* HDD: Seagate SSHD
* GPU: Nvidia GTX 770 SC

**SteamOS Secondary**  
* CPU: Intel Core i5 2500k
* RAM: 16 GB DDR3
* HDD: Intel SSD
* GPU: Nvidia GTX 550 Ti

##Latest Testing Results

**Host: SteamOS-Test**  
Date: 20150429  
Runtime: 86.25 minutes  
Pass: 48, Fail: 1  
Cores failed: gw  
Already fetched: [no]  

**Host: SteamOS**  
Date: 20150429    
Runtime:   
Pass:   
Cores failed:  
Already fetched:    

***
#General
***
Since the "system" directory of Retroarch is pre-configured to `/home/<user>/ROMs`, you'll want to also dump your BOIS files in this location as well.

##PSX/PS1 BIOS Files

Mednafen is very picky about which BIOS to use. The ones that you might need are:

* scph5500.bin
* scph5501.bin
* scph5502.bin

Copy this file to the `$HOME/ROMs` directory of the user you are working with. Most commonly this is `/home/steam/ROMs`. If you can't find one of these, just rename the respective scph100x.bin BIOS (such as scph1001.bin) to scph550x.bin (such as scph5501.bin) and it will take it. 

***
#Disc Images
***

Mednafen requires you to load games through CUE sheets. Ensure that the CUE sheet is properly set up in order for the game to run. See the Cue sheet (.cue) for more.

***
#Input (General)
***
Please take note of the following general modifications:

* Save state: Left-thumbstick click (L3)
* Load state: Right-thumbstick click (R3)
* Show Retroarch menue: back/select
* Exit Game: Enter menu, choose "Quit Retroarch"
 
Please note: The center button of either the Sony or Microsoft controllers is not ideal for opening the Retroarch menu or quitting Retroarch. Steam Big Picture Mode / SteamOS uses this button by default to bring up the Steam overlay. Save states are not supported on all consoles/cores.

Each controller preset, if chosen during the Retroarch post-install sequence, is preset for 4 players maxiumum. If you wish to configure more, please use the input settings section of Retroarch.

***
#Input
***
Below is all available known information for gamepad input and control.
Please submit suggestions as an issues ticket.

##Input (Xbox 360 Controllers)
The Xbox controllers are mapped exactly has Retroarch has requested each button to be. See the below diagram.

![alt text](http://www.libregeek.org/wp-content/uploads/2014/04/xbox-controller-mapping-1024x768.jpg "Xbox 360 Controller")

##Input (Sony PS3 Controllers)

The Sony Dualshock 3 controller is setup in the same fashion as the above Xbox 360 controller. The main things to keep in mind are

* X is "A"
* Circle is "B"
* Square is "X"
* Triange is "Y"

***
#Shaders
***

Shaders are assessed at build time for Retroarch. The pre-requisite pacakge `nvidia-cg-toolkit` is pre-installed before the build kicks off.

***
#Tested / known working cores
***
You can find a list of cores tested with games already [here](https://github.com/ProfessorKaos64/SteamOS-Tools/edit/testing/docs/Retroarch-Testing-Checklist.md)

***
#Troubleshoting
***

##I Can't find my shader core!
Some shaders, such as eagle, are of a `.cg` not `.cgp` file extension/type. Loading shader presets only works with a `.cgp` file.

To load cg files, load a cgp shader (i.e. one that you can see), increment the passes by 1 and then go to where it says N/A and navigate to the `.cg` file. Alternatively, you can change the first pass, but I suggest adding another pass to add this cg file.

##My game won't launch from detect core!
As it was today, 20150607, there are times when building from and active Git source can be a disadvantageous. For all the benefits it brings, there will be times when things break. In this example a [bad commit](https://github.com/libretro/RetroArch/commit/0eacc9ff30835fc4898b0e25806f96dda150d1b0) broke core detection mechanisms for content loaded. However, you can still load the core, then the content just fine.

