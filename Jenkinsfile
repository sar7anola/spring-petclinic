pipeline {
    agent any

    environment {
        COMPOSE_FILE = "docker-compose.yml"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out source code..."
                git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image for Spring PetClinic..."
                sh 'docker build -t petclinic-app .'
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                echo "Deploying application using Docker Compose..."
                sh "docker-compose -f ${COMPOSE_FILE} down || true"
                sh "docker-compose -f ${COMPOSE_FILE} up -d --build"
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    def response = sh(script: "curl -s -o /dev/null -w '%{http_code}' http://localhost:8080/actuator/health", returnStdout: true).trim()
                    if (response != "200") {
                        error "Application did not start correctly! HTTP code: ${response}"
                    } else {
                        echo "Application is running successfully! ✅"
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up workspace..."
            cleanWs()
        }
        failure {
            echo "Pipeline failed ❌"
        }
        success {
            echo "Pipeline finished successfully ✅"
        }
    }
}

