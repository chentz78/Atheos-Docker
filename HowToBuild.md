While in the directory with the DockerFile
Login:	`docker login -u hlsiira`
Build:	`docker build -t atheos .` ** This will take a reasonable chunk of time
Tag:	`docker image tag atheos hlsiira/atheos:latest`
Push:	`docker image push hlsiira/atheos:latest`

