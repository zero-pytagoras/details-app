pipeline{
    agent {label 'workers'} // needs to have ssh agent
    stages{
        stage('Linter'){
            steps{
                echo 'Static code analysis check'
                sleep "${params.sleep_time}"
                sh '''
                    pylint --disable=missing-module-docstring,missing-function-docstring app.py
                '''
            } // error app syntax --> fix the strings in app or bypass them
        }
        stage('Build'){
            steps{
                echo 'Building the Project'
                sleep "${sleep_time}"
                sh '''
                    docker build .
                '''
            } // error with builds clean up 
        }
        stage('Test'){
           // pytest
            steps{
                echo 'Testing'
                sleep "${sleep_time}"
                sh'''
                    python3 -m pytest
                ''' // error --> verify that you are running correct env
            }
        }

    }
}