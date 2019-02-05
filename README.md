# libnova

### Build

```
# First install 
brew install unzip
brew install autoconf
brew install automake
brew install libtool

# Then just run create_lipo.bash, which will create: template.framework
./create_lipo.bash

```

### Useful links gathered when creating the bash-script

- [Source of CMake toolchain](https://github.com/leetal/ios-cmake)

- [Best source for explaing how to use rpath in CMake](https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/RPATH-handling)

- [How hard it is to find out what the actual value of the rpath will be](https://gitlab.kitware.com/cmake/cmake/issues/16589)

- [Finding out how to concstruct the rpath](https://developer.apple.com/library/archive/technotes/tn2435/_index.html)