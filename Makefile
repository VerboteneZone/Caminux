##################################################################################
#
#    Caminux - A small Linux distribution, designed for the use with ip cameras
#
#    Copyright (C) 2019 Oliver Welter <contact@verbotene.zone>
#
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
##################################################################################
#
#    To install just create a symlink from the subdirectory of this path:
#    ln -vs <this_path>/tools /
#
#    Then, just run "make" and wait a few hours ;-)
#

TARGET := arm-unknown-linux-gnueabi

SYSROOT := $(PWD)

DOWNLOAD := /download
SOURCES := /sources
TOOLS := /tools
BUILD := /build
PATCH := /patch
LIB := $(TOOLS)/lib
INCLUDE := $(TOOLS)/include

ABS_DOWNLOAD := $(SYSROOT)$(DOWNLOAD)
ABS_SOURCES := $(SYSROOT)$(SOURCES)
ABS_TOOLS := $(SYSROOT)$(TOOLS)
ABS_BUILD := $(SYSROOT)$(BUILD)
ABS_PATCH := $(SYSROOT)$(PATCH)
ABS_LIB := $(SYSROOT)$(LIB)
ABS_INCLUDE := $(SYSROOT)$(INCLUDE)

LC_ALL := POSIX
MAKEFLAGS := -j1
SHELL := /bin/bash
PATH := $(ABS_TOOLS)/bin:$(PATH)

BINUTILS_VERSION = 2.32
BINUTILS_BASEURL = https://ftp.gnu.org/gnu/binutils
BINUTILS_EXT = tar.gz
BINUTILS_TAR = xzf
BINUTILS_SHORT = binutils
BINUTILS_NAME = $(BINUTILS_SHORT)-$(BINUTILS_VERSION)

GCC_VERSION = 8.3.0
GCC_BASEURL = https://ftp.gnu.org/gnu/gcc/gcc-$(GCC_VERSION)
GCC_EXT = tar.gz
GCC_TAR = xzf
GCC_SHORT = gcc
GCC_GLIBC_VERSION = 2.11
GCC_NAME = $(GCC_SHORT)-$(GCC_VERSION)

GMP_VERSION = 6.1.2
GMP_BASEURL = https://ftp.gnu.org/gnu/gmp
GMP_EXT = tar.bz2
GMP_TAR = xjf
GMP_SHORT = gmp
GMP_NAME = $(GMP_SHORT)-$(GMP_VERSION)

MPFR_VERSION = 4.0.2
MPFR_BASEURL = https://ftp.gnu.org/gnu/mpfr
MPFR_EXT = tar.gz
MPFR_TAR = xzf
MPFR_SHORT = mpfr
MPFR_NAME = $(MPFR_SHORT)-$(MPFR_VERSION)

MPC_VERSION = 1.1.0
MPC_BASEURL = https://ftp.gnu.org/gnu/mpc
MPC_EXT = tar.gz
MPC_TAR = xzf
MPC_SHORT = mpc
MPC_NAME = $(MPC_SHORT)-$(MPC_VERSION)

KERNEL_VERSION = 5.0.2
KERNEL_BASEURL = https://cdn.kernel.org/pub/linux/kernel/v5.x
KERNEL_EXT = tar.gz
KERNEL_TAR = xzf
KERNEL_SHORT = linux
KERNEL_NAME = $(KERNEL_SHORT)-$(KERNEL_VERSION)
KERNEL_ARCH = arm

GLIBC_VERSION = 2.29
GLIBC_BASEURL = https://ftp.gnu.org/gnu/glibc
GLIBC_EXT = tar.gz
GLIBC_TAR = xzf
GLIBC_SHORT = glibc
GLIBC_NAME = $(GLIBC_SHORT)-$(GLIBC_VERSION)
GLIBC_ENABLE_KERNEL = 5.0
GLIBC_CFLAGS = -D__ARM_ARCH_5__ -g -O2


all: check-path prepare download extract build



.PHONY: check-path
check-path: $(TOOLS)

