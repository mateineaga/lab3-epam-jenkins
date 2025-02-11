pipeline{
    agent any
    environment {
    DOCKERHUB_CREDENTIALS = credentials('mateineaga10-dockerhub')
    }
    stages{
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
                sh 'docker build -t nodemain:v1.0.'
            }
        }

        stage('Deploy docker image'){
            steps{
                sh 'docker run -d --expose 3000 -p 3000:3000 nodemain:v1.0'
            }
        }
    }
}