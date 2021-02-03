docker stop aziotskelsandboxdeployer
docker rm aziotskelsandboxdeployer
docker build -t aziotskelsandboxdeployer .
docker volume rm terraform
docker volume create --name terraform
docker run -it --name aziotskelsandboxdeployer -v terraform:/mnt/tfstate --env-file ./dev.env aziotskelsandboxdeployer