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
                    export PATH=$PATH:$POETRY_HOME/bin
                    poetry install
                '''

            }
        }

        stage('Linter') {
            steps {
                script {
                    // Run linter using Poetry environment
                    sh '''
                        export PATH=$PATH:$VENV_PATH/bin
                        poetry run pylint --disable=missing-module-docstring,missing-function-docstring src/details/app.py
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
