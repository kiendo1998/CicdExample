pipeline {
    agent any

    triggers {
        githubPush()
    }

    tools {
        maven 'Maven 3.8.1'
        jdk 'JDK 17'
    }

    environment {
        IMAGE_NAME = "demo-app"
        CONTAINER_NAME = "demo-app-container"
        JAR_NAME = "demo-app-1.0.0.jar"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'ff44e37c-bffd-4e53-b89b-9bc205a01bfe',
                    url: 'https://github.com/kiendo1998/CicdExample',
                    branch: 'main'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                    if [ $(docker ps -aq -f name=$CONTAINER_NAME) ]; then
                        docker stop $CONTAINER_NAME || true
                        docker rm $CONTAINER_NAME || true
                    fi
                '''
            }
        }

        stage('Run New Container') {
            steps {
                sh '''
                    docker run -d --name $CONTAINER_NAME -p 8081:8081 $IMAGE_NAME
                    sleep 5
                    docker logs $CONTAINER_NAME
                '''
            }
        }
    }
}
