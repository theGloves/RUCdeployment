build:
	echo 1

install:
	echo "install jq"

quick:
	make clean
	./bin/kubectl create -n chainbft -f test/deployment-k8s.yaml

clean:
	./bin/kubectl delete -n chainbft services,deployments -l app=chainBFT

.PHONY: build install quick clean	
