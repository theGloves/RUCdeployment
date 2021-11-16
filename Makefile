build:
	echo 1

install:
	echo "install jq"

quick:
	make clean
	./bin/kubectl create -n fabric -f fabric.yaml

clean:
	./bin/kubectl delete -n fabric services,deployments -l app=fabric

.PHONY: build install quick clean	
