# include docker-compose .env file
include .env

.PHONY: build-base

build-base:
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t base:${OPEN5GS_VERSION} ./images/base
