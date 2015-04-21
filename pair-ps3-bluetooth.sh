#!/bin/bash
# See: https://github.com/rdepena/node-dualshock-controller/wiki/Pairing-The-Dual-shock-3-controller-in-Linux-(Ubuntu-Debian)

install_prereqs()
{
	
	# Try Pre-req batch
	sudo apt-get -t wheezy install bluez-utils bluez-compat bluez-hcidump \
	checkinstall libusb-dev joystick pyqt4-dev-tools
	
	#libbluetooth-dev
	
	exit
	clear
	# Dialog required for prompts
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' dialog | grep "install ok installed")
	
	if [ "" == "$PKG_OK" ]; then
		echo -e "dialog not found. Installing now...\n"
		sleep 1s
		sudo apt-get install -t wheezy dialog
	else
		echo "Checking for dialog: [Ok]"
		sleep 0.2s
	fi
	
	# libusb-dev required for pairing
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' libusb-dev | grep "install ok installed")
	
	if [ "" == "$PKG_OK" ]; then
		echo -e "libusb-dev not found. Installing now...\n"
		sleep 1s
		sudo apt-get install libusb-dev
	else
		echo "Checking for libusb-dev: [Ok]"
		sleep 0.2s
	fi
	
	# libusb-0.1-4 required for pairing
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' libusb-0.1-4 | grep "install ok installed")
	
	if [ "" == "$PKG_OK" ]; then
		echo -e "libusb-0.1-4 not found. Installing now...\n"
		sleep 1s
		sudo apt-get install libusb-0.1-4
	else
		echo "Checking for libusb-0.1-4: [Ok]"
		sleep 0.2s
	fi	
	
}

main()
{
  
  	clear
	echo -e "==> Downloading sixad...\n"
	sleep 1s
	# These are Debian rebuilt packages from the ppa:falk-t-j/qtsixa PPA
	wget -P /tmp "http://www.libregeek.org/SteamOS-Extra/utilities/sixpair.5.1+git20140130-SteamOS_amd64.deb"
	
	# Install
	echo -e "==> Installing sixad...\n"
	sleep 1s
	sudo dpkg -i "/tmp/sixad_1.5.1+git20130130-SteamOS_amd64.deb"
	
	echo -e "==> Downloading sixpair...\n"
	sleep 1s
	# These are Debian rebuilt packages from the ppa:falk-t-j/qtsixa PPA
	wget -P /tmp "http://www.pabr.org/sixlinux/sixpair.c"
	
	echo -e "==> Building and installing sixpair...\n"
	gcc -o sixpair /tmp/sixpair.c -lusb
	
	# move sixpair binary to /usr/bin to execuate in any location in $PATH
	sudo mv "/tmp/sixpair" "/usr/bin"
	
	#configure and start sixad daemon.
	echo -e "==> Configuring qtsixad and sixad...\n"
	sleep 2s
	sudo update-rc.d sixad defaults
	sudo /etc/init.d/sixad enable
	sudo /etc/init.d/sixad start
  
  	echo -e "==> Configuring controller(s)...\n"
	cmd=(dialog --backtitle "LibreGeek.org RetroRig Installer" \
		    --menu "Please select the number of PS3 controllers" 16 47 16)
	options=(1 "1"
	 	 2 "2"
	 	 3 "3"
	 	 4 "4")

	#make menu choice
	selection=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	#functions
	
	for choice in $selection
	do
		case $choice in
	
		1)
		
		# call pairing function to set current bluetooth MAC to Player 1
		n="1"
		ps3_pair_blu
		dialog --msgbox "Pairing of Player 1 Controller complete" 5 43 
		;;
	
		2)
		
		# call pairing function to set current bluetooth MAC to Player 1
		n="1"
		ps3_pair_blu
		dialog --msgbox "Pairing of Player 1 controller complete" 5 43 
		
		# call pairing function to set current bluetooth MAC to Player 2
		n="2"
		ps3_pair_blu
		dialog --msgbox "Pairing of Player 2 controller complete" 5 43 
		;;
	
		3)
	
		# call pairing function to set current bluetooth MAC to Player 1
		n="1"
		ps3_pair_blu
		dialog --msgbox "Pairing of Player 1 controller complete" 5 43 
	
		# call pairing function to set current bluetooth MAC to Player 2
		n="2"
		ps3_pair_blu
		dialog --msgbox "Pairing of Player 2 controller complete" 5 43 
	
		# call pairing function to set current bluetooth MAC to Player 3
		n="3"
		ps3_pair_blu
		dialog --msgbox "Pairing of Player 3 controller complete" 5 43 
		;;
	
		4)
		# call pairing function to set current bluetooth MAC to Player 1
		n="1"
		ps3_pair_blu
		dialog --msgbox "Pairing of Player 1 controller complete" 5 43 
		
		# call pairing function to set current bluetooth MAC to Player 1
		n="2"
		ps3_pair_blu
		dialog --msgbox "Pairing of Player 2 controller complete" 5 43 
		
		# call pairing function to set current bluetooth MAC to Player 1
		n="3"
		ps3_pair_blu
		dialog --msgbox "Pairing of Player 3 controller complete" 5 43 
		
		# call pairing function to set current bluetooth MAC to Player 1
		n="1"
		ps3_pair_blu
		dialog --msgbox "Pairing of Player 4 controller complete" 5 43 
	
		esac
		
	done
	
	###########################################################
	# End controller pairing process
	###########################################################
	
	# start the service at boot time
	sixad --boot-yes
	
}
	
ps3_pair_blu()
{
	
	dialog --msgbox "Please plug in these items now:\n\n1)The USB cable\n2)PS3 controller $n \n \
	3)Bluetooth dongle\n\nAdditional controllers can be added in the settings menu"  12 40
	
	# Grab player 1 controller MAC Address of wired device
	echo -e "\nSetting up Playstation 3 Sixaxis (bluetooth) [Player $n]\n"
	sleep 2s
	
	# Pair controller with logging 
	# if hardcoded path is needed, sixpair should be in /usr/bin now
	sudo sixpair
	sleep 2s
	
	# Inform player 1 controller user to disconnect USB cord
	dialog --msgbox "Please disconnect the USB cable and press the PS Button now. The appropriate \
	LED for player $n should be lit. If it is not, please hold in the PS button to turn it off, then \
	back on.\n\nThere is no need to reboot to fully enable the controller\(s\)" 12 60
	
	echo -e "\nUsing the left stick and pressing the left and right stick navigate to the Settings Screen 
	and edit the layout of the controller."

}

##################################################### 
# Install prereqs 
##################################################### 
install_prereqs

##################################################### 
# MAIN 
##################################################### 
main | tee log_temp.txt 

##################################################### 
# cleanup 
##################################################### 

# cleanup deb packages
rm -f "/tmp/qtsixa_1.5.1+git20140130-SteamOS_amd64.deb"
rm -f "/tmp/sixad_1.5.1+git20130130-SteamOS_amd64.deb"
rm -f "/tmp/sixpair.c"

# convert log file to Unix compatible ASCII 
strings log_temp.txt > log.txt 

# strings does catch all characters that I could  
# work with, final cleanup 
sed -i 's|\[J||g' log.txt 

# remove file not needed anymore 
rm -f "log_temp.txt" 
