# libnova

A cooca-framework of `libnova` that can be found on [sourceforge](http://libnova.sourceforge.net/). Using the bash-script provided in this repo you can compile for the following architectures: `x86_64`, `armv7`, `armv7s`, `armv7k`, `arm64_32`, `arm64` and `arm64e`.

### Usage

1. Build using the steps in "Build".
2. Drag .framework file your Xcode-project.
3. Make sure it's added to both **Embedded Binaries** and **Linked frameworks and Libraries**.
4. Import it! (Swift `import libnova` or ObjC `#include <libnova/libnova.h>`

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

## Resources

[ZIP-file source](https://sourceforge.net/p/libnova/libnova/ci/v0.16/tree/) or [direct link](https://sourceforge.net/code-snapshots/git/l/li/libnova/libnova.git/libnova-libnova-edbf65abe27ef1a2520eb9e839daaf58f15a6941.zip).

## Credit

All credit to the creators libNova-Team Liam Girdwood, Juan Carlos Remis and Petr Kubanek.