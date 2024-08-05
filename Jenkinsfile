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
        // Other stages (Build, Test, etc.) go here
    }
    post {
        always {
            cleanWs()
        }
    }
}
