pipeline{
    agent any

    parameters {
        choice(name: 'BRANCH_NAME', choices: ['main', 'dev'], description: 'Choose the environment to deploy')
        string(name: 'IMAGE_TAG', defaultValue: 'v1.0', description: 'Docker image tag')
    }

    environment {
        IMAGE_NAME = ''
        FULL_IMAGE_NAME = ''
        PORT = ''
    }

    stages {
        stage('Setup Environment Variables') {
            steps {
                script {
                    // Folosim shell scripting pentru setarea variabilelor
                    sh '''#!/bin/bash
                        if [[ "$BRANCH_NAME" == "main" ]]; then
                            export IMAGE_NAME="nodemain"
                            export PORT="3000"
                        else
                            export IMAGE_NAME="nodedev"
                            export PORT="3001"
                        fi

                        export FULL_IMAGE_NAME="mateineaga10/${IMAGE_NAME}:${IMAGE_TAG}"
                        echo "Full Image Name: ${FULL_IMAGE_NAME}"
                        echo "Port: ${PORT}"
                    '''
                }
            }
        }

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
                echo 'Building the image'
                echo "${FULL_IMAGE_NAME}"
                echo "${PORT}"
                sh 'docker build -t "${FULL_IMAGE_NAME}" -f Dockerfile .'
            }
        }

        stage('Deploy docker image'){
            steps{
                // echo 'Cleaning the existing containers!'
                // sh 'docker rm $(docker ps -aq)'
                echo 'Running the docker image created earlier!'
                sh 'docker run -d --expose ${env.PORT} -p ${env.PORT}:${env.PORT} $(env.FULL_IMAGE_NAME)'
            }
        }
    }
}