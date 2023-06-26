# include docker-compose .env file
include .env

.PHONY: build-base-open5gs

build-base-open5gs:
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t base-open5gs:${OPEN5GS_VERSION} ./images/base-open5gs
