#!/bin/bash

# sudo apt install createrepo yum.utils

#set -x

TOPDIR=$(realpath $0)
TOPDIR=$(dirname $TOPDIR)

date=`date +%Y%m%d`
log_file="${TOPDIR}/log/sync_centos7.$date.log" #同步日志文件，请根据实际情况进行修改

echo "---- $Date `date` Begin ----" >>$log_file
cd ${TOPDIR}/repo #本地软件源目目录，请根据实际情况进行修改
#reposync -m -c ${TOPDIR}/yum.conf -n -a aarch64 --source  >> $log_file 2>&1
reposync -m -g -d -c ${TOPDIR}/yum.conf -n -a aarch64 --source  >> $log_file 2>&1
#从上游源同频软件包及软件分组信息：
#-m选项指明需下载软件分组信息文件——comps.xml,
#-c选项指明上游源的配置文件
#-n选项指明只下载最新的软件包
for file in `ls`; do
  if [ -d $file ]; then
    if [ -f ./$file/comps.xml ]; then
      createrepo -g comps.xml --update ./$file >> $log_file 2>&1 #如果存在comps.xml文件，则创建含软件分组信息的本地包索引信息
    else
      createrepo --update ./$file >> $log_file 2>&1
    fi
  fi
done
#createrepo ./ >> $log_file 2>&1
echo "---- $Date `date` End ----" >>$log_file
