#!/bin/bash

./scripts/kconfig/merge_config.sh -m arch/arm64/configs/defconfig arch/arm64/configs/distro.config arch/arm64/configs/estuary_defconfig 
mv -f .config .merged.config

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- KCONFIG_ALLCONFIG=.merged.config alldefconfig
#make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-   hisilicon/hip07-d05-2p.dtb  -j40

#scp -r arch/arm64/boot/Image kongxinwei@192.168.1.107:/home/hisilicon/ftp/kongxinwei/Image_d05
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- distclean
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image -j80
make binrpm-pkg LOCALVERSION=tao -j64 INSTALL_MOD_STRIP=1
  491  vncserver -kill :4
  492  vncserver :4
 1411  make binrpm-pkg LOCALVERSION=tao -j64 INSTALL_MOD_STRIP=1
 
 
 
 
 
 
 
 
 591  wget https://raw.githubusercontent.com/open-estuary/estuary/master/configs/auto-install/centos/auto-iso/ks-iso.cfg
  592  wget https://raw.githubusercontent.com/open-estuary/estuary/master/configs/auto-install/centos/auto-iso/grub.cfg

 
 set_docker_loop()
{
    seq 0 7 | xargs -I {} mknod -m 660 /dev/loop{} b 7 {} || true
    chgrp disk /dev/loop[0-7]
}

 tar cf - . | (cd /root/makeiso; tar xf -)
 
 
yum install createrepo m4 gcc net-tools bc xmlto asciidoc pciutils-devel rpm-build* squashfs-tools* gettext openssl-devel openssl perl*  bison hmaccalc audit-libs-devel python-devel newt-devel git elfutils-devel zlib-devel binutils-devel make -y


kernel_dir=/root/kernel/kernel
kernel_version=$(make kernelversion)
kernel_abi=`echo ${kernel_version}|cut -d "." -f 1,2`
make mrproper
git archive --format=tar --prefix=linux-${kernel_abi}/ HEAD | xz --threads=0 -c > linux-${kernel_abi}.tar.xz
rpmversion=${kernel_version//-*/}

workspace=/root/temp
 git clone --depth 1 -b master https://github.com/open-estuary/centos-kernel-packages.git
ls
cp -rf centos-kernel-packages/* .
ls
sed -i "s/\%define rpmversion.*/\%define rpmversion $rpmversion/g" SPECS/kernel-aarch64.spec
sed -i "s/\%define pkgrelease.*/\%define pkgrelease estuary.${build_num}/g" SPECS/kernel-aarch64.spec
sed -i "s/\%define signmodules 1/\%define signmodules 0/g" SPECS/kernel-aarch64.spec
sed -i "s/\%{gitrelease}/\%{pkgrelease}/g" SPECS/kernel-aarch64.spec
sed -i "s/mv linux-\%{rheltarball}/mv linux-\*/g" SPECS/kernel-aarch64.spec
sed -i "s/^BuildRequires: openssl$/BuildRequires: openssl-devel/g" SPECS/kernel-aarch64.spec
sed -i "s/0.0.0/0.0.1/g" SPECS/kernel-aarch64.spec
cp -f ${kernel_dir}/linux-${kernel_abi}.tar.xz SOURCES/linux-${rpmversion}-tiantao.tar.xz
cd SOURCES/
ls
vim config-local
wget https://raw.githubusercontent.com/open-sailing/kernel/kernel4.18/arch/arm64/configs/defconfig
mv defconfig config-local
cd ..
rpmbuild --nodeps --define "%_topdir `pwd`" -bs SPECS/kernel-aarch64.spec
echo $workspace
  rpmbuild --define "%_topdir ${workspace}" --rebuild SRPMS/kernel-aarch64-4.18.0-tiantao.src.rpm
ls
cd ${dest_dir} && mkisofs -quiet -o /root/tiantao.iso -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -R -J -V 'CentOS 7 aarch64' -T .
 docker run --privileged=true -it --net=host --rm -v /root/test:/root/share buildrpm:latest /bin/bash
 docker run --privileged=true -it  -v /root/test:/root/share buildrpm:latest /bin/bash
  docker run -it-v /root/test:/root/share buildrpm:latest /bin/bash
 
