#!/bin/bash -x

# Using cmake from here:
# https://github.com/leetal/ios-cmake

# Very very important:
# https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/RPATH-handling

# Also rather important:
# https://gitlab.kitware.com/cmake/cmake/issues/16589

if [ ! -f "${LIBNOVA_ZIP}" ] ; then
    echo "LIBNOVA_ZIP not set or doesn't point to a file"
    exit 1
fi

#declare -a PLATFORMS=("SIMULATOR64" "OS" "OS64" "TVOS" "SIMULATOR_TVOS" "WATCHOS" "SIMULATOR_WATCHOS")
declare -a PLATFORMS=("SIMULATOR64" "OS64")

for i in "${PLATFORMS[@]}"
do
   rm -rf /Users/davideverlof/repo/liponova/libnova-libnova-edbf65abe27ef1a2520eb9e839daaf58f15a6941 2>/dev/null
   target="${i}-liblibnova.dylib"
   echo "Platform $i, target => $target"
   unzip "${LIBNOVA_ZIP}"
   unzip_folder_name=`basename ${LIBNOVA_ZIP%.*}`
   pushd "$unzip_folder_name"
   autoreconf -fiv
   ./configure 
   cp config.h src/
   mkdir build
   pushd build
   cmake .. -DENABLE_BITCODE=FALSE -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DIOS_PLATFORM="${i}"
   make libnova
   popd
   popd
   find . -name liblibnova.dylib -exec cp '{}' "${target}" \;
   install_name_tool -id @rpath/libnova.framework/libnova "${target}"
   otool -D "${target}"
done

rm -rf libnova.framework
cp -r template.framework/ libnova.framework
find libnova-libnova-edbf65abe27ef1a2520eb9e839daaf58f15a6941/src/libnova -name "*.h" -exec cp -v '{}' libnova.framework/Headers/ \;
lipo -create *.dylib -output libnova.framework/libnova