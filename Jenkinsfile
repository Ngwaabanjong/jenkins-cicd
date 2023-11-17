pipeline {
  agent any

  environment {
    dockerImage = ''
    registry = 'ngwaabanjong/abc-app1'
    registryCredential = 'hub-key'
  }
  tools {
    maven 'maven'
  }
  stages {
    stage('Build Maven') {
      steps {
        checkout scmGit(branches: [
          [name: '*/main']
        ], extensions: [], userRemoteConfigs: [
          [credentialsId: 'git-classic-token', url: 'https://github.com/Ngwaabanjong/private-abc-prj.git']
        ])
        sh 'mvn clean install'
      }
    }

    stage('compile') {
      steps {
        echo 'compiling the application...'
      }
    }

    stage('test') {
      steps {
        echo 'testing the application...'
      }
    }

    stage('Package the code') {
      steps {
        sh 'mvn package'
      }
    }

    stage('Build docker image') {
      steps {
        script {
          sh 'docker build -t ngwaabanjong/abc-app1 .'
        }
      }
    }
    stage('Push image to Hub') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            sh 'docker push ngwaabanjong/abc-app1'
          }
        }
      }
    }

    // stage('Deploy to Kubernetes with Ansible') {
    //   steps {
    //     script {  
    //       ansiblePlaybook becomeUser: 'ansible', credentialsId: 'ubuntu-key', inventory: '/var/lib/jenkins/workspace/abc-prj/deployment.yml', playbook: '/home/ansible/deployment.yaml', sudoUser: 'ansible'
    //     }
    //   }
    // }
    stage('Deploy the code on tomcat server') {
      steps{
        sshagent(['user-key']) {
          sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/abc-prj/target/ABCtechnologies-1.0.war ec2-user@54.166.197.171:/opt/tomcat/webapps'
        }
      }
    }
    
    stage('Deploy to Kubernetes with Ansible') {
      steps {
        script {  
          sh "ansible-playbook deployment.yaml"
        }
      }
    }
  }
}