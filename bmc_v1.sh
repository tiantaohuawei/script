#!/usr/bin/expect -f 
set timeout 30 
set host "192.168.2.195"
set username "root"
spawn ssh $username@$host
expect {
	 "(yes/no)?" { send "yes\r" ; exp_continue }
 	 "password:" { send "Huawei12#$\r" }
}
expect "iBMC:/->"
send "ipmcset -d powerstate -v 2\r"
expect "Do you want to continue\?\[Y\N\]:"
send "Y\r"
sleep 5
expect "iBMC:/->"
send "ipmcset -d powerstate -v 1\r" 
expect "Do you want to continue\?\[Y\N\]:"
sleep 5
send "Y\r"
expect "iBMC:/->"
send "exit\r"
interact
