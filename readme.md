# MiniROM-image

This meta-project will build all of the individual Mini/ROM components and package them as a complete ROM image ready to program. A complete firmware image contains a ROM disk image, the utility program, and BIOS.

To pull the package and all submodules at once using the command line you can do the following, if you have git 1.6.5 or later:
```
git clone --recursive https://github.com/dmadole/MiniDOS-baseutils
```
For older versions of git, 1.5 or later, you will need to use instead: 
```
git clone https://github.com/dmadole/MiniDOS-baseutils
cd MiniDOS-baseutils
git submodule update --init --recursive
```
Once you have the package and submodules, to build the ROM image:
```
make mini
```
Note that commits of the image package are linked to specific commits of submodules, so even as the submodule repositories are updated, a pull of a specific baseutils commit (or tag) will always build the same set of components. In this way, ROM firmware can have it's own specific consistent releases even as the individual components are moving targets.