$(TOOLS):
	@echo "$(TOOLS) doesnt exist! Please create a symlink:"
	@echo "mkdir $(ABS_TOOLS); ln -vs $(ABS_TOOLS) $(TOOLS)"
	@exit 1



.PHONY: prepare
prepare: $(ABS_DOWNLOAD) $(ABS_TOOLS) $(ABS_LIB) $(ABS_LIB)64 $(ABS_SOURCES) $(ABS_BUILD)

$(ABS_DOWNLOAD):
	mkdir $(ABS_DOWNLOAD)
	
$(ABS_TOOLS):
	mkdir $(ABS_TOOLS)
	
$(ABS_LIB):
	mkdir -v $(ABS_LIB)

$(ABS_LIB)64:
	cd $(ABS_LIB); ln -sv lib $(LIB)64
	
$(ABS_SOURCES):
	mkdir $(ABS_SOURCES)

$(ABS_BUILD):
	mkdir $(ABS_BUILD)

		

.PHONY: download
download: $(ABS_DOWNLOAD)/.$(BINUTILS_NAME).$(BINUTILS_EXT) \
	$(ABS_DOWNLOAD)/.$(GMP_NAME).$(GMP_EXT) \
	$(ABS_DOWNLOAD)/.$(MPFR_NAME).$(MPFR_EXT) \
	$(ABS_DOWNLOAD)/.$(MPC_NAME).$(MPC_EXT) \
	$(ABS_DOWNLOAD)/.$(GCC_NAME).$(GCC_EXT) \
	$(ABS_DOWNLOAD)/.$(KERNEL_NAME).$(KERNEL_EXT) \
	$(ABS_DOWNLOAD)/.$(GLIBC_NAME).$(GLIBC_EXT)

$(ABS_DOWNLOAD)/.$(BINUTILS_NAME).$(BINUTILS_EXT):
	wget -O $(ABS_DOWNLOAD)/$(BINUTILS_NAME).$(BINUTILS_EXT) $(BINUTILS_BASEURL)/$(BINUTILS_NAME).$(BINUTILS_EXT) && \
	touch $(ABS_DOWNLOAD)/.$(BINUTILS_NAME).$(BINUTILS_EXT)

$(ABS_DOWNLOAD)/.$(GMP_NAME).$(GMP_EXT):
	wget -O $(ABS_DOWNLOAD)/$(GMP_NAME).$(GMP_EXT) $(GMP_BASEURL)/$(GMP_NAME).$(GMP_EXT) && \
	touch $(ABS_DOWNLOAD)/.$(GMP_NAME).$(GMP_EXT)

$(ABS_DOWNLOAD)/.$(MPFR_NAME).$(MPFR_EXT):
	wget -O $(ABS_DOWNLOAD)/$(MPFR_NAME).$(MPFR_EXT) $(MPFR_BASEURL)/$(MPFR_NAME).$(MPFR_EXT) && \
	touch $(ABS_DOWNLOAD)/.$(MPFR_NAME).$(MPFR_EXT)

$(ABS_DOWNLOAD)/.$(MPC_NAME).$(MPC_EXT):
	wget -O $(ABS_DOWNLOAD)/$(MPC_NAME).$(MPC_EXT) $(MPC_BASEURL)/$(MPC_NAME).$(MPC_EXT) && \
	touch $(ABS_DOWNLOAD)/.$(MPC_NAME).$(MPC_EXT)

$(ABS_DOWNLOAD)/.$(GCC_NAME).$(GCC_EXT):
	wget -O $(ABS_DOWNLOAD)/$(GCC_NAME).$(GCC_EXT) $(GCC_BASEURL)/$(GCC_NAME).$(GCC_EXT) && \
	touch $(ABS_DOWNLOAD)/.$(GCC_NAME).$(GCC_EXT)

