###############################################################################

# This script tests the swapon, swapoff tools 

#Example:
# $ sh test_swapon.sh 

################################################################################
#!/bin/bash
    
#swapon, swapoff
# Testing swapon and swapoff
swapon -V
status=$?
if test $status -eq 0
then
    echo "command swapon -V [PASS]"
else
    echo "command swapon -V [FAIL]"
    exit
fi

swapoff -V
status=$?
if test $status -eq 0
then
    echo "command swapoff -V [PASS]"
else
    echo "command swapoff -V [FAIL]"
    exit
fi


beforeswap=$( free -m | grep Swap | awk '{print $2}' )
echo -e "\033[31m "before swap,the swap total size " $beforeswap \033[0m"
dd if=/dev/zero of=/home/swap bs=1024 count=512000 >/dev/null 2>&1

mkswap /home/swap >/dev/null 2>&1
status=$?
if test $status -eq 0
then
    echo "command mkswap  [PASS]"
else
    echo "command mkswap  [FAIL]"
    exit
fi

swapon /home/swap >/dev/null 2>&1
if test $status -eq 0
then
    echo "command swapon  [PASS]"
else
    echo "command swapon  [FAIL]"
    exit
fi

enableswap=$( free -m | grep Swap | awk '{print $2}' )
echo -e "\033[31m "after enable swap ,swap total size " $enableswap \033[0m"

echo "swapon -s..."
swapon -s

if test $status -eq 0
then
    echo "command swapon -s  [PASS]"
else
    echo "command swapon -s  [FAIL]"
    exit
fi

swapoff /home/swap

if test $status -eq 0
then
    echo "command swapoff   [PASS]"
else
    echo "command swapoff  [FAIL]"
    exit
fi

disableswap=$( free -m | grep Swap | awk '{print $2}' )
echo -e "\033[31m "after disable swap ,swap total size " $disableswap \033[0m"
