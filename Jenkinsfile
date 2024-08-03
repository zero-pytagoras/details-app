pipeline {
    agent {label 'workers'} 
    environment {
        POETRY_HOME = "$HOME/.poetry"
        VENV_PATH = "$HOME/.cache/pypoetry/virtualenvs/details-app-mhtNVUmb-py3.12"
    }
    stages {
        
        stage('Pre-Build'){
            steps{
                echo 'Checking pre-requisites'
                sleep 2
                sh'''
                    export PATH=$PATH:~/.local/bin
                    sudo apt-get update
                    sudo apt-get install -y wget curl python3 python3-pip python3-pep8 python3-flask pipenv pylint
                    sudo apt install flask
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
