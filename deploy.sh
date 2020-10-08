docker build -t namng191/multi-client:latest -t namng191/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t namng191/multi-server:latest -t namng191/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t namng191/multi-worker:latest -t namng191/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push namng191/multi-client:latest
docker push namng191/multi-server:latest
docker push namng191/multi-worker:latest
docker push namng191/multi-client:$SHA
docker push namng191/multi-server:$SHA
docker push namng191/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=namng191/multi-server:$SHA
kubectl set image deployments/client-deployment server=namng191/multi-client:$SHA
kubectl set image deployments/worker-deployment server=namng191/multi-worker:$SHA