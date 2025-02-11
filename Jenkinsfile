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
                    if [[ "${params.BRANCH_NAME}" == "main" ]]; then
                        echo "Building the image for branch: ${params.BRANCH_NAME}"
                        echo "Building nodemain:${params.IMAGE_TAG}"
                        echo "Port: 3000"

                        docker build -t "nodemain:${params.IMAGE_TAG}" -f Dockerfile .
                    else
                        echo "Building the image for branch: ${params.BRANCH_NAME}"
                        echo "Building nodedev:${params.IMAGE_TAG}"
                        echo "Port: 3001"

                        docker build -t nodedev:${params.IMAGE_TAG} -f Dockerfile .
                    fi
                    """
                }
            }
        }

        stage('Deploy docker image'){
            steps{
                script {
                    sh """#!/bin/bash
                    if [[ "${params.BRANCH_NAME}" == "main" ]]; then
                        echo "Cleaning the running&stopped containers!"
                        docker stop nodemain:${params.IMAGE_TAG} || true
                        docker rm nodemain:${params.IMAGE_TAG} || true

                        echo "Running image nodemain:${params.IMAGE_TAG}"
                        echo "Port: 3000"
                        echo "Cleaning the port:"

                        echo 'matei' | sudo kill -9 \$(sudo lsof -t -i:3000)

                        docker run -d --expose 3000 -p 3000:3000 nodemain:${params.IMAGE_TAG}
                    else
                        echo "Cleaning the running&stopped containers!"
                        docker stop nodedev:${params.IMAGE_TAG} || true
                        docker rm nodedev:${params.IMAGE_TAG} || true

                        echo "Running image nodedev:'${params.IMAGE_TAG}'"
                        echo "Port: 3001"
                        echo "Cleaning the port:"

                        echo 'matei' | sudo -S kill -9 $(echo 'matei' | sudo -S lsof -t -i:3001)

                        docker run -d --expose 3001 -p 3001:3000 nodedev:${params.IMAGE_TAG}
                    fi
                    """
                }
            }
        }

    }
}