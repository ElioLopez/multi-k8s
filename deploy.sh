docker build -t eliolopez/multi-client:latest -t eliolopez/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eliolopez/multi-server:latest -t eliolopez/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eliolopez/multi-worker:latest -t eliolopez/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push eliolopez/multi-client:latest
docker push eliolopez/multi-server:latest
docker push eliolopez/multi-worker:latest

docker push eliolopez/multi-client:$SHA
docker push eliolopez/multi-server:$SHA
docker push eliolopez/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eliolopez/multi-server:$SHA
kubectl set image deployments/client-deployment client=eliolopez/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eliolopez/multi-worker:$SHA
