pipeline {
    agent any
    stages {
        stage('Pre-Build') {
            steps {
                script {
                    sh '''
                        # Synchronize the system clock
                        sudo apt-get install -y ntpdate
                        sudo ntpdate pool.ntp.org

                        # Update package lists
                        sudo apt-get update

                        # Install required packages
                        sudo apt-get install -y wget curl python3 python3-pip python3-pep8 python3-flask pipenv pylint python3-pipx pyinstaller

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
