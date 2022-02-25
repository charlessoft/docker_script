#!/bin/bash
# 开机启动
sudo cp ./supervisord.plist /Library/LaunchDaemons/supervisord.plist
sudo launchctl load /Library/LaunchDaemons/supervisord.plist

