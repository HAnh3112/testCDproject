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

        stage('Stop IIS') {
            steps {
                echo 'Stopping IIS...'
                bat 'iisreset /stop'
            }
        }

	    stage ('public den t thu muc')
	    {
		    steps{
			    echo 'Publishing...'
			    bat 'dotnet publish -c Release -o ./publish'
		    }
	    }
	    stage ('Publish') {
		    steps {
			    echo 'public 2 running folder'
		    //iisreset /stop // stop iis de ghi de file 
			    bat 'xcopy "%WORKSPACE%\\publish" /E /Y /I /R "c:\\wwwroot\\myproject"'
 		    }
	    }

	    stage('Deploy to IIS') {
                steps {
                    powershell '''
               
                    # Tạo website nếu chưa có
                    Import-Module WebAdministration
                    if (-not (Test-Path IIS:\\Sites\\MySite)) {
                        New-Website -Name "MySite" -Port 82 -PhysicalPath "c:\\wwwroot\\myproject"
                    }
                    '''
                }
            } // end deploy iis

        stage('Start IIS') {
            steps {
                echo 'Starting IIS...'
                bat 'iisreset /start'
            }
        }

  }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }

}
