pipeline {
    agent any  // Runs on any available Jenkins agent

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/siva671/nginx-deployment.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t nginx-app .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker tag nginx-app siva671/nginx-app:latest'
                    sh 'docker push siva671/nginx-app:latest'
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                sshagent(['server-ssh-credentials']) {
                    sh '''
                    ssh root@192.168.234.162 '
                    docker pull siva671/nginx-app:latest &&
                    docker stop nginx-app || true &&
                    docker rm nginx-app || true &&
                    docker run -d --name nginx-app -p 80:80 siva671/nginx-app:latest'
                    '''
                }
            }
        }
    }
}
