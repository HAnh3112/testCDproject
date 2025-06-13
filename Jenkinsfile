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
	stage('Deploy to IIS') {
            steps {
                powershell '''
               
                # Tạo website nếu chưa có
                Import-Module WebAdministration
                if (-not (Test-Path IIS:\\Sites\\MySite)) {
                    New-Website -Name "MySite" -Port 81 -PhysicalPath "c:\\test1-netcore"
                }
                '''
            }
        } // end deploy iis


    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }

}
