pipeline{
    agent any

    parameters {
        choice(name: 'BRANCH_NAME', choices: ['main', 'dev'], description: 'Choose the environment to deploy')
        string(name: 'IMAGE_TAG', defaultValue: 'v1.0', description: 'Docker image tag')
    }

    stages {
        // stage('Setup Environment Variables') {
        //     steps {
        //         script {
        //             def IMAGE_NAME
        //             def PORT

        //             // Folosim shell scripting pentru setarea variabilelor
        //             if (params.BRANCH_NAME == 'main') {
        //                 IMAGE_NAME = "nodemain:${params.IMAGE_TAG}"
        //                 PORT = "3000"
        //             } else {
        //                 IMAGE_NAME = "nodedev:${params.IMAGE_TAG}"
        //                 PORT = "3001"
        //             }

        //         }
        //     }
        // }

        // stage('Checkout Code') {
        //     steps {
        //         script {
        //             echo "Checking out branch ${params.BRANCH_NAME}"
        //             checkout([
        //                 $class: 'GitSCM',
        //                 branches: [[name: "*/${params.BRANCH_NAME}"]],
        //                 userRemoteConfigs: [[
        //                     url: 'git@github.com:mateineaga/lab3-epam-jenkins.git',
        //                     credentialsId: 'GitCredentials'  // Folosim GitCredentials pentru autentificare
        //                 ]]
        //             ])
        //         }
        //     }
        // }

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
                    sh """#!/bin/bash
                    if [[ "$BRANCH_NAME" == "main" ]]; then
                        echo "Building the image for branch: ${BRANCH_NAME}"
                        echo "Building nodemain:${IMAGE_TAG}"
                        echo "Port: 3000"

                        docker build -t "nodemain:${IMAGE_TAG}" -f Dockerfile .

                    else
                        echo "Building the image for branch: ${BRANCH_NAME}"
                        echo "Building nodedev:${IMAGE_TAG}"
                        echo "Port: 3001"

                        docker build -t nodedev:${IMAGE_TAG} -f Dockerfile .

                    fi
                    """
                }
                
            }
        }

        stage('Deploy docker image'){
            steps{
                script {
                    sh """#!/bin/bash
                    if [[ "$BRANCH_NAME" == "main" ]]; then
                        echo "Cleaning the running&stopped containers!"
                        docker stop nodemain:${IMAGE_TAG} || true
                        docker rm nodemain:${IMAGE_TAG} || true

                        echo "Running image nodemain:${IMAGE_TAG}"

                        echo "Port: 3000"

                        docker run -d --expose 3000 -p 3000:3000 nodemain:${IMAGE_TAG}
                    else
                        echo "Cleaning the running&stopped containers!"
                        docker stop nodedev:${IMAGE_TAG} || true
                        docker rm nodedev:${IMAGE_TAG} || true
 
                        echo "Running image nodedev:${IMAGE_TAG}"

                        echo "Port: 3001"

                        docker run -d --expose 3000 -p 3000:3000 nodedev:${IMAGE_TAG}
                    fi
                    """
                }
            }
        }
    }
}