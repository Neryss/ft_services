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
}

deploy_all()
{
	kubectl apply -f ./srcs/phpmyadmin/srcs/phpmyadmin.yaml
	kubectl apply -f ./srcs/mysql/srcs/mysql.yaml
	kubectl apply -f ./srcs/wordpress/srcs/wordpress.yaml
	kubectl apply -f ./srcs/nginx/srcs/nginx.yaml
	Kubectl apply -f ./srcs/metallb/namespace.yaml
	Kubectl apply -f ./srcs/metallb/metallb.yaml
	Kubectl apply -f ./srcs/metallb/config.yaml
	kubectl apply -f ./srcs/grafana/srcs/grafana.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
}

echo "Starting services"
run_minikube
eval $(minikube docker-env)
minikube ssh "docker login -u gapoulai -p motdepassesupersafe"
build_all
echo "Done building every image"
deploy_all
echo "Done deploying..."
echo "Minikube ip is the following :"
minikube ip
echo "All done !\n Starting dashboard"
minikube dashboard