#!/bin/bash
# Script Name: AtoMiC Transmission Daemon Password Reset
# Author: htpcBeginner
# Publisher: http://www.htpcBeginner.com
# License: MIT License (refer to README.md for more details)
#

# DO NOT EDIT ANYTHING UNLESS YOU KNOW WHAT YOU ARE DOING.

if [[ $ISSETUP != "Yes" ]]
then
  echo
  echo -e '\e[91mCannot be run directly. Please run setup.sh from AtoMiC ToolKit root folder: \033[0msudo bash setup.sh'
  echo
  exit 0
fi
source $SCRIPTPATH/inc/commons.sh
source $SCRIPTPATH/inc/header.sh

source $SCRIPTPATH/transmission-daemon/transmission-constants.sh

echo -e $GREEN'AtoMiC '$APPTITLE' Password Reset Script'$ENDCOLOR

source $SCRIPTPATH/inc/pause.sh
source $SCRIPTPATH/inc/app-folder-check.sh
source $SCRIPTPATH/inc/app-settings-check.sh
source $SCRIPTPATH/inc/app-stop.sh

source $SCRIPTPATH/inc/app-user-search.sh
source $SCRIPTPATH/inc/app-password-search.sh

echo
sleep 1
echo -e $YELLOW'--->Getting new '$APPTITLE' WebUI password...'$ENDCOLOR
sleep 3

APPNEWPASS=$(whiptail --title "Reset Transmission WebUI Password" --inputbox "Enter new password and choose Ok to continue." 10 60 3>&1 1>&2 2>&3)
exitstatus=$?

if [ $exitstatus = 0 ]; then
	NEWPASS=$APPNEWPASS'",'
    source $SCRIPTPATH/inc/app-password-reset.sh
    source $SCRIPTPATH/inc/app-start.sh
	source $SCRIPTPATH/inc/app-reset-confirmation.sh
else
    echo
    echo -e $RED'Resetting '$APPTITLE' WebUI password cancelled.'$ENDCOLOR
fi

source $SCRIPTPATH/inc/thankyou.sh
source $SCRIPTPATH/inc/exit.sh
