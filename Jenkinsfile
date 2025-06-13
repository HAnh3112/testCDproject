pipeline {
    agent any

    stages {
        stage('clone') {
            steps {
                echo 'Cloning source code'
                git branch: 'main', url: 'https://github.com/HAnh3112/testCDproject'
            }
        }

        stage('build') {
            steps {
                echo 'Building project netcore'
                bat 'dotnet build --configuration Release'
            }
        }

        stage('tests') {
            steps {
                echo 'Running test...'
                bat 'dotnet test --no-build --verbosity normal'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
