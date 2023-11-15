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
          [credentialsId: 'git-classic-token', url: 'https://github.com/Ngwaabanjong/final-grade-prj2.git']
        ])
        sh 'mvn clean package'
      }
    }


    stage('Build Docker image') {
      steps {
        script {  
          sh 'docker build -t ngwaabanjong/xyz-app .'
        }
      }
    }

    stage('Push image to Hub') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            sh 'docker push ngwaabanjong/xyz-app'
          }
        }
      }
    }

    stage('Deploy war file to tomcat server') {
      steps{
        sshagent(['ec2-key']) {
          sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/ansible/target/XYZtechnologies-1.0.war ec2-user@54.166.197.171:/opt/tomcat/webapps'
        }
      }
    }

    stage('Deploy docker with Ansible') {
      steps {
        script {  
          ansiblePlaybook credentialsId: 'ec2-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'servers.env', playbook: 'ansible1.yml'
        }
      }
    }

    stage('Deploy K8s with Ansible') {
      steps {
        script {  
          ansiblePlaybook credentialsId: 'ec2-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'servers.env', playbook: 'ansible2.yml'
        }
      }
    }
  }
}