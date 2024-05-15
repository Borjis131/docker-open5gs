# include docker-compose .env file
include .env

.PHONY: base-open5gs amf ausf bsf nrf nssf pcf scp sepp smf udm udr upf webui all clean

base-open5gs:
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t base-open5gs:${OPEN5GS_VERSION} ./images/base-open5gs

amf: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t amf:${OPEN5GS_VERSION} ./images/amf

ausf: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t ausf:${OPEN5GS_VERSION} ./images/ausf

bsf: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t bsf:${OPEN5GS_VERSION} ./images/bsf

nrf: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t nrf:${OPEN5GS_VERSION} ./images/nrf

nssf: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t nssf:${OPEN5GS_VERSION} ./images/nssf

pcf: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t pcf:${OPEN5GS_VERSION} ./images/pcf

scp: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t scp:${OPEN5GS_VERSION} ./images/scp

sepp: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t sepp:${OPEN5GS_VERSION} ./images/sepp

smf: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t smf:${OPEN5GS_VERSION} ./images/smf

udm: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t udm:${OPEN5GS_VERSION} ./images/udm

udr: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t udr:${OPEN5GS_VERSION} ./images/udr

upf: base-open5gs
	docker build --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t upf:${OPEN5GS_VERSION} ./images/upf

webui:
	docker build --build-arg NODE_VERSION=${NODE_VERSION} --build-arg OPEN5GS_VERSION=${OPEN5GS_VERSION} -t webui:${OPEN5GS_VERSION} ./images/webui

all: base-open5gs amf ausf bsf nrf nssf pcf scp sepp smf udm udr upf webui

clean:
	docker image remove base-open5gs:${OPEN5GS_VERSION} amf:${OPEN5GS_VERSION} ausf:${OPEN5GS_VERSION} bsf:${OPEN5GS_VERSION} nrf:${OPEN5GS_VERSION} nssf:${OPEN5GS_VERSION} \
	pcf:${OPEN5GS_VERSION} scp:${OPEN5GS_VERSION} sepp:${OPEN5GS_VERSION} smf:${OPEN5GS_VERSION} udm:${OPEN5GS_VERSION} udr:${OPEN5GS_VERSION} upf:${OPEN5GS_VERSION} \
	webui:${OPEN5GS_VERSION}
