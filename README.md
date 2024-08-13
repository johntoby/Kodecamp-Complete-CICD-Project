# Kodecamp-Complete-CICD-Project
This is a complete end-to-end DevOps project involving Python, Terraform, AWS, Docker, Kubernetes, GitHub Actions. 
I will create a simple python app using the flask framework, then containerize the it using docker, and finally deploy the application using Kubernetes. Terraform configuration files will be written to Automate the creation of custom VPC and ec2 instance. Finally, a GitHub Action yaml file will be configured for automated Continuous Integration. 

This is the Architecture diagram of the project:

![Architecture-diagram drawio](https://github.com/user-attachments/assets/1e2969c3-83d4-4ab9-bc8e-9011da1d2b8e)


## Building the Application with python 

The first task is to create a simple python application, using the flask framework. The application will display: Hello JT...Welcome to Kodecamp" on the screen. A requirements.txt file will also be created with the flask version as the only requirement.

![app py](https://github.com/user-attachments/assets/9a0090d5-ed4d-471f-86c4-bfa7fea4da2e)

![requirements txt](https://github.com/user-attachments/assets/de446a9f-111a-4567-810b-bcb1a59217c2)

## Containerize the Application using docker
A Dockerfile will be created to containerize the application and expose port 5000 as shown in the screenshot below: 
![dockerfile1](https://github.com/user-attachments/assets/12ca9323-2871-4509-8a5f-44cf49c4f2b0)

![dockerfile2](https://github.com/user-attachments/assets/6d176067-ae03-4e65-9804-2aed6df05a8f)

After building the docker image, the image will be pushed to my remote docker hub as shown below: 
![imaged-pushed-to-dockerhub](https://github.com/user-attachments/assets/46d9a17f-8b6b-428e-a56c-c92380a91f3b)



## Deploy the Application using Kubernetes 
In order to deploy the application using Kubernetes, 2 manifest files will be created - deployment.yaml and service.yaml files.

![deployment yaml](https://github.com/user-attachments/assets/ab8e158a-f411-494f-9a60-1ce0729426a5)

![service yaml](https://github.com/user-attachments/assets/483203ce-edfe-41d8-b7ef-e22676864c49)


## Set Up the Github Actions workflow
We will create a new folder called .github/workflows, and inside it, we create a yaml file called deploy.yml file to host the Actions we need to be automatically executed on push. 

![gha-deploy yml file](https://github.com/user-attachments/assets/54b0691e-40bb-41cf-86da-1e9863d234c5)


## Terraform for Infrastructure deployment 
We will use Terraform to automatically set up our ec2 instance named kc-python-server in a custom VPC named kcvpc in eu-west-1 region. A new keypair will be generated locally named kc-keypair to be used for the instance. 
2 modules will be created for the instance and vpc. 


![vpc-module](https://github.com/user-attachments/assets/24768ba3-474a-4cbc-84cc-a1e029460eeb)


![instance-module](https://github.com/user-attachments/assets/21e36e4e-bdf5-43bc-a1da-47e15f942b3a)


![main tf](https://github.com/user-attachments/assets/a994d35e-b5cc-4ebb-899d-b6dcbc3f60cd)

![main tf2](https://github.com/user-attachments/assets/d7ba0ed9-b1ab-4ba8-ae78-b8a36a4f28f1)

then run the following commands to start terraform 
```
$ terraform init
$ terraform validate
$terraform fmt
$terraform plan
$terraform apply
```

![terraform-apply](https://github.com/user-attachments/assets/547fa021-873d-4aa5-a103-a86c60f3fe9e)


![terraform-apply-success](https://github.com/user-attachments/assets/fec23760-309b-4a40-a0f6-73766640a8c4)

then we ssh into the server to confirm if all is okay using the command: 
```
ssh -i kc-keypair ubuntu@3.250.76.255
```


![ssh-into-the-ec2](https://github.com/user-attachments/assets/14501c8e-4fc9-4a2f-ab43-36492d1d7fde)


then we confirm if docker is installed according to the startup script by running the command: 
```
$systectl status docker
```
![docker-running-in-ec2](https://github.com/user-attachments/assets/84162f99-2726-4e79-b7b0-04d4dbf37f9d)


then we can check the AWS console to confirm the ec2 instance we created 

![ec2-deployed-by-terraform](https://github.com/user-attachments/assets/9916a6eb-0d7f-4b3d-bfb6-c6180f26a00f)

Finally we start the minikube service in the terminal using the command: 
```
$ minikube start
```

![minikube-start](https://github.com/user-attachments/assets/0499192c-7468-4e77-8aea-5e6e883857e8)


## Update the Github Actions yaml file
Finally, we will update the deploy.yml file of the github actions to execute the minikube deployment. Sensitive files will be created and stored in secrets for protection as shown below: 

![github-secrets](https://github.com/user-attachments/assets/c20d88fe-0b49-4032-9de1-42b573b93b25)


Below is the screenshot of the update to the deploy.yml file 

![update-to-github-actions-yaml](https://github.com/user-attachments/assets/f5ee2530-fad3-4aa1-bfa0-4d7c90c2a0ef)

Only one job will be executed and it will run on ubuntu:latest image. 
There are 6 steps involved in the execution of this job: 
 - Checkout code
 - Set up Docker Buildx
 - Login to DockerHub
 - Build and push docker image
 - SSH-setup
 - Minikube Deployment

Once you submit, the job will be automatically triggered and the build will occur. If its done correctly, the build will be successful as shown below: 

![actions-running-successfully](https://github.com/user-attachments/assets/ca676c79-38b2-4da7-8924-6e114ef773e7)

![actions-successful](https://github.com/user-attachments/assets/94eb92d9-7593-4e2e-b4f3-ceabf96a6043)

In case you get an error at the minikube deployment stage, ensure the file you copy to download with the curl -O command is the raw github user content file, and not the original file. 


## Destroy your infrastructure 
At the end, run this command to destroy your infrastructure to avoid AWS excessive billing:

 ```
$ terraform destroy
```

![terraform-destroy](https://github.com/user-attachments/assets/c2c0cd5b-e319-45b5-8f63-2701449824ab)


The end! Thanks for following through to the end.
