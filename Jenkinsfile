pipeline {
    agent any
    stages {
        stage('Pre-Build: Install Dependencies') {
            steps {
                script {
                    sh '''
                        # Update package lists and install system dependencies
                        sudo apt-get update
                        sudo apt-get install -y wget curl python3 python3-pip python3-venv shellcheck aspell

                        # Install Poetry
                        curl -sSL https://install.python-poetry.org | python3 -

                        # Add Poetry to PATH
                        export PATH="$HOME/.local/bin:$PATH"

                        # Configure Poetry to create and use virtual environments in the project directory
                        poetry config virtualenvs.create true
                        poetry config virtualenvs.in-project true

                        # Check if poetry.lock needs to be updated
                        if [ -f "poetry.lock" ]; then
                            poetry lock --no-update
                        else
                            echo "poetry.lock not found. Skipping lock file regeneration."
                        fi

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
                        # Activate the virtual environment
                        . .venv/bin/activate

                        # Run spellcheck using Aspell
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
        stage('Shellcheck') {
            steps {
                script {
                    sh '''
                        # Check all shell scripts in the repository with Shellcheck
                        shellcheck /home/master/projects/details-app-1/build.sh

                        # Shellcheck will automatically fail the build if it finds issues
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
