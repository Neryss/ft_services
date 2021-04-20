telegraf &

while [ $(/usr/bin/pgrep telegraf | wc -l) -gt 0 ]; do
		sleep 2
done