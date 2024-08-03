pipeline {
    agent any
    stages {
        stage('Pre-Build') {
            steps {
                script {
                    sh '''
                        sudo apt-get update
                        sudo apt-get install -y python3 python3-venv
                    '''
                }
            }
        }
        stage('Create Virtual Environment and Install Poetry') {
            steps {
                script {
                    sh '''
                        # Create virtual environment
                        python3 -m venv venv
                        # Activate virtual environment
                        . venv/bin/activate
                        # Upgrade pip and install Poetry
                        pip install --upgrade pip
                        pip install poetry
                    '''
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    sh '''
                        # Activate virtual environment
                        . venv/bin/activate
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
                        # Activate virtual environment
                        . venv/bin/activate
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
                    sh '''
                        # Activate virtual environment
                        . venv/bin/activate
                        # Use Poetry to run PyInstaller
                        poetry run pyinstaller src/details/app.py --onefile
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
