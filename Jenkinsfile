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
    }
}