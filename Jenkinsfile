

pipeline {
    agent any

    stages {
        stage('Code-Checkout') {
            steps {
               checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/kajol2699/insurance.git']])
            }
        }
        
        stage('Code-Build') {
            steps {
               sh 'mvn clean package'
            }
        }
        
        stage('Containerize the application'){
            steps { 
               echo 'Creating Docker image'
               sh "docker build -t kaju912/insurance:latest ."
            }
        }
        
        stage('Docker Push') {
    	agent any
          steps {
       	withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
            	sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                sh 'docker push kaju912/insurance:latest'
        }
      }
    }
      stage('Code-Deploy') {
            steps {
         sshagent(['deploy_user']) {
           sh "scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/ProjectInsurance/target/Insurance-0.0.1-SNAPSHOT.jar ubuntu@172.31.6.4:/home/ubuntu/apache-tomcat-8.5.99/webapps"  
    }
}
