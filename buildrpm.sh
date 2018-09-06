#!/bin/bash
set -ex
kernel_dir=/root/kernel/kernel
kernel_version=$(make kernelversion)
kernel_abi=`echo ${kernel_version}|cut -d "." -f 1,2`
make mrproper
git archive --format=tar --prefix=linux-${kernel_abi}/ HEAD | xz --threads=0 -c > linux-${kernel_abi}.tar.xz
rpmversion=${kernel_version//-*/}
workspace=/root/temp
cd ..
sed -i "s/\%define rpmversion.*/\%define rpmversion $rpmversion/g" SPECS/kernel-aarch64.spec
sed -i "s/\%define pkgrelease.*/\%define pkgrelease tiantao/g" SPECS/kernel-aarch64.spec
sed -i "s/\%define signmodules 1/\%define signmodules 0/g" SPECS/kernel-aarch64.spec
sed -i "s/\%{gitrelease}/\%{pkgrelease}/g" SPECS/kernel-aarch64.spec
sed -i "s/mv linux-\%{rheltarball}/mv linux-\*/g" SPECS/kernel-aarch64.spec
sed -i "s/^BuildRequires: openssl$/BuildRequires: openssl-devel/g" SPECS/kernel-aarch64.spec
sed -i "s/0.0.0/0.0.1/g" SPECS/kernel-aarch64.spec
cp -f ${kernel_dir}/linux-${kernel_abi}.tar.xz SOURCES/linux-${rpmversion}-tiantao.tar.xz

rpmbuild --nodeps --define "%_topdir `pwd`" -bs SPECS/kernel-aarch64.spec
echo $workspace
rpmbuild --define "%_topdir ${workspace}" --rebuild SRPMS/*.src.rpm

