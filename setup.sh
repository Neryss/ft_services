run_metallb()
{
	Kubectl apply -f ./srcs/metallb/namespace.yaml
	Kubectl apply -f ./srcs/metallb/metallb.yaml
	Kubectl apply -f ./srcs/metallb/config.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
}

run_nginx()
{
	docker build ./srcs/nginx/ --rm -t my-nginx
	Kubectl apply -f ./srcs/nginx/srcs/nginx.yaml
}

run_wordpress()
{
	docker build ./srcs/wordpress --rm -t my-wordpress
	Kubectl apply -f ./srcs/wordpress/srcs/wordpress.yaml
}

run_mariadb()
{
	docker build ./srcs/mysql --rm -t my-mysql
	kubectl apply -f ./srcs/mysql/srcs/mysql.yaml
}

run_phpmyadmin()
{
	docker build ./srcs/phpmyadmin --rm -t my-phpmyadmin
	kubectl apply -f ./srcs/phpmyadmin/srcs/phpmyadmin.yaml
}

run_minikube()
{
	minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-65535
	minikube addons enable metrics-server
}

echo "Starting services"
run_minikube
eval $(minikube docker-env)
minikube ssh "docker login -u gapoulai -p motdepassesupersafe"
echo "Setting up metallb..."
run_metallb
echo "Setting up nginx..."
run_nginx
echo "Setting up mariadb..."
run_mariadb
echo "Setting up phpmyadmin..."
run_phpmyadmin
echo "Setting up wordpress..."
run_wordpress
echo "Minikube ip is the following :\n"
minikube ip
echo "All done !\n Starting dashboard"
minikube dashboard