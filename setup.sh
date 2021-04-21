run_minikube()
{
	minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-65535
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
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
}

echo "Starting services"
run_minikube
eval $(minikube docker-env)
./srcs/certif-handler.sh
minikube addons enable metallb
./srcs/metallb.sh $(minikube ip) 2> /dev/null
minikube ssh "docker login -u gapoulai -p motdepassesupersafe"
build_all
echo "Done building every image"
deploy_all
echo "Done deploying..."
echo "Minikube ip is the following :"
minikube ip
echo "All done !\nStarting dashboard"
minikube dashboard