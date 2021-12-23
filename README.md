
# Description
Blockchain automation framework for deploying hyperledger fabric network on a local minikube cluster


# Prerequisites

  Make sure you have the follwing on your local system :- 
  - Python v3.6^
  - node v17^
  - minikube v1.24
  - kubernetes v1.21^
  - Docker 
  - helm v3.7^


use the prereq.sh script in the base directory to install all the other prerequisites

# Getting Started


  - You can use the following link to set up your git repo [Developer guide](https://blockchain-automation-framework.readthedocs.io/en/develop/developer/dev_prereq.html).

  - once you finish setting up the git repo, you can use the following commands to add a new local branch to your machine
  
        git checkout -b local
        git push --set-upstream origin local 


  ###  [ you have to repeat the following steps, each time you deploy the network ]

  - ### Setting up vault server

      - go to the base directory, open a terminal and run the followng command
        
            vault server -config=config.hcl
      
      - This will bring up the server. you can interact with it by opening the browser at http://<local-machine-ip>:8200/
      
      - You can refer this link and initialize the Vault by providing your choice of key shares and threshold [ follow the "setting up hashicorp vault part from step 6] [Developer guide](https://blockchain-automation-framework.readthedocs.io/en/develop/developer/dev_prereq.html).

      - once you get the root token, add it to the VAULT_TOKEN variable in the deploykube.sh script
      - you should add your machine ip to the VAULT_ADDRESS variable in the same script
    
  - ### Editing the network.yaml file
  
      - Add the vault token and ip address to the vault section in network.yaml file [./build/network.yaml].
      - Replace the placeholders in the file with appropriate values

  - ### Starting up minikube

      - Once you added the vault token and ip to the deploykube.sh script, you can save it and run the script in order to start minikube locally

  - ### Deploying the network

    - use the run.sh script to deploy the network

  - ### Stopping and tearing down the network

    - you can use ctrl + c to stop the network
    - Once you stop the network, use the teardown.sh script to prune all persited network data and cache



  
