pipeline {
    agent { label 'workers' } // needs to have ssh agent
    stages {
        stage('Setup') {
            steps {
                script {
                    // Ensure Python and necessary tools are installed
                    sh '''
                        python3 -m pip install --upgrade pip
                        pip install pylint pyinstaller pytest
                    '''
                }
            }
        }
        stage('Linter') {
            steps {
                echo 'Static code analysis check'
                sleep 1
                sh '''
                    pylint --disable=missing-module-docstring,missing-function-docstring app.py
                '''
            }
        }
        stage('Build') {
            steps {
                echo 'Building the Project'
                sleep 1
                sh '''
                    pyinstaller app.py --onefile  # Add -y if needed
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Testing'
                sleep 1
                sh '''
                    python3 -m pytest
                '''
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
