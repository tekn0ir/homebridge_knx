DOCKER_IMAGE=homebridge_knx
HUB=tekn0ir
VERSION=latest
UID=$(shell id -u $(USER))
DGID=999

build:
	docker build -t $(HUB)/$(DOCKER_IMAGE):$(VERSION) .

run:
	docker run --rm -ti -e DOCKER_GID=$(DGID) -e USER_ID=$(UID) \
	-p 3000:3000 \
	-p 5353:5353 \
	-p 51826:51826 \
	-v `pwd`/sample_configs:/home/docker/.homebridge \
	$(HUB)/$(DOCKER_IMAGE):latest

start:
	docker run -d --name bridge -e DOCKER_GID=$(DGID) -e USER_ID=$(UID) \
	-p 3000:3000 \
	-p 5353:5353 \
	-p 51826:51826 \
	-v `pwd`/sample_configs:/home/docker/.homebridge \
	$(HUB)/$(DOCKER_IMAGE):latest

stop:
	docker stop slave
	docker rm slave

shell:
	docker run --rm -ti -e DOCKER_GID=$(DGID) -e USER_ID=$(UID) -v `pwd`/sample_configs:/home/docker/.homebridge $(HUB)/$(DOCKER_IMAGE):latest /bin/bash

push:
	docker push $(HUB)/$(DOCKER_IMAGE):$(VERSION)
