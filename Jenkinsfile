pipeline{
    agent any

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

        stage('Build docker image'){
            steps{
                script {
                    sh '''
                    echo "Building image nodedev"
                    docker build -t nodedev:v1.0 .
                    '''
                }
            }
        }

        stage('Deploy docker image'){
            steps{
                script {
                    sh '''#!/bin/bash
                        echo "Cleaning the running&stopped containers!"
                        docker stop nodedev || true
                        docker rm nodedev || true

                        echo "Running image nodedev:v1.0"
                        echo "Port: 3001"

                        docker run -d --expose 3001 -p 3001:3000 --name nodedev nodedev:v1.0
                    '''
                }
            }
        }

    }
}