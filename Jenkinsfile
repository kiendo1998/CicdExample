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
        JAR_NAME = "demo-app-1.0.0.jar"
        LOG_FILE = "app.log"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Stop Old App') {
            steps {
                // Tìm và kill app cũ đang chạy (nếu có)
                sh '''
                    PID=$(ps aux | grep $JAR_NAME | grep -v grep | awk '{print $2}')
                    if [ ! -z "$PID" ]; then
                        kill -9 $PID
                    fi
                '''
            }
        }

        stage('Run New App') {
            steps {
                // Chạy app mới nền
                sh 'nohup java -jar target/$JAR_NAME > $LOG_FILE 2>&1 &'
            }
        }
    }
}
