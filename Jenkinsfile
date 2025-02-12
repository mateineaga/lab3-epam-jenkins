@Library('shared-library') _
pipeline{
    agent { 
        label "built-in"
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('mateineaga10-dockerhub')
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    echo "Checking out branch main"
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: "*/main"]],
                        userRemoteConfigs: [[
                            url: 'https://github.com/mateineaga/lab3-epam-jenkins.git',
                            credentialsId: 'GitCredentials'
                        ]]
                    ])
                }
            }
        }

        stage('Testing from shared library!') {
            steps {
                helloWorld()
            }
        }

        stage('Build'){
            steps{
                nodejs('node'){
                    echo 'Building application.....'
                    sh 'npm install'
                }
            }
        }

        stage('Test'){
            steps{
                nodejs('node'){
                    echo 'Testing the application.....'
                    sh 'npm test'
                }
            }
        }

        stage("hadolint Dockerfile") {
            agent {
                docker {
                    image 'hadolint/hadolint:latest-debian'  // Folosește imaginea corespunzătoare
                }
            }
            steps {
                sh 'hadolint Dockerfile'  // Salvezi output-ul în report.txt
            }
        }

        stage('Build docker image'){

            agent { 
                label "agent1" 
            }

            steps{
                script {
                    sh '''
                    echo "Login..."
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin

                    echo "Deleting image from local"
                    docker rmi mateineaga10/nodedev:v1.0 || true

                    echo "Building image nodedev"
                    docker build -t mateineaga10/nodedev:v1.0 .

                    echo "Pushing image..."
                    docker push mateineaga10/nodedev:v1.0

                     
                    '''
                }
            }
        }

        stage("Vulnerability scan: trivy for Dockerfile") {

            agent { 
                label "agent1" 
            }

            steps {
                sh 'trivy --no-progress --exit-code 0 --severity HIGH,MEDIUM,LOW mateineaga10/nodedev:v1.0'
            }
        }


        stage('Deploy docker image to main'){
            steps{
                script {
                    sh '''#!/bin/bash
                        echo "Cleaning the running&stopped containers!"
                        docker stop nodedev || true
                        docker rm nodedev || true
                        
                        echo "Login..."
                        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin

                        echo "Pulling image..."
                        docker pull mateineaga10/nodedev:v1.0

                        echo "Running image mateineaga10/nodedev:v1.0"
                        echo "Port: 3001"

                        docker run -d --expose 3001 -p 3001:3000 --name nodedev mateineaga10/nodedev:v1.0
                    '''
                }
            }
        }

    }
}