pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'tnindia3210/doc-wp:latest'
        DOCKER_TAG = 'latest'
        REMOTE_SERVER = '192.168.150.137'
        REMOTE_USER = 'ubuntu'
        REMOTE_KEY = credentials('ubuntu')
    }

    stages {
        stage('Clone Repository') {
            steps {
                sh 'pwd' //git config --global http.postBuffer 524288000 && '
                //git 'https://github.com/stalindreamer/WordPress.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Push Image to Registry') {
            steps {
                script {
                    docker.withRegistry('https://your-registry-url', 'docker-id') {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                    }
                }
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                script {
                    sshagent([REMOTE_KEY]) {
                        sh "ssh ${REMOTE_USER}@${REMOTE_SERVER} 'docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}'"
                        sh "ssh ${REMOTE_USER}@${REMOTE_SERVER} 'docker stop ${DOCKER_IMAGE} || true'"
                        sh "ssh ${REMOTE_USER}@${REMOTE_SERVER} 'docker rm ${DOCKER_IMAGE} || true'"
                        sh "ssh ${REMOTE_USER}@${REMOTE_SERVER} 'docker run -d --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}:${DOCKER_TAG}'"
                    }
                }
            }
        }
    }
}
