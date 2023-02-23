# Script to continiously capture my screen on Mac OS X

This script captures my screen on my MacBook Pro every 10 seconds. 

It uses python (with pjobjc-binding) to check if the screen is locked/off and doesn't take screenshots then.
This is clearly a hack. Use with caution.

The images are resized and compressed with imagemagick.

To allow the script to capture the screen(s) when started from launchd, permission for screen recordings needs to be given to

```
+ /bin/bash
+ /usr/sbin/screencapture
+ /System/Library/CoreServices/launchd
```

Copy continous_screencapture.plist to ```~/Library/LaunchAgents/```to 'install the background job'.
To start it immediately use ```launchctl load ~/Library/LaunchAngents/continous_screencapture.plist```