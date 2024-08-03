pipeline{
    agent {label 'workers'} // needs to have ssh agent
    parameters{
        string(name: 'sleep_time', defaultValue:'2', description:'time to sleep')
        string(name: 'UNAME', defaultValue:'silentmobius', description:'docker_username')
        string(name: 'PASSWD', description:'docker_password')
        string(name: 'docker_image_name', defaultValue:'details_app', description:'docker image name')
        string(name: 'docker_image_version', defaultValue:'latest', description:'docker image version')
        string(name: 'registry_user', defaultValue:'silentmobius', description:'docker hub user')
        
    }
    stages{
        stage('Pre-Build'){
            steps{
                echo 'Checking pre-requisites'
                sleep "${sleep_time}"
                sh'''
                    export PATH=$PATH:~/.local/bin
                    sudo apt-get update
                    sudo apt-get install -y wget curl python3 python3-poetry codespell
                    curl -L get.docker.com| sudo bash
                    poetry install
                '''
            }
        }
        stage('Linter'){
            steps{
                echo 'Static code analysis check'
                sleep "${sleep_time}"
                sh '''
                    codespell  app.py
                '''
            } // error app syntax --> fix the strings in app or bypass them
        }
        stage('Build'){
            steps{
                echo 'Building the Project'
                sleep "${sleep_time}"
                sh '''
                    sudo docker build -t details-app:latest .
                '''
            } // error with builds clean up 
        }
        stage('Docker image Save'){
            steps{
                echo 'Testing'
                sleep "${sleep_time}"
                sh"""
                    sudo docker login -u ${UNAME} -p ${PASSWD} 
                    sudo docker tag ${docker_image_name}:${docker_image_version} ${registry_user}/${docker_image_name}:${docker_image_version} 
                    sudo docker push ${registry_user}/${docker_image_name}:${docker_image_version} 
                """ 
            }
        }
    }// comment to check things
    post {
        success{
            sh""""
                docker save ${registry_user}/${docker_image_name}:${docker_image_version}  -o "${docker_image_name}:${docker_image_version}.tgz"
            """
            archiveArtifacts artifacts: 'details_app_docker.latest.tgz', followSymlinks: false, onlyIfSuccessful: true      
        }
    }
}
