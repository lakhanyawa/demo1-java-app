pipeline {
    agent any
    tools {
        maven 'Maven 3.9.11'  
    }
    environment {
        JAR_NAME = 'hello-world-0.0.1-SNAPSHOT.jar'
    }
    stages {
        stage('Checkout') {
            steps {
                // Git repository se code checkout karein
                git url: 'https://github.com/lakhanyawa/demo1-java-app.git', branch: 'main'
            }
        }
        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        stage('Run Application') {
            steps {
                sh "java -jar target/${JAR_NAME}"
            }
        }
    }
    post {
        success {
            echo "Deployment successful!"
        }
        failure {
            echo "Deployment failed."
        }
    }
}

