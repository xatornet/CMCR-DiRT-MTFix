# CMCR-DiRT-MTFix
A **VERY WORK-IN-PROGRESS** Colin MCRae DiRT Multithread Fix, for Windows OS

## A little insight
The game was launched on 2007, just prior to Intel's Sandy Bridge Core microarchitecture , which more or less marked a milestone on multithreading as we all know it nowadays.
So given that circunstance, the game already has support for 2 and 4 cores CPU, mostly from the Dual and Quad Core era. It even has a non-working 8 core support implemented (in fact, the 8 core worker map file is there, but the game won't make use of it on modern hardware and implements it weirdly).

EGO engine it has been vastly used on several titles from Codemasters, so I did a little investigation on other EGO 1.0 and 1.5 titles, and came up with a fix for that 8 core workermap.
Upon testing, I realized that the workermap could be extrapolated to more cores, so I made several other worker map files to support 8, 12, 16, 20, 24, 28 and 32 cores. I don't really know how much better the game will perform, but at least It won't hurt as much as being only using 4 cores max.

Also, this method fixes several other hardware detection problems as:
- Improper resolution detection
- Improper system internal rating

## What exactly does this fix?
Well, it copies my fix xml files to your game's system folder, and then using a template, will detect your CPU's logical cores, and create a personalized hardware restriction file, to make your the game uses the most amount of cores possible.

### * In what Release do I have to use this fix?
It should work on any release, but I've only tested it in the v1.22 release, the one that removes the DRM, so I encourage you to use that one.

## How to apply the fix
If you already have the requirements above done, the fix is easy to apply.

### 1-Download the fix 
You can download the fix as is, but in order for Windows to be able to execute powershell scripts, you have to enable it through the admin powershell console. And it's tedious. That's why I've compiled with PS2exe the script into an EXE file. 

Download the file "CMCR-DiRT-MTFix.exe" and paste it on the main Colin MCRae DiRT folder, just near the DiRT.exe file.

[Releases](https://github.com/xatornet/CMCR-DiRT-MTFix/releases)

### 2-Execute CMCR-DiRT-MTFix.exe
Let it do its things

### 3-Run the game and reconfigure it.
Your settings should be gone. Set them up again.

### If everything works, you can now play Race Driver: Grid making the most out of your hardware.

### * Strong Recommendation
I really encourage you to pair this fix with [DXVK from Ph42oN](https://gitlab.com/Ph42oN/dxvk-gplasync) if your GPU is Vulkan capable. On my system I go from 180fps in race with D3D9 to 400fps with Vulkan. Give it a try!! 

