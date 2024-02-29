pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'tnindia3210/doc-wp:latest'
        CONTAINER_NAME = 'wordpress'
        DB_CONTAINER_NAME = 'mydql-db'
//        DB_ROOT_PASSWORD = 'my-secret-password'
//        DB_NAME = 'wordpressdb'
//        DB_USER = 'wordpressuser'
//        DB_PASSWORD = 'wordpresspassword'
        WORDPRESS_DB_HOST = 'db:3306'
        WORDPRESS_DB_NAME = 'wordpress'
        WORDPRESS_DB_USER = 'wpuser'
        WORDPRESS_DB_PASSWORD = 'wppassword'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the Git repository
		sh 'pwd' //git clone https://github.com/stalindreamer/WordPress.git'
               // git url: 'https://github.com/stalindreamer/WordPress.git'
            }
        }

        stage('Build and Push') {
            steps {
                script {
                    // Build and push WordPress Docker image to registry
                    sh "docker build -t $DOCKER_IMAGE ."
		withCredentials([usernamePassword(credentialsId: 'docker-id', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
		sh 'docker login -u=$USERNAME -p=PASSWORD'
		    }
                    
			sh 'echo "Docker image is going to push to docker.io"'
			sh "docker push $DOCKER_IMAGE"                
                    sh 'echo "docker image is pushed"'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the built Docker image to the remote server

			withCredentials([usernamePassword(credentialsId: 'ubuntu', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        echo Logging into the Linux server...
			withCredentials([usernamePassword(credentialsId: 'docker-id', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        		sh "sshpass -p $PASSWORD ssh $USERNAME@192.168.150.136 'docker login -u=$USERNAME -p=PASSWORD'"
	  }
                    sh "sshpass -p $PASSWORD ssh $USERNAME@192.168.150.136 'docker pull $DOCKER_IMAGE'"
                    sh "sshpass -p $PASSWORD ssh $USERNAME@192.168.150.136 'docker run -d --name $DB_CONTAINER_NAME -e MYSQL_ROOT_PASSWORD=$WORDPRESS_DB_PASSWORD -e MYSQL_DATABASE=$WORDPRESS_DB_NAME -e MYSQL_USER=$WORDPRESS_DB_USER -e MYSQL_PASSWORD=$WORDPRESS_DB_PASSWORD mysql:latest'"
                    sh "sshpass -p $PASSWORD ssh $USERNAME@192.168.150.136 'docker run -d --name $CONTAINER_NAME --link $DB_CONTAINER_NAME:mysql -p 8080:80 $DOCKER_IMAGE'"
			  '''
                }
                }
            }
        }
    }
}