$(ABS_DOWNLOAD)/.$(KERNEL_NAME).$(KERNEL_EXT):
	wget -O $(ABS_DOWNLOAD)/$(KERNEL_NAME).$(KERNEL_EXT) $(KERNEL_BASEURL)/$(KERNEL_NAME).$(KERNEL_EXT) && \
	touch $(ABS_DOWNLOAD)/.$(KERNEL_NAME).$(KERNEL_EXT)

$(ABS_DOWNLOAD)/.$(GLIBC_NAME).$(GLIBC_EXT):
	wget -O $(ABS_DOWNLOAD)/$(GLIBC_NAME).$(GLIBC_EXT) $(GLIBC_BASEURL)/$(GLIBC_NAME).$(GLIBC_EXT) && \
	touch $(ABS_DOWNLOAD)/.$(GLIBC_NAME).$(GLIBC_EXT)



.PHONY: extract
extract: $(ABS_SOURCES)/$(BINUTILS_NAME) \
	$(ABS_SOURCES)/$(GCC_NAME) \
	$(ABS_SOURCES)/$(GCC_NAME)/$(GMP_SHORT) \
	$(ABS_SOURCES)/$(GCC_NAME)/$(MPFR_SHORT) \
	$(ABS_SOURCES)/$(GCC_NAME)/$(MPC_SHORT) \
	$(ABS_SOURCES)/$(KERNEL_NAME) \
	$(ABS_SOURCES)/$(GLIBC_NAME)

$(ABS_SOURCES)/$(BINUTILS_NAME):
	tar -C $(ABS_SOURCES) -$(BINUTILS_TAR) $(ABS_DOWNLOAD)/$(BINUTILS_NAME).$(BINUTILS_EXT)

$(ABS_SOURCES)/$(GCC_NAME):
	tar -C $(ABS_SOURCES) -$(GCC_TAR) $(ABS_DOWNLOAD)/$(GCC_NAME).$(GCC_EXT)

$(ABS_SOURCES)/$(GCC_NAME)/$(GMP_SHORT):
	tar -C $(ABS_SOURCES)/$(GCC_NAME) -$(GMP_TAR) $(ABS_DOWNLOAD)/$(GMP_NAME).$(GMP_EXT)
	mv $(ABS_SOURCES)/$(GCC_NAME)/$(GMP_NAME) $(ABS_SOURCES)/$(GCC_NAME)/$(GMP_SHORT)

$(ABS_SOURCES)/$(GCC_NAME)/$(MPFR_SHORT):
	tar -C $(ABS_SOURCES)/$(GCC_NAME) -$(MPFR_TAR) $(ABS_DOWNLOAD)/$(MPFR_NAME).$(MPFR_EXT)
	mv $(ABS_SOURCES)/$(GCC_NAME)/$(MPFR_NAME) $(ABS_SOURCES)/$(GCC_NAME)/$(MPFR_SHORT)

$(ABS_SOURCES)/$(GCC_NAME)/$(MPC_SHORT):
	tar -C $(ABS_SOURCES)/$(GCC_NAME) -$(MPC_TAR) $(ABS_DOWNLOAD)/$(MPC_NAME).$(MPC_EXT)
	mv $(ABS_SOURCES)/$(GCC_NAME)/$(MPC_NAME) $(ABS_SOURCES)/$(GCC_NAME)/$(MPC_SHORT)

$(ABS_SOURCES)/$(KERNEL_NAME):
	tar -C $(ABS_SOURCES) -$(KERNEL_TAR) $(ABS_DOWNLOAD)/$(KERNEL_NAME).$(KERNEL_EXT)

$(ABS_SOURCES)/$(GLIBC_NAME):
	tar -C $(ABS_SOURCES) -$(GLIBC_TAR) $(ABS_DOWNLOAD)/$(GLIBC_NAME).$(GLIBC_EXT)



.PHONY: build
build: build-stage1 build-stage2

build-stage1: binutils-stage1 gcc-stage1 kernel-headers-stage1 glibc-stage1 libstdc++-v3-stage1

