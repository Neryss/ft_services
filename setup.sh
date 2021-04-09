run_metallb()
{
	Kubectl apply -f ./srcs/metallb/namespace.yaml
	Kubectl apply -f ./srcs/metallb/metallb.yaml
	Kubectl apply -f ./srcs/metallb/config.yaml
}

run_nginx()
{
	docker build ./srcs/nginx/ --rm -t my-nginx
	Kubectl apply -f ./srcs/nginx/srcs/nginx.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
}

run_wordpress()
{
	docker build ./srcs/wordpress --rm -t wordpress
	Kubectl apply -f ./srcs/wordpress/srcs/wordpress.yaml
}

run_minikube()
{
	minikube delete --all
	minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-65535
	eval $(minikube docker-env)
	kubectl get configmap kube-proxy -n kube-system -o yaml | \
	sed -e "s/strictARP: false/strictARP: true/" | \
	kubectl apply -f - -n kube-system
}

echo "Starting services"
run_minikube
echo "Setting up metallb..."
run_metallb
echo "Setting up nginx..."
run_nginx
echo "Setting up wordpress..."
run_wordpress
echo "Minikube ip is the following :\n"
minikube ip
echo "All done !\n Starting dashboard"
minikube dashboard