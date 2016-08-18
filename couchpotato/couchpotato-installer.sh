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

#source $SCRIPTPATH/inc/header.sh



UNAME='root'
UGROUP='root'
#source $SCRIPTPATH/couchpotato/couchpotato-constants.sh
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



#echo -e $GREEN'AtoMiC '$APPTITLE' Installer Script'$ENDCOLOR

#source $SCRIPTPATH/inc/pause.sh
pause



#source $SCRIPTPATH/inc/pkgupdate.sh
apt-get update





#source $SCRIPTPATH/inc/app-install-deps.sh
apt-get -y install $APPDEPS




#source $SCRIPTPATH/inc/app-move-previous.sh
sudo /etc/init.d/$APPNAME stop >/dev/null 2>&1
sudo update-rc.d -f $APPNAME remove >/dev/null 2>&1
sudo rm /etc/init.d/$APPNAME >/dev/null 2>&1
sudo rm /etc/default/$APPNAME >/dev/null 2>&1
if [ -d "$APPPATH" ]; then
        MOVEPATH=$APPPATH"_"`date '+%m-%d-%Y_%H-%M'`
        mv $APPPATH $MOVEPATH || { echo 'Could not move exiting '$APPTITLE' folder.' ; exit 1; }
fi




#source $SCRIPTPATH/inc/app-git-download.sh
git clone $APPGIT $APPPATH || { echo -e $RED'Git not found.'$ENDCOLOR ; exit 1; }



#source $SCRIPTPATH/inc/app-set-permissions.sh
chown -R $UNAME:$UGROUP $APPPATH >/dev/null 2>&1
chmod -R 775 $APPPATH >/dev/null 2>&1
chmod -R g+s $APPPATH >/dev/null 2>&1





#source $SCRIPTPATH/inc/app-create-default.sh
APPSHORTNAMEU="${APPSHORTNAME^^}"
DEFAULTFILE=$SCRIPTPATH'/tmp/'$APPNAME'_default'
echo $APPSHORTNAMEU"_HOME="$APPPATH"/" >> $DEFAULTFILE || { echo 'Could not create '$APPTITLE' default file.' ; exit 1; }
echo $APPSHORTNAMEU"_DATA="$APPPATH"/" >> $DEFAULTFILE
echo -e 'Enabling user '$CYAN$UNAME$ENDCOLOR' to run '$APPTITLE'...'
echo $APPSHORTNAMEU"_USER="$UNAME >> $DEFAULTFILE
mv $DEFAULTFILE "/etc/default/"$APPNAME || { echo 'Could not move '$APPTITLE' default file.' ; exit 1; }






cp $APPPATH/init/ubuntu /etc/init.d/couchpotato || { echo $RED'Creating init file failed.'$ENDCOLOR ; exit 1; }
#source $SCRIPTPATH/inc/app-init-add.sh
sudo chown $UNAME:$UGROUP /etc/init.d/$APPNAME
sudo chmod +x /etc/init.d/$APPNAME
sudo update-rc.d $APPNAME defaults



#source $SCRIPTPATH/inc/app-git-stash.sh
cd $APPPATH
git config user.email "mediacenter@mediacenter.com"
git config user.name "Mediacenter"
git stash
git stash clear




#source $SCRIPTPATH/inc/app-set-permissions.sh
chown -R $UNAME:$UGROUP $APPPATH >/dev/null 2>&1
chmod -R 775 $APPPATH >/dev/null 2>&1
chmod -R g+s $APPPATH >/dev/null 2>&1




#source $SCRIPTPATH/inc/app-start.sh
/etc/init.d/$APPNAME start


#source $SCRIPTPATH/inc/app-install-confirmation.sh
#source $SCRIPTPATH/inc/app-access.sh

#source $SCRIPTPATH/inc/thankyou.sh

#source $SCRIPTPATH/inc/exit.sh
pause