binutils-stage1: $(ABS_BUILD)/$(BINUTILS_NAME) \
	$(ABS_BUILD)/$(BINUTILS_NAME)/.patch \
	$(ABS_BUILD)/$(BINUTILS_NAME)/Makefile \
	$(ABS_BUILD)/$(BINUTILS_NAME)/binutils/ranlib \
	$(ABS_TOOLS)/bin/$(TARGET)-ranlib

$(ABS_BUILD)/$(BINUTILS_NAME):
	mkdir -p $(ABS_BUILD)/$(BINUTILS_NAME)

$(ABS_BUILD)/$(BINUTILS_NAME)/.patch:
	cd $(ABS_SOURCES)/$(BINUTILS_NAME); \
	find $(ABS_PATCH)/$(BINUTILS_NAME) -name "*.patch" -exec patch -p1 \< \{\} \;
	cd $(ABS_PATCH)/$(BINUTILS_NAME); \
	find -type f -name "*.sh" -exec sh \{\} $(ABS_SOURCES)/$(BINUTILS_NAME) $(ABS_BUILD)/$(BINUTILS_NAME) $(TOOLS) $(TARGET) \;
	touch $(ABS_BUILD)/$(BINUTILS_NAME)/.patch	

$(ABS_BUILD)/$(BINUTILS_NAME)/Makefile:
	cd $(ABS_BUILD)/$(BINUTILS_NAME); \
	$(ABS_SOURCES)/$(BINUTILS_NAME)/configure --target=$(TARGET) \
	--prefix=$(TOOLS) --with-sysroot=$(SYSROOT) --with-lib-path=$(LIB) \
	--disable-nls --disable-werror

$(ABS_BUILD)/$(BINUTILS_NAME)/binutils/ranlib:
	cd $(ABS_BUILD)/$(BINUTILS_NAME); \
	make
	
$(ABS_TOOLS)/bin/$(TARGET)-ranlib:
	cd $(ABS_BUILD)/$(BINUTILS_NAME); \
        make DESTDIR=$(SYSROOT) install

gcc-stage1: $(ABS_BUILD)/$(GCC_NAME) \
	$(ABS_BUILD)/$(GCC_NAME)/.patch \
	$(ABS_BUILD)/$(GCC_NAME)/Makefile \
	$(ABS_BUILD)/$(GCC_NAME)/gcc/gcc-ranlib \
	$(ABS_BUILD)/$(GCC_NAME)/gcc/libgcc_eh.a \
	$(ABS_BUILD)/$(GCC_NAME)/$(TARGET)/libgcc/libgcc_eh.a \
	$(ABS_TOOLS)/bin/$(TARGET)-gcc \
	$(ABS_TOOLS)/lib/gcc/$(TARGET)/$(GCC_VERSION)/libgcc_eh.a

$(ABS_BUILD)/$(GCC_NAME):
	mkdir -p $(ABS_BUILD)/$(GCC_NAME)

$(ABS_BUILD)/$(GCC_NAME)/.patch:
	cd $(ABS_SOURCES)/$(GCC_NAME); \
	find $(ABS_PATCH)/$(GCC_NAME) -name "*.patch" -exec patch -p1 \< \{\} \;
	cd $(ABS_PATCH)/$(GCC_NAME); \
	find -type f -name "*.sh" -exec sh \{\} $(ABS_SOURCES)/$(GCC_NAME) $(ABS_BUILD)/$(GCC_NAME) $(TOOLS) $(TARGET) \;
	touch $(ABS_BUILD)/$(GCC_NAME)/.patch	

$(ABS_BUILD)/$(GCC_NAME)/Makefile:
	cd $(ABS_BUILD)/$(GCC_NAME); \
	$(ABS_SOURCES)/$(GCC_NAME)/configure --target=$(TARGET) --prefix=$(TOOLS) \
	--with-glibc-version=$(GCC_GLIBC_VERSION) --with-sysroot=$(SYSROOT) --with-newlib --without-headers \
	--with-local-prefix=$(TOOLS) --with-native-system-header-dir=$(INCLUDE) \
	--disable-nls --disable-shared --disable-multilib --disable-decimal-float --disable-threads \
	--disable-libatomic --disable-libgomp --disable-libmpx --disable-libquadmath --disable-libssp \
	--disable-libvtv --disable-libstdcxx --enable-languages=c,c++

