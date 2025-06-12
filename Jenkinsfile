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
        PORT = "8081"
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

        stage('Build Docker image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run container') {
            steps {
                // Dừng container cũ nếu tồn tại
                sh 'docker stop $CONTAINER_NAME || true'
                sh 'docker rm $CONTAINER_NAME || true'

                // Chạy container mới
                sh 'docker run -d -p $PORT:$PORT --name $CONTAINER_NAME $IMAGE_NAME'
            }
        }
    }
}
