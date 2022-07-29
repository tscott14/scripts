#! /bin/bash

# Check to see if it is root running this script, if not, exit
[ "$EUID" -ne 0 ] && echo 'Please run this script as root!' && exit

# Removes pcspkr module.
[ -n "$(lsmod | grep pcspkr)" ] && 
	sudo rmmod pcspkr && 
	echo 'Shutdown pcspkr =)' || 
	echo 'pcspkr NOT currently running =)'

# Makes the change persistent.
[ ! -f /etc/modprobe.d/nobeep.conf ] && 
	echo "blacklist pcspkr" >> /etc/modprobe.d/nobeep.conf &&
	echo 'Disabled pcspkr persistently! =)' || 
	echo 'Already disabled! =)'

# To reenable pcspkr for some unknown reason then run:
# ~$ sudo modprobe pcspkr
# ~$ sudo rm -f /etc/modprobe.d/nobeep.conf
