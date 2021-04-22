rc-service vsftpd start

sleep 5

while [ $(/usr/bin/pgrep vsftpd | wc -l) -gt 0 ]; do
		sleep 2
done