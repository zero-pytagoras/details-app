pipeline {
    agent any
    stages {
        stage('Create Virtual Environment and Install Poetry') {
            steps {
                script {
                    sh '''
                        # Create virtual environment
                        python3.11 -m venv venv
                        # Activate virtual environment
                        . venv/bin/activate
                        # Upgrade pip and install Poetry
                        pip install --upgrade pip
                        pip install poetry
                        sudo apt-get install -y wget curl python3 python3-pip python3-pep8 python3-flask pypenv pylint python3-pipx
                        pipx install pyinstaller
                    '''
                }
            }
        }
        stage('Regenerate Lock File') {
            steps {
                script {
                    sh '''
                        # Activate virtual environment
                        . venv/bin/activate
                        # Regenerate poetry.lock file if pyproject.toml changed
                        poetry lock --no-update
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
