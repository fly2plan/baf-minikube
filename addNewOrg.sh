#!/bin/bash

echo "Adding New Org To Existing Network"
exec ansible-playbook platforms/shared/configuration/add-new-organization.yaml -e "@build/new-org-network.yaml" -e "add_new_org='true'" --inventory-file=platforms/shared/inventory/ -e 'ansible_python_interpreter=/usr/bin/python3'