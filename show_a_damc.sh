#!/usr/bin/expect -f 

set damc [lindex $argv 0];

spawn ssh manage@$damc 

expect "Password: " 
send "!manage\r" 

expect "# " 
send "show sensor-status\r" 

sleep 1

expect "Press any key to continue (Q to quit)" 
send "n\r" 

sleep 1

expect "Press any key to continue (Q to quit)" 
send "n\r" 

#expect "# " 
#send "show fans\r"

#expect "# "
#send "show fenced-data "

expect "# "
send "exit\r" 

exit 
end 

