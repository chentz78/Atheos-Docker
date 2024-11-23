bn=atheos

build:
	sudo docker build -t $(bn) - < Dockerfile

rWeb:
	docker run --rm -p 8080:80 -d $(bn)

sWeb:
	docker ps -q --filter ancestor=$(bn) | xargs docker stop

rBash:
	sudo docker run -it $(bn) bash
