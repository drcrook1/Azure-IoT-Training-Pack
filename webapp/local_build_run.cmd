docker stop aziotwebapp
docker rm aziotwebapp
docker build -t aziotwebapp .
docker run --name aziotwebapp -p 80:80 --env-file ./dev.env aziotwebapp