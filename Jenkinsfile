pipeline {
    agent any
    stages {
        stage('Pre-Build') {
            steps {
                script {
                    sh '''
                        sudo apt-get update
                        sudo apt-get install -y python3 python3-pip python3-venv
                        pip3 install poetry
                    '''
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    sh '''
                        # Install dependencies using Poetry
                        poetry install
                    '''
                }
            }
        }
        stage('Spell Check') {
            steps {
                script {
                    sh '''
                        # List spelling mistakes and output to a file
                        aspell list < README.md > spelling_errors.txt
                        
                        # Fail the build if there are spelling mistakes
                        if [ -s spelling_errors.txt ]; then
                            echo "Spelling mistakes found. Failing the build."
                            cat spelling_errors.txt
                            exit 1
                        else
                            echo "No spelling mistakes found."
                        fi
                    '''
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    // Build using Poetry environment
                    sh '''
                        # Ensure Poetry is available
                        export PATH="$HOME/.local/bin:$PATH"
                        # Use Poetry to run PyInstaller
                        poetry run pyinstaller app.py
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
            cleanWs()
        }
    }
}
