#!/bin/bash
# Script Name: AtoMiC CouchPotato Installer
# Author: htpcBeginner
# Publisher: http://www.htpcBeginner.com
# License: MIT License (refer to README.md for more details)
#

# DO NOT EDIT ANYTHING UNLESS YOU KNOW WHAT YOU ARE DOING.

UNAME='root'
UGROUP='root'
SCRIPTPATH='/mediacenter/docker-proj'
if [ ! -d "$SCRIPTPATH/tmp" ]; then
        mkdir $SCRIPTPATH/tmp
fi

if [ ! -d "$SCRIPTPATH/backups" ]; then
        mkdir $SCRIPTPATH/backups
fi






source $SCRIPTPATH/inc/commons.sh

#source $SCRIPTPATH/inc/header.sh


source $SCRIPTPATH/couchpotato/couchpotato-constants.sh

echo -e $GREEN'AtoMiC '$APPTITLE' Installer Script'$ENDCOLOR

source $SCRIPTPATH/inc/pause.sh
source $SCRIPTPATH/inc/pkgupdate.sh
source $SCRIPTPATH/inc/app-install-deps.sh
source $SCRIPTPATH/inc/app-move-previous.sh
source $SCRIPTPATH/inc/app-git-download.sh

source $SCRIPTPATH/inc/app-create-default.sh

sudo cp $APPPATH/init/ubuntu /etc/init.d/couchpotato || { echo $RED'Creating init file failed.'$ENDCOLOR ; exit 1; }
source $SCRIPTPATH/inc/app-init-add.sh

source $SCRIPTPATH/inc/app-git-stash.sh
source $SCRIPTPATH/inc/app-set-permissions.sh
source $SCRIPTPATH/inc/app-start.sh
source $SCRIPTPATH/inc/app-install-confirmation.sh
source $SCRIPTPATH/inc/thankyou.sh
source $SCRIPTPATH/inc/exit.sh
