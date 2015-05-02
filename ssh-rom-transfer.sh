#!/bin/bash
# -----------------------------------------------------------------------
# Author: 	    Michael DeGuzis
# Git:		      https://github.com/ProfessorKaos64/SteamOS-Tools
# Scipt Name: 	ssh-rom-transfer.sh
# Script Ver: 	0.1.1
# Description:	This script dumps ROMs over SSH
#
# Usage:	      ./ssh-rom-transfer.sh
# ------------------------------------------------------------------------

# prereqs

	clear
	# Adding repositories
	PKG="openssh-server"
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $PKG | grep "install ok installed")
	
	if [ "" == "$PKG_OK" ]; then
		echo -e "$PKG not found. Setting up $PKG."
		sleep 1s
		sudo apt-get install $PKG
	else
		echo -e "Checking for $PKG [Ok]"
		sleep 0.2s
	fi


echo -e "\nEnter Remote User: [ENTER to use last: $user]"

# set tmp var for last run, if exists
user_tmp="$user"
if [[ "$user" == "" ]]; then
	# var blank this run, get input
	read user
else
	read user
	# user chose to keep var value from last
	if [[ "$user" == "" ]]; then
		user="$user_tmp"
	else
		# keep user choice
		user="$user"
	fi
fi


echo -e "\nEnter remote hostname: [ENTER to use last: $host]"
# set tmp var for last run, if exists
host_tmp="$host"
if [[ "$host" == "" ]]; then
	# var blank this run, get input
	read host
else
	read host
	# user chose to keep var value from last
	if [[ "$host" == "" ]]; then
		user="$host_tmp"
	else
		# keep user choice
		user="$host"
	fi
fi

echo -e "\nEnter remote DIR: [ENTER to use last: $remote_dir]:"
echo -e "(use quotes on any single DIR name with spaces)"
# set tmp var for last run, if exists
remote_dir_tmp="$remote_dir"
if [[ "$remote_dir" == "" ]]; then
	# var blank this run, get input
	read remote_dir
else
	read remote_dir
	# user chose to keep var value from last
	if [[ "$remote_dir" == "" ]]; then
		remote_dir="$remote_dir_tmp"
	else
		# keep user choice
		remote_dir="$remote_dir"
	fi
fi

# Show remote list first
echo -e "\nShowing remote listing first...press q to quit listing\n"
sleep 2s

ssh ${user}@${host} ls -l ${remote_dir} | less

echo -e "\nEnter target ROM DIR to copy [ENTER to last: $target_dir]:"
echo -e "(use quotes on any single DIR name with spaces)"
# set tmp var for last run, if exists
target_dir_tmp="$target_dir"
if [[ "$target_dir" == "" ]]; then
	# var blank this run, get input
	read target_dir
else
	read target_dir
	# user chose to keep var value from last
	if [[ "$target_dir" == "" ]]; then
		remote_dir="$target_dir_tmp"
	else
		# keep user choice
		target_dir="$target_dir"
	fi
fi

# set globbed path
full_path=$(echo "$remote_dir/$target_dir")

# copy ROMs
echo -e "\nExecuting CMD: sudo scp -r $user@$host:'$full_path' /home/steam/ROMs/temp"
sleep 1s

# set cmd
CMD=$(echo "sudo scp -r $user@$host:'${full_path}' /home/steam/ROMs")

# execute
echo ""
$CMD
echo ""

# export vars for next run until system reboot
export user
export host
export remote_dir
export target_dir
