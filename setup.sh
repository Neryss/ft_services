minikube start
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
Kubectl apply -f ./srcs/metallb/metallb.yaml

eval $(minikube docker-env)
docker build ./srcs/nginx --rm -t my-nginx
minikube image load my-nginx
Kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
minikube dashboard