docker build -t dvaqueiro/multi-client:latest -t dvaqueiro/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dvaqueiro/multi-server:latest -t dvaqueiro/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dvaqueiro/multi-worker:latest -t dvaqueiro/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dvaqueiro/multi-client:latest
docker push dvaqueiro/multi-server:latest
docker push dvaqueiro/multi-worker:latest

docker push dvaqueiro/multi-client:$SHA
docker push dvaqueiro/multi-server:$SHA
docker push dvaqueiro/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dvaqueiro/multi-server:$SHA
kubectl set image deployments/client-deployment client=dvaqueiro/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dvaqueiro/multi-worker:$SHA
