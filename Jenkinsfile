pipeline{
    agent any
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
    }
}