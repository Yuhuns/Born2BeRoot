#!bin/bash
arch=$(uname -a)
pcpu=$(nproc)
vcpu=$(grep 'processor' /proc/cpuinfo | wc -l)
memuse=$(free -m | grep Mem | awk '{ printf("%i/%iMB (%.2f%%)\n", $3, $2, $3/$2 * 100.0) }')
diskuse=$(df -lh --total | grep total | awk '{ printf("%.1f/%.1fGb (%s)\n", $3, $2, $5); }')
cpuload=$(mpstat | grep "all " | awk '{ printf("%.2f%%\n", 100-$13) }')
lastboot=$(who -b | awk '{ printf("%s %s", $3, $4) }')
lvm=$(lsblk | grep lvm -c | awk '{ if ($1 >= 1) { print("yes") } else { print("no") }}')
conntcp=$(netstat | grep -c ESTABLISHED)
userlog=$(who | wc -l | awk '{ print $1; }')
netip=$(hostname -I | awk '{ print $1 }')
cmdsudo=$(cat /var/log/sudo/sudo.log | wc -l | awk '{ print $1 }' )
mac=$(ip a | grep link/ether | awk '{ print $2 }')

wall "
------------------------------------------------ awallet ----------------------------------
  ____                   ___  ____       _____             _   
 |  _ \                 |__ \|  _ \     |  __ \           | |  
 | |_) | ___  _ __ _ __    ) | |_) | ___| |__) |___   ___ | |_ 
 |  _ < / _ \| '__| '_ \  / /|  _ < / _ \  _  // _ \ / _ \| __|
 | |_) | (_) | |  | | | |/ /_| |_) |  __/ | \ \ (_) | (_) | |_ 
 |____/ \___/|_|  |_| |_|____|____/ \___|_|  \_\___/ \___/ \__|

------------------------------------------ monitoring.sh ----------------------------------
   #Architecture: $arch 
   #CPU physical: $pcpu
   #vCPU: $vcpu
   #Memory Usage: $memuse
   #Disk Usage: $diskuse
   #CPU Load: $cpuload
   #Last boot: $lastboot
   #LVM use: $lvm
   #Connections TCP: $conntcp ESTABLISHED
   #User log: $userlog
   #Network: IP $netip ($mac)
   #Sudo: $cmdsudo cmd
-------------------------------------------------------------------------------------------"
