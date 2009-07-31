#!/bin/bash

#
# cross build : http://source.icu-project.org/repos/icu/icu/trunk/readme.html#HowToCrossCompileICU
#

# 0. clean up.

BUILDN=i686-pc-linux
BUILDX=arm-926ejs-linux

rm -rf build || exit 1
mkdir -p build/$BUILDN
mkdir -p build/$BUILDX
    
# 1. native build.
BUILDROOT=`pwd`

echo "cd $BUILDROOT/build/$BUILDN"
cd build/$BUILDN || exit 1

echo "runConfigureICU Linux.."
sh $BUILDROOT/source/runConfigureICU Linux || exit 1

echo "make.."
make || exit 1

echo "cd $BUILDROOT"
cd $BUILDROOT || exit 1


# 2. cross build
echo "cd $BUILDROOT/build/$BUILDX"
cd $BUILDROOT/build/$BUILDX || exit 1

export PATH=/opt/freescale/usr/local/gcc-4.1.1-glibc-2.4-nptl-sf-1/arm-926ejs-linux/bin:$PATH
export CC=arm-926ejs-linux-gcc
export CFLAGS="-I/opt/freescale/bsp/mx27/rel2c_20070522/rootfs/usr/include -I/devel/freescale/linux-2.6.19.2/include -I/opt/freescale/usr/include"

echo "configure.."
sh $BUILDROOT/source/configure --prefix=/opt/freescale/usr --host=arm-926ejs-linux --enable-static --disable-shared --enable-threads --with-cross-build=$BUILDROOT/build/$BUILDN 

echo "make.."
make || exit 1

echo "make install.."
make install

echo "success.."    


