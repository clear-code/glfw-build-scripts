# Build Script Horror

These are the horrible ad-hoc release building scripts for GLFW.  Most of this
stuff should be offloaded to CI services, because no one who is not a CI service
should be expected to have all these dependencies installed.

## Windows Dependencies

 - CMake 3.13+
 - Visual Studio 2010
 - Visual Studio 2012
 - Visual Studio 2013
 - Visual Studio 2015
   - Windows XP support
 - Visual Studio 2017
   - Windows XP support
 - Visual Studio 2019
 - Visual Studio 2022
 - MinGW
 - Cygwin
   - mingw64-i686-gcc-core
   - mingw64-x86\_64-gcc-core
   - cmake
   - make

## macOS Dependencies

 - CMake 3.13+
 - Xcode
   - Command-line tools

