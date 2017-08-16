#!/bin/sh

#####################################################################
#main
#####################################################################
chmod +x *
printf "\nCopy i2cdump to /usr/bin ok\n"
cp -f i2cdump /usr/bin
chmod +x /usr/bin/i2cdump
exit 0
