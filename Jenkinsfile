pipeline {
    agent {label 'workers'} 
    stages {
        
        stage('Pre-Build'){
            steps{
                echo 'Checking pre-requisites'
                sleep 2
                sh'''
                    export PATH=$PATH:~/.local/bin
                    sudo apt-get update
                    sudo apt-get install -y wget curl python3 python3-pip python3-pep8 python3-flask pipenv pylint
                    pip3 install -r requirements.txt
                '''

            }
        }

        stage('Linter') {
            steps {
                script {
                    // Run linter using Poetry environment
                    sh '''
                        pylint --disable=missing-module-docstring,missing-function-docstring src/details/app.py
                    '''
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    // Build using Poetry environment
                    sh '''
                        pyinstaller src/details/app.py --onefile
                    '''
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    // Test using Poetry environment
                    sh '''
                        poetry run pytest
                    '''
                }
            }
        }
    }
    post {
        always {
            // Clean up workspace
            cleanWs()
        }
    }
}
