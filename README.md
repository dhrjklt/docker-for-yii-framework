# Docker-yii
Docker  for development in Yii2 framework 


1. First clone the yii2 repo inside the folder.

2. Create the runtime folder inside the yii2 repo. Give full privileges to assets and runtimefolder.

    chmod 777 runtime
    chmod 777 runtime

3. Inside the docker-yii folder CMD "docker-compose build"

4. After completing the docker build do CMD "docker-compose up"


Important commands: 

1. To check the container is running : sudo docker ps 

2.  To kill the running container : sudo docker kill <CONTAINER ID>

3. To run the same container CMD "docker-compose up" inside docker-yii folder. 
