build:
	echo 1

install:
	echo "install jq"

quick:
	make clean
	./bin/kubectl create -n tendermint -f test/deployment-k8s.yaml

clean:
	./bin/kubectl delete -n tendermint services,deployments -l app=tendermint

.PHONY: build install quick clean	
