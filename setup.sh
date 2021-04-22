run_minikube()
{
	minikube start --vm-driver=virtualbox
	minikube addons enable metrics-server
}

build_all()
{
	docker build ./srcs/phpmyadmin --rm -t my-phpmyadmin
	docker build ./srcs/mysql --rm -t my-mysql
	docker build ./srcs/wordpress --rm -t my-wordpress
	docker build ./srcs/nginx --rm -t my-nginx
	docker build ./srcs/grafana --rm -t my-grafana
	docker build ./srcs/influxdb --rm -t my-influxdb
	docker build ./srcs/telegraf --rm -t my-telegraf
	docker build ./srcs/ftps --rm -t my-ftps
}

deploy_all()
{
	kubectl apply -f ./srcs/phpmyadmin/srcs/phpmyadmin.yaml
	kubectl apply -f ./srcs/mysql/srcs/mysql.yaml
	kubectl apply -f ./srcs/wordpress/srcs/wordpress.yaml
	kubectl apply -f ./srcs/nginx/srcs/nginx.yaml
	kubectl apply -f ./srcs/influxdb/srcs/influxdb.yaml
	kubectl apply -f ./srcs/grafana/srcs/grafana.yaml
	kubectl apply -f ./srcs/telegraf/srcs/telegraf.yaml
	kubectl apply -f ./srcs/ftps/srcs/ftps.yaml
}

echo "Starting services"
run_minikube
eval $(minikube docker-env)
./srcs/certif-handler.sh
minikube addons enable metallb
./srcs/metallb.sh $(minikube ip) 2> /dev/null
minikube ip > ./srcs/ftps/ip.txt
minikube ssh "docker login -u ckurt42 -p jesuisunmotdepasse"
build_all
echo "Done building every image"
deploy_all
echo "Done deploying..."
echo "Minikube ip is the following :"
minikube ip
echo "All done !\nStarting dashboard"
minikube dashboard