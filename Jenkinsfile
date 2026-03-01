pipeline {
    agent any

    environment {
        EC2_IP = "your-ec2-public-ip"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sar7anola/spring-petclinic.git'
            }
        }

        stage('Build') {
            steps {
                sh 'chmod +x mvnw'
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Deploy using Ansible') {
            steps {
                sshagent(['ec2-ssh-key-id']) {
            dir('ansible') {
                sh '''
		ANSIBLE_HOST_KEY_CHECKING=False \
		ansible-playbook -i inventory.ini deploy.yml
		'''
                }
            }
        }
    }
}
    post {
        success {
            echo " Deployment Successful!"
        }
        failure {
            echo " Deployment Failed!"
        }
    }
}
