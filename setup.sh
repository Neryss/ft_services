run_metallb()
{
	Kubectl apply -f ./srcs/metallb/namespace.yaml
	Kubectl apply -f ./srcs/metallb/metallb.yaml
	Kubectl apply -f ./srcs/metallb/config.yaml
}

run_nginx()
{
	eval $(minikube docker-env)
	docker build ./srcs/nginx --rm -t my-nginx
	Kubectl apply -f ./srcs/nginx/nginx.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
}

run_minikube()
{
	minikube start
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
echo "All done !\n Starting dashboard"
minikube dashboard