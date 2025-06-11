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

        stage('Stop Old App') {
            steps {
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
                sh(script: '''
                    nohup java -jar target/$JAR_NAME > $LOG_FILE 2>&1 &
                    echo $! > app.pid
                    disown
                    sleep 5
                    if ! ps -p $(cat app.pid) > /dev/null; then
                        echo "App failed to start"
                        cat $LOG_FILE
                        exit 1
                    fi
                    echo "App started successfully on port 8081"
                ''', shell: '/bin/bash')
            }
        }

    }
}
