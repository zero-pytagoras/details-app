pipeline{
    agent {label 'workers'} // needs to have ssh agent
    parameters{
        string(name: 'sleep_time', defaultValue:'2', description:'time to sleep')
    }
    stages{
        stage('Pre-Build'){
            steps{
                echo 'Checking pre-requisites'
                sleep "${sleep_time}"
                sh'''
                    export PATH=$PATH:~/.local/bin
                    sudo apt-get update
                    sudo apt-get install -y wget curl python3 python3-poetry
                    poetry install
                    
                    curl -L get.docker.com| sudo bash 

                '''
            }
        }
        stage('Linter'){
            steps{
                echo 'Static code analysis check'
                sleep "${sleep_time}"
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
                    docker build -t details-app:latest .
                '''
            } // error with builds clean up 
        }
        stage('Docker image Save'){
            steps{
                echo 'Testing'
                sleep "${sleep_time}"
                sh'''
                    docker login -u silentmobius -p m4k3!Tw0rk 
                    docker tag details-app:latest silentmobius/details-app:latest 
                    docker push silentmobius/details-app:latest
                ''' 
            }
        }
    }// comment to check things
    post {
        unsuccessful{   
            cleanWs cleanWhenSuccess: false
        }
        success{
            sh""""
                docker save silentmobius/details-app:latest -o details_app_docker.latest.tgz
            """
            archiveArtifacts artifacts: 'details_app_docker.latest.tgz', followSymlinks: false, onlyIfSuccessful: true      
        }
    }
}
