pipeline {
    agent any
    tools {
        maven 'Maven 3.9.11'
    }
    environment {
        IMAGE_NAME = 'lakhanyawa157/demo1-java-app'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Build .jar') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Build & Push Docker Image') {
            steps {
                script {
                    def appImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                    withCredentials([usernamePassword(credentialsId: 'lakhanyawa157', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                        appImage.push()
                        appImage.push('latest')
                    }
                }
            }
        }
    }
    post {
        success {
            echo "Deployment succeeded: ${IMAGE_NAME}:${IMAGE_TAG}"
        }
        failure {
            echo "Deployment failed."
        }
    }
}

