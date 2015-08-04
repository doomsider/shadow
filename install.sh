#!/bin/bash
# Starmade Shadow Install/Upgrade Script
# Place this script in the directory that will contain StarMade.  Be sure to make executable with "chmod +x install.sh".  This script uses git/curl to install Shadow so it will not run without it.
# Usage: ./install.sh

# Find where the script is being ran to determine proper directory structure
SCRIPTPATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)/`basename "${BASH_SOURCE[0]}"`
echo "SCRIPTPATH $SCRIPTPATH"
SCRIPTDIR=${SCRIPTPATH%/*}
echo "SCRIPTDIR $SCRIPTDIR"

if command -v git >/dev/null
then
	echo -e "\nChecking dependency: Git was found\n"
else
	echo -e "\nGit not found script will fail please install it manually or if running Ubuntu 14.04 let the script install dependencies\n"
fi
if command -v curl >/dev/null
then
	echo -e "\nChecking dependency: Curl was found\n"
else
	echo -e "\nCurl not found script will fail please install it manually or if running Ubuntu 14.04 let the script install dependencies\n"
fi
if command -v dos2unix >/dev/null
then
	echo -e "\nChecking dependency: dos2unix was found\n"
else
	echo -e "\nDos2unix not found script will fail please install it manually or if running Ubuntu 14.04 let the script install dependencies\n"
fi
echo -e "\nThis script will install or upgrade Shadow to the current directory if existing install is found it will be copied to /shadow/shadow_backup_timestamp"
echo -e "If you are upgrading keep in mind any custom entries you have created in the script files will be erased please see the directory Shadow for a copy of your old files\n"
read -s -r -p "Press any key to continue..." -n 1 dummy
echo ""
read -p "If your running Ubuntu 14.04 do you wish to have this script install/check dependencies? (You may be prompted for password) [y/N] : " INPUT
echo ""
case $INPUT in
	[YesyesYESYy]* )
		read -p "Would you like to update the repositories with apt-get update (if you don't know the answer to this select y to be sure) [y/N] : " INPUT
		case $INPUT in
			[YesyesYESYy]* )
				sudo apt-get update
		;;
		esac
		echo -e "\nWhen Mysql is installed you MUST set a root password and write it down for when Shadow sets up the Mysql database\n"
		read -s -r -p "Press any key to continue..." -n 1 dummy
		sudo apt-get install screen
		sudo apt-get install default-jre
		sudo apt-get install zip
		sudo apt-get install dos2unix
		sudo apt-get install curl
		sudo apt-get install git
		sudo apt-get install mysql-server libapache2-mod-auth-mysql php5-mysql	
	;;
	* )
		echo "Please make sure all dependencies are installed SCREEN MYSQLJAVA ZIP STARMADE DOS2UNIX CURL GIT"
	;;
esac

if command -v git >/dev/null && command -v curl >/dev/null && command -v dos2unix >/dev/null
then

if [ ! -d "$SCRIPTDIR/shadow" ]
then
	mkdir $SCRIPTDIR/shadow

fi
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

if [ -d "$SCRIPTDIR/modules" ] 
then
	mkdir  $SCRIPTDIR/shadow/shadow_backup_$current_time
	mkdir  $SCRIPTDIR/shadow/shadow_backup_$current_time/modules
	cp $SCRIPTDIR/modules/* $SCRIPTDIR/shadow/shadow_backup_$current_time/modules
else
	mkdir $SCRIPTDIR/modules
fi
if [ -d "$SCRIPTDIR/core" ]
then
	mkdir  $SCRIPTDIR/shadow/shadow_backup_$current_time
	mkdir  $SCRIPTDIR/shadow/shadow_backup_$current_time/core
	cp $SCRIPTDIR/core/* $SCRIPTDIR/shadow/shadow_backup_$current_time/core
	cp $SCRIPTDIR/* $SCRIPTDIR/shadow/shadow_backup_$current_time
else
	mkdir $SCRIPTDIR/core
fi
mkdir $SCRIPTDIR/shadow/shadow_download_$current_time
git clone https://github.com/doomsider/shadow.git $SCRIPTDIR/shadow/shadow_download_$current_time
yes | cp -f $SCRIPTDIR/shadow/shadow_download_$current_time/* $SCRIPTDIR
yes | cp -f $SCRIPTDIR/shadow/shadow_download_$current_time/core/* $SCRIPTDIR/core
yes | cp -f $SCRIPTDIR/shadow/shadow_download_$current_time/modules/* $SCRIPTDIR/modules

if [ ! -d "$SCRIPTDIR/StarMade" ] 
then
	echo ""
	read -p "No Starmade install found would you like to install Starmade now [Y/n] : " INPUT
case $INPUT in
	[NonoNOn]* )
		chmod +x $SCRIPTDIR/shadow.dtsd
		dos2unix $SCRIPTDIR/shadow.dtsd
		echo -e "\nPlease install Starmade before running ./shadow setup to complete install of Shadow\n"
	;;
	* ) 
		mkdir $SCRIPTDIR/StarMade
# Grab the releaseindex as a very long string variable
		releaseindex=$(curl http://files.star-made.org/releasebuildindex)
# Go to the end of the variable at the last .
		newversion=${releaseindex##*.}
# Set the field seperator to new line and then store the chucksums as an array with each element being a line
		OLD_IFS=$IFS
		IFS=$'\n'
		releaseindex=( $(curl http://files.star-made.org$newversion/checksums) )
		IFS=$OLD_IFS
		LINECOUNT=0
		while [ -n "${releaseindex[$LINECOUNT]+set}" ] 
		do
			CURRENTSTRING=${releaseindex[$LINECOUNT]}
			#echo $CURRENTSTRING
# Format the current line by removing everything after the first space and then removing ./ in the beginning of the name		
			cutstring=${CURRENTSTRING%[[:space:]]*}
			cutstring=${cutstring%[[:space:]]*}
			CURRENTFILE=${cutstring/.\//}
# Makes sure directory structure is created if it does not exist for the file write
			if [ ! -f "$SCRIPTDIR/StarMade/$CURRENTFILE" ]; then
				mkdir -p "$SCRIPTDIR/StarMade/$CURRENTFILE"
				rm -r "$SCRIPTDIR/StarMade/$CURRENTFILE"
			fi
			FORMATFILE=${CURRENTFILE// /%20}
			echo -e "\n Downloading $CURRENTFILE"
			curl "http://files.star-made.org$newversion/$FORMATFILE" > "$SCRIPTDIR/StarMade/$CURRENTFILE"
			let LINECOUNT++
		done
		chmod +x $SCRIPTDIR/shadow.dtsd
		dos2unix $SCRIPTDIR/shadow.dtsd
		echo -e "\nStarmade installed, you must go through this setup before Shadow will run properly\n"
		$SCRIPTDIR/shadow.dtsd setup
	;;
	esac
else
	echo -e "\nStarmade found setting up Shadow, you must go through this setup before Shadow will run properly\n"
	chmod +x $SCRIPTDIR/shadow.dtsd
	dos2unix $SCRIPTDIR/shadow.dtsd
	$SCRIPTDIR/shadow.dtsd setup
fi
fi
