pipeline {
  agent any

  environment {
    dockerImage = ''
    registry = 'ngwaabanjong/mfgapp2'
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
          [credentialsId: 'classic-token', url: 'https://github.com/Ngwaabanjong/jenkins-cicd']
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

    stage('Deploy the code on tomcat server') {
      steps{
        sshagent(['ec2-worker']) {
          sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/pipeline-deploy/target/ABCtechnologies-1.0.war ec2-user@54.166.197.171:/opt/tomcat/webapps'
        }
      }
    }

    stage('Build docker image') {
      steps {
        script {
          sh 'docker build -t ngwaabanjong/mfgapp2 .'
        }
      }
    }
    stage('Push image to Hub') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            sh 'docker push ngwaabanjong/mfgapp2'
          }
        }
      }
    }
  }
}
