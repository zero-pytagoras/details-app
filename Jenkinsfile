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
                    sudo apt-get install -y aspell
                '''

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
                        export PATH=$PATH:~/.local/bin
                        pyinstaller app.py

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
