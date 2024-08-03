pipeline {
    agent any
    stages {
        stage('Pre-Build') {
            steps {
                script {
                    sh '''
                        sudo apt-get update
                        sudo apt-get install -y wget curl python3 python3-pip python3-pep8 python3-flask pypenv pylint python3-pipx
                        pypx instal pyinstaller 
                    '''
                }
            }
        }
        
        stage('Build') {
            steps {
                script {
                    sh '''

                        pyinstaller src/details/app.py --onefile
                    '''
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    sh '''
                        # Activate virtual environment
                        . venv/bin/activate
                        # Test using Poetry environment
                        poetry run pytest
                    '''
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
