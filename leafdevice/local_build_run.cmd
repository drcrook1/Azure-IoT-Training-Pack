docker stop aziotleafdevice
docker rm aziotleafdevice
docker build -t aziotleafdevice .
docker run --name aziotleafdevice --env-file ./dev.env aziotleafdevice