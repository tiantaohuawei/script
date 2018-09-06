#!/bin/bash
set -ex
dest_dir=/root/makeiso
kernel_rpm_dir=/root/tiantao/RPMS/aarch64
#kernel_module=/root/tiantao/RPMS/aarch64
kernel_module=
kernel_abi=4.18.0-tiantao
cfg_path=/root/kernel
pushd .
rm -rf /root/makeiso/*
cd /root/iso
tar cf - . | (cd /root/makeiso; tar xf -)
popd
cp -f ${kernel_module}/boot/vmlinuz-${kernel_abi}.aarch64 ${dest_dir}/images/pxeboot/vmlinuz

# Make initrd.img
cd ${dest_dir}/images/pxeboot
mkdir initrd; cd initrd
sh -c 'xzcat ../initrd.img | cpio -d -i -m'
cp -f $cfg_path/ks-iso.cfg .
cp -f $cfg_path/grub.cfg .
rm -rf lib/modules/4.*
cp -rf ${kernel_module}/lib/modules/${kernel_abi}.aarch64 lib/modules/
sh -c 'find . | cpio --quiet -o -H newc --owner 0:0 | xz --threads=0 --check=crc32 -c > ../initrd.img'
cd ..; rm -rf initrd

# Make squashfs.img
cd ${dest_dir}/LiveOS
unsquashfs squashfs.img
mount -o loop squashfs-root/LiveOS/rootfs.img /opt
rm -rf /opt/usr/lib/modules/4.* ${dest_dir}/LiveOS/squashfs.img
cp -rf ${kernel_module}/lib/modules/${kernel_abi}.aarch64 /opt/usr/lib/modules/
umount /opt
mksquashfs squashfs-root/ ${dest_dir}/LiveOS/squashfs.img
rm -rf squashfs-root

# createrepo for kernel packages
cp ${kernel_rpm_dir}/*.rpm ${dest_dir}/Packages
cd ${dest_dir}
xmlfile=`basename repodata/*comps.xml`
cd repodata
mv $xmlfile comps.xml
shopt -s extglob
rm -f !(comps.xml)
find . -name TRANS.TBL|xargs rm -f
cd ${dest_dir}
createrepo -q -g repodata/comps.xml .

# Create the new ISO file.
rm -rf /root/tiantao.iso
cd ${dest_dir} && mkisofs -quiet -o /root/tiantao.iso -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -R -J -V 'CentOS 7 aarch64' -T .
                                                                                                                                                
