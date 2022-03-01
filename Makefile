build:
	echo 1

install:
	echo "install jq"

quick:
	make clean
	./bin/kubectl create -n cbft -f test/deployment-k8s.yaml

clean:
	./bin/kubectl delete -n cbft services,deployments,jobs -l app=chainBFT

clean-xhh:
	./bin/kubectl delete -n tendermint services,deployments,jobs -l app=tendermint

.PHONY: build install quick clean	
