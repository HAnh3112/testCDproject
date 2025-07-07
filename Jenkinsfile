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

	    stage ('public to folder')
	    {
		    steps{
			    echo 'Publishing...'
			    bat 'dotnet publish -c Release -o ./publish'
		    }
	    }
	    stage ('Publish') {
		    steps {
			    echo 'public 2 running folder'
			    bat 'xcopy "%WORKSPACE%\\publish" /E /Y /I /R "c:\\wwwroot\\myproject"'
 		    }
	    }

	    stage('Deploy to IIS') {
                steps {
                    powershell '''
               
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
        
        stage('docker image') {
            steps {
                 bat '''
					  docker build -t testcdprojectdocker -f "%WORKSPACE%\\Dockerfile" .
					'''
                }
          }

		// dua vao docker image
        stage('docker run') {
            steps {
                echo 'Stopping and removing existing Docker container if it exists...'
                bat '''
                    docker rm -f p27625run || echo "No existing container to remove"
                    docker run -d --name p27625run -p 90:80 testcdprojectdocker
                '''
            }
        }



  }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }

}
