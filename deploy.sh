docker build -t ElioLopez/multi-client:latest -t ElioLopez/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ElioLopez/multi-server:latest -t ElioLopez/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ElioLopez/multi-worker:latest -t ElioLopez/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ElioLopez/multi-client:latest
docker push ElioLopez/multi-server:latest
docker push ElioLopez/multi-worker:latest

docker push ElioLopez/multi-client:$SHA
docker push ElioLopez/multi-server:$SHA
docker push ElioLopez/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ElioLopez/multi-server:$SHA
kubectl set image deployments/client-deployment client=ElioLopez/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ElioLopez/multi-worker:$SHA
