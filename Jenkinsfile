pipeline {
    agent any
    stages {
        stage('Setup') {
            steps {
                script {
                    // Install Python 3.11 if not already installed
                    sh '''
                        sudo apt-get update
                        sudo apt-get install -y python3.11 python3.11-venv python3.11-dev
                    '''
                    
                    // Set Python 3.11 as default for the current session
                    sh '''
                        python3.11 -m pip install --upgrade pip
                        pip install poetry
                    '''
                    
                    // Use Poetry to create a new virtual environment with Python 3.11
                    sh '''
                        poetry env use python3.11
                        poetry install
                    '''
            }
        }
        stage('Linter') {
            steps {
                script {
                    // Run linter using Poetry environment
                    sh '''
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
                        poetry run pyinstaller src/details/app.py --onefile
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
