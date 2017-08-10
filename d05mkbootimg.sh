#!/bin/bash

#./scripts/kconfig/merge_config.sh -m arch/arm64/configs/defconfig arch/arm64/configs/estuary_defconfig 
#mv -f .config .merged.config
#export PATH=$PATH:/opt/gcc-linaro-aarch64-linux-gnu-4.9-2014.09_linux/bin/

./scripts/kconfig/merge_config.sh -m arch/arm64/configs/defconfig arch/arm64/configs/distro.config arch/arm64/configs/estuary_defconfig
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- distclean
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- suse_defconfig 
#make  plinth_defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig 
#make Image -j80
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image -j80 2>&1 | tee make.log
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- modules -j80 LOCALVERSION=tao 2>&1 | tee make.log
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- hisilicon/hi6220-hikey.dtb
#scp -r arch/arm64/boot/Image tiantao@192.168.1.107:/home/hisilicon/ftp/tiantao/Image_D05


echo 10       4       1      7 > /proc/sys/kernel/printk
make binrpm-pkg LOCALVERSION=tao -j64 INSTALL_MOD_STRIP=1
