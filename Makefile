.PHONY: build push check-env

default: build push

build: check-env
	docker build -t najahi/k8s-miner --build-arg XMRIG_VERSION=$(XMRIG_VERSION) .
	docker tag najahi/k8s-miner najahi/k8s-miner:$(XMRIG_VERSION)

push: check-env
	docker push najahi/k8s-miner
	docker push najahi/k8s-miner:$(XMRIG_VERSION)

check-env:
ifndef XMRIG_VERSION
	$(error The XMRIG_VERSION environment variable must be defined)
endif
