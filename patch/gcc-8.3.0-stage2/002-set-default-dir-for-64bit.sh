#!/bin/sh
source_dir="$1"
build_dir="$2"
cross_dir="$3"
target="$4"

cd $source_dir || exit 1
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac
