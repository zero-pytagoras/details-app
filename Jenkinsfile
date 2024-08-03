pipeline {
    agent any
    stages {
        stage('Setup') {
            steps {
                script {
                    // Install Poetry
                    sh 'pip install poetry'
                    
                    // Create and install dependencies using Poetry
                    sh '''
                        poetry env use python3.11
                        poetry install
                    '''
                }
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
