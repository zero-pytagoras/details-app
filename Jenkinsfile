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

                        # Create a virtual environment
                        python3 -m venv venv

                        # Activate the virtual environment
                        . venv/bin/activate

                        # Install pipx and pyinstaller
                        pip install --upgrade pip
                        pip install pipx
                        pipx install pyinstaller

                        # Upgrade pip and install Python dependencies from requirements.txt
                        pip install --upgrade pip
                        pip install -r requirements.txt
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
