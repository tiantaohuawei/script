echo "ethtool -S"
name=`date +%Y%m%d%k%m%S`
ethtool -S enahisic2i0 > /home/$name.log
echo "ethtool -d"
ethtool -d enahisic2i0 >> /home/$name.log

