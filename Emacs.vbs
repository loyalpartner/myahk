Set ws = CreateObject("Wscript.Shell")
ws.run "wsl export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0;" &_
            "setxkbmap -option ctrl:swap_rwin_rctl dvorak;" &_
            "xset r rate 300 40;" &_
            "eval $(dbus-launch);" &_
            "export DBUS_SESSION_BUS_ADDRESS;emacs",vbhide
