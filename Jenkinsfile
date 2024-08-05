pipeline {
    agent any
    stages {
        stage('Pre-Build: Install Dependencies') {
            steps {
                script {
                    sh '''
                        # Update package lists and install system dependencies
                        sudo apt-get update
                        sudo apt-get install -y wget curl python3 python3-pip python3-venv shellcheck

                        # Install Poetry
                        curl -sSL https://install.python-poetry.org | python3 -

                        # Add Poetry to PATH
                        export PATH="$HOME/.local/bin:$PATH"

                        # Create a new virtual environment and install dependencies using Poetry
                        poetry config virtualenvs.create true
                        poetry config virtualenvs.in-project true

                        # Install dependencies using Poetry
                        poetry install
                    '''
                }
            }
        }
        // Other stages (Build, Test, etc.) go here
    }
    post {
        always {
            cleanWs()
        }
    }
}
