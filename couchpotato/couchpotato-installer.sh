#!/bin/bash
# Script Name: AtoMiC CouchPotato Installer
# Author: htpcBeginner
# Publisher: http://www.htpcBeginner.com
# License: MIT License (refer to README.md for more details)
#

# DO NOT EDIT ANYTHING UNLESS YOU KNOW WHAT YOU ARE DOING.

#source $SCRIPTPATH/inc/commons.sh


function pause(){
   read -p "$*"
}

APPNAME='couchpotato'
APPSHORTNAME='cp'
APPPATH='/home/'$UNAME'/.couchpotato'
APPTITLE='CouchPotato'
APPDEPS='git-core python python-cheetah python-pyasn1'
APPGIT='https://github.com/RuudBurger/CouchPotatoServer.git'
APPDPORT='5050'
APPSETTINGS=$APPPATH'/settings.conf'
PORTSEARCH='port = '
USERSEARCH='username = '
PASSSEARCH='password = '
# New password unencrypted
APPNEWPASS='atomic'
# New password encrypted
NEWPASS='23d33884d600e542d097cd3933df2ae4'


#source $SCRIPTPATH/inc/header.sh

#source $SCRIPTPATH/couchpotato/couchpotato-constants.sh

#echo -e $GREEN'AtoMiC '$APPTITLE' Installer Script'$ENDCOLOR

#source $SCRIPTPATH/inc/pause.sh
pause
#source $SCRIPTPATH/inc/pkgupdate.sh
apt-get update
#source $SCRIPTPATH/inc/app-install-deps.sh
apt-get -y install $APPDEPS
#source $SCRIPTPATH/inc/app-move-previous.sh
/etc/init.d/$APPNAME stop >/dev/null 2>&1
sudo update-rc.d -f $APPNAME remove >/dev/null 2>&1
sudo rm /etc/init.d/$APPNAME >/dev/null 2>&1
sudo rm /etc/default/$APPNAME >/dev/null 2>&1
MOVEPATH=$APPPATH"_"`date '+%m-%d-%Y_%H-%M'`
mv $APPPATH $MOVEPATH

#source $SCRIPTPATH/inc/app-git-download.sh
git clone $APPGIT $APPPATH

source $SCRIPTPATH/inc/app-create-default.sh

sudo cp $APPPATH/init/ubuntu /etc/init.d/couchpotato || { echo $RED'Creating init file failed.'$ENDCOLOR ; exit 1; }
source $SCRIPTPATH/inc/app-init-add.sh

source $SCRIPTPATH/inc/app-git-stash.sh
source $SCRIPTPATH/inc/app-set-permissions.sh
source $SCRIPTPATH/inc/app-start.sh
source $SCRIPTPATH/inc/app-install-confirmation.sh
source $SCRIPTPATH/inc/thankyou.sh
source $SCRIPTPATH/inc/exit.sh
