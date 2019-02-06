#!/bin/bash -x

LIBNOVA_ZIP=libnova-libnova-edbf65abe27ef1a2520eb9e839daaf58f15a6941.zip

# All architectures: (however this will compile multiple times for the same architechture)
#declare -a PLATFORMS=("SIMULATOR64" "OS" "OS64" "TVOS" "SIMULATOR_TVOS" "WATCHOS" "SIMULATOR_WATCHOS")

# This should cover all architechtures: (will contain: x86_64 armv7 armv7s armv7k arm64_32 arm64 arm64e)
declare -a PLATFORMS=("SIMULATOR64" "OS" "WATCHOS")

for i in "${PLATFORMS[@]}"
do
   rm -rf libnova-libnova-edbf65abe27ef1a2520eb9e839daaf58f15a6941 2>/dev/null
   target="${i}-liblibnova.dylib"
   unzip "${LIBNOVA_ZIP}"
   unzip_folder_name=`basename ${LIBNOVA_ZIP%.*}`
   pushd "$unzip_folder_name"
   autoreconf -fiv
   ./configure 
   cp config.h src/
   mkdir build
   pushd build
   cmake .. -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DIOS_PLATFORM="${i}" -DENABLE_ARC=FALSE
   make libnova
   popd
   popd
   find . -name liblibnova.dylib -exec cp '{}' "${target}" \;
   install_name_tool -id @rpath/libnova.framework/libnova "${target}"
   otool -D "${target}"
done

rm -rf libnova.framework
cp -r template.framework/ libnova.framework
find libnova-libnova-edbf65abe27ef1a2520eb9e839daaf58f15a6941/src/libnova ! -name confdefs.h -name "*.h" -exec cp -v '{}' libnova.framework/Headers/ \;
lipo -create *.dylib -output libnova.framework/libnova