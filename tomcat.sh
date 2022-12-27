#!/bin/bash

# DIR=/home/docker
# FILE=/home/Dockerfile
# container_name=tomcat9

echo "creating the dir"
mkdir docker && cd docker

echo "cloning a tomcat dir"
sudo git clone https://github.com/him-singh/DevOpsDemo.git
result=$( sudo docker images -q tomcat )
cd DevOpsDemo

echo "build the docker image"
sudo docker build --tag tomcat9 .

echo "built docker images and proceeding to delete existing container"
result=$( docker ps -q -f name=tomcat9 )
if [[ $? -eq 0 ]]; then
echo "Container exists"
sudo docker container rm -f tomcat9
echo "Deleted the existing docker container"
else
echo "No such container"
fi
echo "Deploying the updated container"
sudo docker run -p 8080:8080 -d tomcat9
echo "Deploying the container"