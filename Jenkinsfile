pipeline{
    agent any

    parameters {
        choice(name: 'BRANCH_NAME', choices: ['main', 'dev'], description: 'Choose the environment to deploy')
        string(name: 'IMAGE_TAG', defaultValue: 'v1.0', description: 'Docker image tag')
    }

    environment {
        PORT = "${params.BRANCH_NAME}" == "main" ? "3000" : "3001"
        IMAGE_NAME = "${params.BRANCH_NAME}" == "main" ? "nodemain" : "nodedev"
        FULL_IMAGE_NAME = "mateineaga10/${env.IMAGE_NAME}:${params.IMAGE_TAG}"
    }

    stages{
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
                echo 'Building the image'
                sh 'docker build -t $(env.FULL_IMAGE_NAME) .'
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