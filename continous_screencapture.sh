#!/bin/bash

# This script will take a screenshots and save them to a folder
# launchd will start it every 10 seconds

# Set the folder to save the screenshots to
folder="$HOME/Screencaptures"
# if folder does not exist, create it
if [ ! -d "$folder" ]; then
    mkdir -p "$folder"
fi

# are the displays locked or off?
# if so, exit
# if [[ $(ioreg -n AppleBacklightDisplay | grep -i IODisplayWrangler | grep -i -c "DevicePowerState=0") -eq 2 ]]; then
#     echo "Displays are locked or off, exiting"
#     exit
# fi

python3 -c 'import sys,Quartz; d=Quartz.CGSessionCopyCurrentDictionary(); sys.exit(d and d.get("CGSSessionScreenIsLocked", 0) == 0 and d.get("kCGSSessionOnConsoleKey", 0) == 1)'
if [ $? -eq 0 ]; then
    echo "Displays are locked or off, exiting"
    exit
fi


# current date + time
now=$(date +"%Y-%m-%d_%H-%M-%S")

/usr/sbin/screencapture -D 1 $folder/sc-d1.jpg
/usr/sbin/screencapture -D 2 $folder/sc-d2.jpg
/usr/local/bin/magick $folder/sc-d1.jpg -resize 1200x800 -strip -interlace Plane -sampling-factor 4:2:0 -quality 65% $folder/$now-sc-d1.jpg
/usr/local/bin/magick $folder/sc-d2.jpg -resize 1200x800 -strip -interlace Plane -sampling-factor 4:2:0 -quality 65% $folder/$now-sc-d2.jpg

# Delete everything older than 3 das
find "$folder" -type f -mtime +3 -exec rm {} \;

