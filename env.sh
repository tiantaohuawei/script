#!/bin/bash

PATH=/home/ubuntu/toolchain/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux/bin:$PATH
PATH=/opt/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin:$PATH
PATH=/opt/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux/bin:$PATH
ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu-

export PATH CROSS_COMPILE ARCH
