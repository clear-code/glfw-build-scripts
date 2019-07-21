#!/bin/sh

COMMON="-DCMAKE_BUILD_TYPE=Release -DGLFW_BUILD_TESTS=NO -DGLFW_BUILD_EXAMPLES=NO -DGLFW_BUILD_DOCS=NO -DCMAKE_C_FLAGS=-s"
SHARED="$COMMON -DBUILD_SHARED_LIBS=YES"
STATIC="$COMMON -DBUILD_SHARED_LIBS=NO"
GLFWDIR="$1"
GLFWVER="$2"

if [ ! -d "$GLFWDIR" ]; then
    echo "$GLFWDIR: Directory not found"
    echo "Usage: $(basename $0) <glfwpath> <version>"
    exit 1
fi

if [ -z "$GLFWVER" ]; then
    echo "No version specified"
    echo "Usage: $(basename $0) <glfwpath> <version>"
    exit 1
fi

build()
{
    cmake -E make_directory $BUILDDIR
    cmake -E make_directory $TARGETDIR
    cmake -S $GLFWDIR -B $BUILDDIR -DCMAKE_TOOLCHAIN_FILE=$TOOLPATH $STATIC
    cmake --build $BUILDDIR
    cmake $SHARED $BUILDDIR
    cmake --build $BUILDDIR
    cmake -E copy $BUILDDIR/src/libglfw3.a    $TARGETDIR
    cmake -E copy $BUILDDIR/src/libglfw3dll.a $TARGETDIR
    cmake -E copy $BUILDDIR/src/glfw3.dll     $TARGETDIR
}

# MinGW-w64 32-bit
TOOLPATH="CMake/i686-w64-mingw32.cmake"
BUILDDIR="build/mingw-w64-x86"
TARGETDIR="glfw-$GLFWVER.bin.WIN32/lib-mingw-w64"
build

# MinGW-w64 64-bit
TOOLPATH="CMake/x86_64-w64-mingw32.cmake"
BUILDDIR="build/mingw-w64-x64"
TARGETDIR="glfw-$GLFWVER.bin.WIN64/lib-mingw-w64"
build

