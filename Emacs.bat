Arch.exe run "export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0;eval $(dbus-launch);export DBUS_SESSION_BUS_ADDRESS;emacs"
