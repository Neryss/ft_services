rc-service influxdb start

sleep 5

while [ $(/usr/bin/pgrep influx | wc -l) -gt 0 ]; do
		sleep 2
done