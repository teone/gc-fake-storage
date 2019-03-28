# Configure shell
SHELL = bash -e -o pipefail

# Variables
VERSION                  ?= $(shell cat ./VERSION)
SERVICE_NAME             ?= gc-fake-storage

## Docker related
DOCKER_REGISTRY          ?=
DOCKER_REPOSITORY        ?= matteoscandolo/
DOCKER_TAG               ?= ${VERSION}
DOCKER_IMAGENAME         := ${DOCKER_REGISTRY}${DOCKER_REPOSITORY}${SERVICE_NAME}:${DOCKER_TAG}

all: build

build:
	docker build -t ${DOCKER_IMAGENAME} .

push:
	docker push ${DOCKER_IMAGENAME}

run:
	docker run -d --name ${SERVICE_NAME} -p 4443:4443 ${DOCKER_IMAGENAME}

stop:
	docker rm -f ${SERVICE_NAME}
