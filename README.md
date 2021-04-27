# Web Page Test Implementation
## Pipeline
###### Docker + Circle CI + Terraform + Ansible + AWS

This repo contain one implementation of a Pipeline to deploy privatly the Web Page Test application:

https://www.webpagetest.org/


The approach followed was use the docker images for both Server and Agent:

https://hub.docker.com/u/webpagetest


The final arquitecture is shown below:

![Arquitecture Image](https://github.com/manunapo/webpagetest-cicd/blob/main/Arquitecture.png)


A brief description:

![Description Image](https://github.com/manunapo/webpagetest-cicd/blob/main/Description.png)

The main configuration files for each services are:

CircleCI:
- .circleci/config.yml

Terraform:
- main.tf
- providers.tf
- variables.tf
- resources.tf
- outputs.tf

Ansible:
- deploy-configs.yml


Then the shared files are:
- inventory.template (Used by terraform in order to populate Ansible's Inventory)
- vars.template (Used by terraform in order to populate Ansible's vars file)
- inventory (hosted in S3)
- vars.yml (This file is used just for storing Server's Private IP*, also hosted in S3)

> *This private IP is needed for starting the Agent container. It requieres the URL of the server, and since are in the same AWS private network, it is convenient to use Private IP insted of Public.


The Server and Agent set up started OK:

![Arquitecture Image](https://github.com/manunapo/webpagetest-cicd/blob/main/ServerInstall.png)


One test ran OK:

![Description Image](https://github.com/manunapo/webpagetest-cicd/blob/main/OneTest.png)