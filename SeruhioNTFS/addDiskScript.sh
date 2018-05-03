#!/bin/sh

#  addDiskScript.sh
#  SeruhioNTFS
#
#  Created by Sergio Rozalén Barberán on 3/5/18.
#  Copyright © 2018 Sergio Rozalén Barberán. All rights reserved.

### Script designed to be placed in a "Run Shell Script" action in Automator
### This allows the administrator password to be called, and used in the script where sudo is required
### Beware: the inputted password is used in echo commands
### Usage: Use `sudo` without a path to ensure the `sudo` function is called rather than the actual command

# Dialog Title
dialogTitle="Name of this application"

# obtain the password from a dialog box
authPass=$(/usr/bin/osascript <<EOT
tell application "System Events"
activate
repeat
display dialog "This application requires administrator privileges. Please enter your administrator account password below to continue:" ¬
default answer "" ¬
with title "$dialogTitle" ¬
with hidden answer ¬
buttons {"Quit", "Continue"} default button 2
if button returned of the result is "Quit" then
return 1
exit repeat
else if the button returned of the result is "Continue" then
set pswd to text returned of the result
set usr to short user name of (system info)
try
do shell script "echo test" user name usr password pswd with administrator privileges
return pswd
exit repeat
end try
end if
end repeat
end tell
EOT
)

# Abort if the Quit button was pressed
if [ "$authPass" == 1 ]; then
/bin/echo "User aborted. Exiting..."
exit 0
fi

# function that replaces sudo command
sudo () {
/bin/echo $authPass | /usr/bin/sudo -S "$@"
}

###==========================
### Shell script follows here
###==========================

sudo chmod 777 /etc/fstab
echo hola8 >> /etc/fstab