$(ABS_BUILD)/$(GCC_NAME)/gcc/gcc-ranlib:
	cd $(ABS_BUILD)/$(GCC_NAME); \
	make

$(ABS_BUILD)/$(GCC_NAME)/gcc/libgcc_eh.a:
	ln -vs $(ABS_BUILD)/$(GCC_NAME)/gcc/libgcc.a $(ABS_BUILD)/$(GCC_NAME)/gcc/libgcc_eh.a

$(ABS_BUILD)/$(GCC_NAME)/$(TARGET)/libgcc/libgcc_eh.a:
	ln -vs $(ABS_BUILD)/$(GCC_NAME)/$(TARGET)/libgcc/libgcc.a $(ABS_BUILD)/$(GCC_NAME)/$(TARGET)/libgcc/libgcc_eh.a

$(ABS_TOOLS)/bin/$(TARGET)-gcc:
	cd $(ABS_BUILD)/$(GCC_NAME); \
	make DESTDIR=$(SYSROOT) install

$(ABS_TOOLS)/lib/gcc/$(TARGET)/$(GCC_VERSION)/libgcc_eh.a:
	ln -vs $(ABS_TOOLS)/lib/gcc/$(TARGET)/$(GCC_VERSION)/libgcc.a $(ABS_TOOLS)/lib/gcc/$(TARGET)/$(GCC_VERSION)/libgcc_eh.a

kernel-headers-stage1: $(ABS_BUILD)/$(KERNEL_NAME) $(ABS_BUILD)/headers-$(KERNEL_NAME) $(ABS_BUILD)/$(KERNEL_NAME)/.patch $(ABS_BUILD)/$(KERNEL_NAME)/.mrproper $(ABS_BUILD)/headers-$(KERNEL_NAME)/include $(ABS_TOOLS)/include/linux

$(ABS_BUILD)/$(KERNEL_NAME):
	mkdir $(ABS_BUILD)/$(KERNEL_NAME)
	
$(ABS_BUILD)/headers-$(KERNEL_NAME):
	mkdir $(ABS_BUILD)/headers-$(KERNEL_NAME)
	
$(ABS_BUILD)/$(KERNEL_NAME)/.patch:
	cd $(ABS_SOURCES)/$(KERNEL_NAME); \
	find $(ABS_PATCH)/$(KERNEL_NAME) -name "*.patch" -exec patch -p1 \< \{\} \;
	cd $(ABS_PATCH)/$(KERNEL_NAME); \
	find -type f -name "*.sh" -exec sh \{\} $(ABS_SOURCES)/$(KERNEL_NAME) $(ABS_BUILD)/$(KERNEL_NAME) $(TOOLS) $(TARGET) \;
	touch $(ABS_BUILD)/$(KERNEL_NAME)/.patch

$(ABS_BUILD)/$(KERNEL_NAME)/.mrproper:
	cd $(ABS_BUILD)/$(KERNEL_NAME); \
	make -C $(ABS_SOURCES)/$(KERNEL_NAME) mrproper; \
	touch $(ABS_BUILD)/$(KERNEL_NAME)/.mrproper

$(ABS_BUILD)/headers-$(KERNEL_NAME)/include:
	cd $(ABS_BUILD)/headers-$(KERNEL_NAME); \
	make ARCH=$(KERNEL_ARCH) INSTALL_HDR_PATH=$(ABS_BUILD)/headers-$(KERNEL_NAME) -C $(ABS_SOURCES)/$(KERNEL_NAME) headers_install

