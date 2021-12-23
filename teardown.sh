#!/bin/bash


echo "Clearing minikube data"
minikube stop
minikube delete --all --purge
rm -rf ~/.kube
rm -rf ~/.minikube
rm -rf platforms/hyperledger-fabric/configuration/build

echo "Clearing Docker data"
docker system prune -a
docker volume prune 

echo "Clearing Vault data"
rm -r ./vault/*

echo "Clearing BAF Data"

rm -r ./platforms/hyperledger-fabric/releases/*
cd ./build
shopt -s extglob  
rm -rf !(network.yaml)       
cd ..
rm -r ./cert/*



echo "##### Cleared All Data ######"

##### git push directory #####

now=$(date +"%T")

echo "New git prune commit at : $now"
git add .    
git commit -m "latest prune commit at : $now" || true
git push  

