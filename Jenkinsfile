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
//	DOCKER_USERNAME = 'stalindreamer@gmail.com'
//	DOCKER_PASSWORD = 'TNindia3210'

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
		
                    // Assuming you've already built your Docker image
                    def dockerImage = 'tnindia3210/doc-wp:latest'

                    // 'docker-credentials' is the ID of your credentials in Jenkins
                     {
                        // 'your-registry-url' is your Docker registry URL
                        docker.withRegistry('https://docker.io/tnindia3210/doc-wp', 'docker-id') {
                            docker.image(dockerImage).push()
                        }
                    }
                
                    
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the built Docker image to the remote server
                    sh "ssh ubuntu@192.168.150.136 'docker pull $DOCKER_IMAGE'"
                    sh "ssh ubuntu@192.168.150.136 'docker run -d --name $DB_CONTAINER_NAME -e MYSQL_ROOT_PASSWORD=$WORDPRESS_DB_PASSWORD -e MYSQL_DATABASE=$WORDPRESS_DB_NAME -e MYSQL_USER=$WORDPRESS_DB_USER -e MYSQL_PASSWORD=$WORDPRESS_DB_PASSWORD mysql:latest'"
                    sh "ssh ubuntu@192.168.150.136 'docker run -d --name $CONTAINER_NAME --link $DB_CONTAINER_NAME:mysql -p 8080:80 $DOCKER_IMAGE'"
                }
            }
        }
    }
}
