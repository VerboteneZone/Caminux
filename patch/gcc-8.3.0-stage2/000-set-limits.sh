#!/bin/sh
source_dir="$1"
build_dir="$2"
cross_dir="$3"
target="$4"

cd $source_dir || exit 1
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $(${source_dir}/../..${cross_dir}/bin/${target}-gcc -print-libgcc-file-name)`/include-fixed/limits.h
  