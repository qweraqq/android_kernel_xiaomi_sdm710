#!/bin/bash

# git clone https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-r445002 --depth=1 --single-branch --no-tags -b 12.0 /opt/clang-r445002
# git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b android-10.0.0_r47 --depth=1 --single-branch --no-tags /opt/aarch64-linux-android-4.9
# git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 -b android-10.0.0_r47 --depth=1 --single-branch --no-tags /opt/arm-linux-androideabi-4.9
CLANG=/opt/clang-r445002/bin
GCC32=/opt/arm-linux-androideabi-4.9/bin
GCC64=/opt/aarch64-linux-android-4.9/bin
export LD_LIBRARY_PATH=/opt/clang-r445002/lib64:/usr/local/lib:$LD_LIBRARY_PATH
PATH=$CLANG:$GCC64:$GCC32:$PATH
export PATH
export ARCH=arm64
export CLANG_TRIPLE=aarch64-linux-gnu
export CROSS_COMPILE=aarch64-linux-android-
export CROSS_COMPILE_ARM32=arm-linux-androideabi-


output_dir=out
make ARCH=arm64 O="$output_dir" sdm670-perf_defconfig xiaomi/sdm710-common.config xiaomi/sirius.config
make ARCH=arm64 -j $(nproc) O="$output_dir" CC=clang LOCALVERSION=-perf-g7ebcf4c CONFIG_LOCALVERSION_AUTO=n 
