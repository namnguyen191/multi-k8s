docker build -t namnguyen191/multi-client:latest -t namnguyen191/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t namnguyen191/multi-server:latest -t namnguyen191/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t namnguyen191/multi-worker:latest -t namnguyen191/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# We dont have to log in since we already logged in inside travis
docker push namnguyen191/multi-client:latest
docker push namnguyen191/multi-server:latest
docker push namnguyen191/multi-worker:latest
#TEST

docker push namnguyen191/multi-client:$SHA
docker push namnguyen191/multi-server:$SHA
docker push namnguyen191/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=namnguyen191/multi-server:$SHA
kubectl set image deployments/client-deployment server=namnguyen191/multi-client:$SHA
kubectl set image deployments/worker-deployment server=namnguyen191/multi-worker:$SHA