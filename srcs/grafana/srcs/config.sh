/usr/bin/grafana-server --homepath=/usr/share/grafana

sleep 5

while [ $(/usr/bin/pgrep grafana-server | wc -l) -gt 0 ]; do
		sleep 2
done