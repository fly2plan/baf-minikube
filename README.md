
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

  - ### Editing the Deployment.yaml file
  
      - Since we are deploying the chaincodes externally, the details of the external chaincode docker image should be mentioned in the deployment.yaml file 
        [./platforms/hyperledger-fabric/charts/external_chaincode/templates/deployment.yaml]
      - The same information should also be given in the nested_cc_deploy.yaml file 
        [./platforms/hyperledger-fabric/configuration/roles/create/external-chaincode/tasks/nested_cc_deploy.yaml]


  - ### Starting up minikube

      - Once you added the vault token and ip to the deploykube.sh script, you can save it and run the script in order to start minikube locally

  - ### Deploying the network

    - use the run.sh script to deploy the network

  - ### Stopping and tearing down the network

    - you can use ctrl + c to stop the network
    - Once you stop the network, use the teardown.sh script to prune all persited network data and cache


# Adding New Org to Existing Network

  - Once you have a fabric network up and running , you can add a new org to the network using the following steps

    - Update the new-org-network.yaml file from the build directory, add the details of the new organisation in the "channel" and "organisations" section
    - Make sure that the org_status of the new organisation is set to "new", while the others are set to "existing"
    - Once all the appropriate details are given in the new-org-network.yaml file, save it and run the addNewOrg.sh script
    - This will add a new org to an existing fabric network
