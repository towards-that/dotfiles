#!/bin/sh

choice=$(printf " Lock\n Suspend\n Logout\n Reboot\n Poweroff" | rofi -dmenu -p "Power")

case "$choice" in
  " Lock") i3lock -c 000000 ;;
  " Suspend") systemctl suspend ;;
  " Logout") i3-msg exit ;;
  " Reboot") systemctl reboot ;;
  " Poweroff") systemctl poweroff ;;
esac

