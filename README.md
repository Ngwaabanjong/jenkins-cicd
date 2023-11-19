# Demo - abc technologies code
**"Project 1"** 
- Created By - Ignatius Ngwaabanjong
  ## Topic:
This is a Jenkins pipeline that will build a Java base application with maven, compile, test, build a docker image and push to docker registry, deploy the build artifacts to tomcat server, and use ansible to deploy a kubernetes cluster at the same time. 

# 1 Install plugins on Jenkins
- SSHAgent
- SCP publisher
- Ansible
- Docker pipeline
- Kubernetes - To create jenkins agents in kubernetes cluster
- Kubernetes CLI - Allows you to configure kubectl in your job to interact with Kubernetes clusters. To deploy kubernetes configurations/objects/yamls to kubernetes cluster.
- Deploy to container - To deploy war file to tomcat 
- Docker - To build, run and push docker images in freestyle job
- Docker Pipeline - To build, run and push docker images in Pipeline job
- Artifactory - To interact with Jfrog Artifactory
- Anchore Container Image Scanner - To connect to Anchore engine for docker image scanning

# 2 On Jenkins 
- Global Configuration
- Give a path to git and install automatically (/usr/bin/git)
- Give a name to maven and install automatically
image.png


# 3 Configure DockerHub login and env on Jenkinsfile
- On Docker registry Setting, create a token, use the token as password with your username when creating a key in Jenkins.
- Define the Docker Registry Env is the Jenkinsfile
  ```groovy
  environment {
    dockerImage = ''
    registry = 'ngwaabanjong/abc-prj' #repo-name/image-m=name
    registryCredential = 'hub-key2'   #Docker Hub key defined in Jenkins
  ```
  
# 4 Configure git Checkout using Jenkins Syntax
- On Git -> Settings -> Developer Settings -> Create token (classic). 
- On Jenkins Create credentials with username as email and password as token.
- On Jenkins Syntax: select checkout version control, insert git URL, select credentials and create Syntax
image.png

# 5 Deploying to tomcat server
- On Jenkins
Make sure the SSH Agent plugin is installed. 
Create credentials SSH with private keys, open .pem key of tomcat node, copy and paste on private key.
Create Syntax with SSHAgent, generate step script. click on the ? on sshagent to get more script.
image.png

# 6 Deploying kubernetes using ansible playbook
Make sure these are installed properly: 
- ansible
- docker
- kubeadm 
- kubelet
- kubectl 
- Use ansible user for your deployment. Make sure ansible user is configured.
- Create a manifest file and store it in /home/ansible/deployment.yml
- 
File Syntax;

# 7 On Jenkins - Configure Pipeline
- Select Pipeline -> name
- tick: GitHub hook trigger for GITScm polling
- Pipeline: Definition - SCM, SCM - Git 
Repository - your project URL, 
- Credentials - select key. Make sure you have configure username github email & passwd GitHub token.
- select main project branch
- Script: Jenkins file
- tick: Lightweight checkout.

Now run the pipeline.

