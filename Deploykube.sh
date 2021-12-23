#!/bin/bash
echo "Copying git ssh privatekey"
cp ~/.ssh/gitops ./build/

echo "Setting up vault env variables"

export VAULT_ADDR="http://10.251.4.130:8200"
export VAULT_TOKEN="s.x1AamM90WFLUNJsFAltPEuJw"

vault secrets enable -version=1 -path=secret kv


echo "Starting Minikube"
minikube config set memory 5096
minikube config set kubernetes-version v1.21.3
minikube start 

cp ~/.minikube/ca.crt build/
cp ~/.minikube/profiles/minikube/client.key build/
cp ~/.minikube/profiles/minikube/client.crt build/
cp ~/.kube/config build/


echo "Finished Setting up vault and minikube"
minikube status
vault status