$(ABS_TOOLS)/include/linux:
	cd $(ABS_BUILD)/headers-$(KERNEL_NAME); \
	cp -rv include/* $(ABS_TOOLS)/include

glibc-stage1: $(ABS_BUILD)/$(GLIBC_NAME) \
	$(ABS_BUILD)/$(GLIBC_NAME)/.patch \
	$(ABS_BUILD)/$(GLIBC_NAME)/Makefile \
	$(ABS_BUILD)/$(GLIBC_NAME)/libc.a \
	$(ABS_TOOLS)/lib/libc.a \
	$(ABS_TOOLS)/lib/gcc/arm-unknown-linux-gnueabi/8.3.0/crtn.o \
	$(ABS_TOOLS)/lib/gcc/arm-unknown-linux-gnueabi/8.3.0/libc.so \
	$(ABS_TOOLS)/lib/gcc/arm-unknown-linux-gnueabi/8.3.0/libm.so \
	$(ABS_BUILD)/$(GLIBC_NAME)/.test

$(ABS_BUILD)/$(GLIBC_NAME):
	mkdir -p $(ABS_BUILD)/$(GLIBC_NAME)

$(ABS_BUILD)/$(GLIBC_NAME)/.patch:
	cd $(ABS_SOURCES)/$(GLIBC_NAME); \
	find $(ABS_PATCH)/$(GLIBC_NAME) -name "*.patch" -exec patch -p1 \< \{\} \;
	cd $(ABS_PATCH)/$(GLIBC_NAME); \
	find -type f -name "*.sh" -exec sh \{\} $(ABS_SOURCES)/$(GLIBC_NAME) $(ABS_BUILD)/$(GLIBC_NAME) $(TOOLS) $(TARGET) \;
	touch $(ABS_BUILD)/$(GLIBC_NAME)/.patch

$(ABS_BUILD)/$(GLIBC_NAME)/Makefile:
	cd $(ABS_BUILD)/$(GLIBC_NAME); \
	config=`$(ABS_SOURCES)/$(GLIBC_NAME)/scripts/config.guess`; \
	$(ABS_SOURCES)/$(GLIBC_NAME)/configure --prefix=$(TOOLS) --host=$(TARGET) \
	--build=$$config --enable-kernel=$(GLIBC_ENABLE_KERNEL) --with-headers=$(ABS_INCLUDE) \
	--with-binutils=$(ABS_TOOLS)/bin --with-bugurl="https://github.com/verbotenezone/Caminux"

$(ABS_BUILD)/$(GLIBC_NAME)/libc.a:
	cd $(ABS_BUILD)/$(GLIBC_NAME); \
	make -j1
	
$(ABS_TOOLS)/lib/libc.a:
	cd $(ABS_BUILD)/$(GLIBC_NAME); \
        make DESTDIR=$(SYSROOT) install

$(ABS_TOOLS)/lib/gcc/arm-unknown-linux-gnueabi/8.3.0/crtn.o:
	ln -vs $(ABS_TOOLS)/lib/crt{1,i,n}.o $(ABS_TOOLS)/lib/gcc/arm-unknown-linux-gnueabi/8.3.0/

$(ABS_TOOLS)/lib/gcc/arm-unknown-linux-gnueabi/8.3.0/libc.so:
	ln -vs $(ABS_TOOLS)/lib/libc.{so,so.6} $(ABS_TOOLS)/lib/gcc/arm-unknown-linux-gnueabi/8.3.0/

$(ABS_TOOLS)/lib/gcc/arm-unknown-linux-gnueabi/8.3.0/libm.so:
	ln -vs $(ABS_TOOLS)/lib/libm.{so,so.6} $(ABS_TOOLS)/lib/gcc/arm-unknown-linux-gnueabi/8.3.0/

$(ABS_BUILD)/$(GLIBC_NAME)/.test:
	cd $(ABS_TOOLS); \
	ldlinux=`ls -1 lib/ld-linux.so.*`; \
	cd $(ABS_BUILD)/$(GLIBC_NAME); \
	echo 'int main(){}' > dummy.c; \
	$(ABS_TOOLS)/bin/$(TARGET)-gcc dummy.c; \
	readelf -l a.out | grep ": /$$ldlinux" && \
	rm -v dummy.c a.out && \
	touch $(ABS_BUILD)/$(GLIBC_NAME)/.test

libstdc++-v3-stage1: $(ABS_BUILD)/libstdc++-v3 \
	$(ABS_BUILD)/libstdc++-v3/Makefile \
	$(ABS_BUILD)/libstdc++-v3/src/libstdc++.la \
	$(ABS_TOOLS)/lib/libstdc++.la

$(ABS_BUILD)/libstdc++-v3:
	mkdir -p $(ABS_BUILD)/libstdc++-v3

$(ABS_BUILD)/libstdc++-v3/Makefile:
	cd $(ABS_BUILD)/libstdc++-v3; \
	$(ABS_SOURCES)/$(GCC_NAME)/libstdc++-v3/configure --prefix=$(TOOLS) --host=$(TARGET) \
	--disable-multilib --disable-nls --disable-libstdcxx-threads --disable-libstdcxx-pch \
	--with-gxx-include-dir=$(TOOLS)/$(TARGET)/include/c++/$(GCC_VERSION)

$(ABS_BUILD)/libstdc++-v3/src/libstdc++.la:
	cd $(ABS_BUILD)/libstdc++-v3; \
	make
	
$(ABS_TOOLS)/lib/libstdc++.la:
	cd $(ABS_BUILD)/libstdc++-v3; \
        make DESTDIR=$(SYSROOT) install

build-stage2: binutils-stage2 gcc-stage2

binutils-stage2: $(ABS_BUILD)/$(BINUTILS_NAME)-stage2 \
	$(ABS_BUILD)/$(BINUTILS_NAME)-stage2/.patch \
	$(ABS_BUILD)/$(BINUTILS_NAME)-stage2/Makefile \
	$(ABS_BUILD)/$(BINUTILS_NAME)-stage2/binutils/ranlib \
	$(ABS_TOOLS)/bin/.$(TARGET)-ranlib-stage2 \
	$(ABS_TOOLS)/bin/ld-new

$(ABS_BUILD)/$(BINUTILS_NAME)-stage2:
	mkdir -p $(ABS_BUILD)/$(BINUTILS_NAME)-stage2

$(ABS_BUILD)/$(BINUTILS_NAME)-stage2/.patch:
	cd $(ABS_SOURCES)/$(BINUTILS_NAME); \
	find $(ABS_PATCH)/$(BINUTILS_NAME)-stage2 -name "*.patch" -exec patch -p1 \< \{\} \;
	cd $(ABS_PATCH)/$(BINUTILS_NAME)-stage2; \
	find -type f -name "*.sh" -exec sh \{\} $(ABS_SOURCES)/$(BINUTILS_NAME) $(ABS_BUILD)/$(BINUTILS_NAME)-stage2 $(TOOLS) $(TARGET) \;
	touch $(ABS_BUILD)/$(BINUTILS_NAME)-stage2/.patch	

$(ABS_BUILD)/$(BINUTILS_NAME)-stage2/Makefile:
	cd $(ABS_BUILD)/$(BINUTILS_NAME)-stage2; \
	CC=$(TARGET)-gcc; \
	AR=$(TARGET)-ar; \
	$(ABS_SOURCES)/$(BINUTILS_NAME)/configure --prefix=$(TOOLS) \
	--with-lib-path=$(LIB) --disable-nls --disable-werror \
	--with-sysroot

$(ABS_BUILD)/$(BINUTILS_NAME)-stage2/binutils/ranlib:
	cd $(ABS_BUILD)/$(BINUTILS_NAME)-stage2; \
	CC=$(TARGET)-gcc; \
	AR=$(TARGET)-ar; \
	make
	
$(ABS_TOOLS)/bin/.$(TARGET)-ranlib-stage2:
	cd $(ABS_BUILD)/$(BINUTILS_NAME)-stage2; \
	CC=$(TARGET)-gcc; \
	AR=$(TARGET)-ar; \
        make DESTDIR=$(SYSROOT) install && \
        touch $(ABS_TOOLS)/bin/.$(TARGET)-ranlib-stage2

$(ABS_TOOLS)/bin/ld-new:
	cd $(ABS_BUILD)/$(BINUTILS_NAME)-stage2; \
	make -C ld clean; \
	make -C ld LIB_PATH=/usr/lib:/lib; \
	cp -v ld/ld-new $(ABS_TOOLS)/bin/

gcc-stage2: $(ABS_BUILD)/$(GCC_NAME)-stage2 \
	$(ABS_BUILD)/$(GCC_NAME)-stage2/.patch \
	$(ABS_BUILD)/$(GCC_NAME)-stage2/Makefile \
	$(ABS_BUILD)/$(GCC_NAME)-stage2/gcc/gcc-ranlib \
	$(ABS_TOOLS)/bin/gcc \
	$(ABS_TOOLS)/bin/cc \
	$(ABS_BUILD)/$(GCC_NAME)-stage2/.test

$(ABS_BUILD)/$(GCC_NAME)-stage2:
	mkdir -p $(ABS_BUILD)/$(GCC_NAME)-stage2

$(ABS_BUILD)/$(GCC_NAME)-stage2/.patch:
	cd $(ABS_SOURCES)/$(GCC_NAME); \
	find $(ABS_PATCH)/$(GCC_NAME)-stage2 -name "*.patch" -exec patch -p1 \< \{\} \;
	cd $(ABS_PATCH)/$(GCC_NAME)-stage2; \
	find -type f -name "*.sh" -exec sh \{\} $(ABS_SOURCES)/$(GCC_NAME) $(ABS_BUILD)/$(GCC_NAME)-stage2 $(TOOLS) $(TARGET) \;
	touch $(ABS_BUILD)/$(GCC_NAME)-stage2/.patch	

$(ABS_BUILD)/$(GCC_NAME)-stage2/Makefile:
	cd $(ABS_BUILD)/$(GCC_NAME)-stage2; \
	CC=$(TARGET)-gcc \
	CXX=$(TARGET)-g++ \
	AR=$(TARGET)-ar \
	RANLIB=$(TARGET)-ranlib \
	$(ABS_SOURCES)/$(GCC_NAME)/configure --prefix=$(TOOLS) \
	--with-local-prefix=$(TOOLS) --enable-languages=c,c++ \
	--with-native-system-header-dir=$(INCLUDE) \
	--disable-libstdcxx-pch --disable-multilib \
	--disable-bootstrap --disable-libgomp

$(ABS_BUILD)/$(GCC_NAME)-stage2/gcc/gcc-ranlib:
	cd $(ABS_BUILD)/$(GCC_NAME)-stage2; \
	make

$(ABS_TOOLS)/bin/gcc:
	cd $(ABS_BUILD)/$(GCC_NAME); \
	make DESTDIR=$(SYSROOT) install

$(ABS_TOOLS)/bin/cc:
	cd $(ABS_TOOLS)/bin; \
	ln -vs gcc cc

$(ABS_BUILD)/$(GCC_NAME)-stage2/.test:
	cd $(ABS_TOOLS); \
	ldlinux=`ls -1 lib/ld-linux.so.*`; \
	cd $(ABS_BUILD)/$(GCC_NAME)-stage2; \
	echo 'int main(){}' > dummy.c; \
	$(ABS_TOOLS)/bin/cc dummy.c; \
	readelf -l a.out | grep ": /$$ldlinux" && \
	rm -v dummy.c a.out && \
	touch $(ABS_BUILD)/$(GCC_NAME)-stage2/.test



.PHONY: clean
clean:
	rm -rf $(ABS_DOWNLOAD)
	rm -rf $(ABS_SOURCES)
	rm -rf $(ABS_TOOLS)
	rm -rf $(ABS_BUILD)



.PHONY: re
re: clean all
