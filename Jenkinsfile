pipeline{
    agent any

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

        // stage('Build'){
        //     steps{
        //         nodejs('node'){
        //             echo 'Building application.....'
        //             sh 'npm install'
        //         }
        //     }
        // }

        // stage('Test'){
        //     steps{
        //         nodejs('node'){
        //             echo 'Testing the application.....'
        //             sh 'npm test'
        //         }
        //     }
        // }

        stage('Build docker image'){
            steps{
                script {
                    sh '''
                    echo "Login..."
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin

                    echo "Building image nodemain"
                    docker build -t mateineaga10/nodemain:v1.0 .

                    echo "Pushing image..."
                    docker push mateineaga10/nodemain:v1.0

                    echo "Deleting image from local"
                    docker rmi mateineaga10/nodemain:v1.0
                    '''
                }
            }
        }

        stage('Deploy docker image to main'){
            steps{
                script {
                    sh '''#!/bin/bash
                        echo "Cleaning the running&stopped containers!"
                        docker stop mateineaga10/nodemain:v1.0 || true
                        docker rm mateineaga10/nodemain || true

                        echo "Login..."
                        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin

                        echo "Pulling image..."
                        docker pull mateineaga10/nodemain:v1.0

                        echo "Running image mateineaga10/nodemain:v1.0"
                        echo "Port: 3000"

                        docker run -d --expose 3000 -p 3000:3000 --name nodemain mateineaga10/nodemain:v1.0
                    '''
                }
            }
        }

    }
}