pipeline {
  agent any
  environment {
    DOCKERHUB_CREDENTIALS = 'dockerhub-lakhanyawa157'
    IMAGE_NAME = 'lakhanyawa157/demo1-java-app'
    IMAGE_TAG = "${env.BUILD_NUMBER}"
  }
  stages {
    stage('Checkout Source') {
      steps {
        git url: 'https://github.com/lakhanyawa157/demo1-java-app.git', credentialsId: 'github-lakhanyawa157'
      }
    }
    stage('Build .jar') {
      steps {
        sh 'mvn clean package -DskipTests'
      }
    }
    stage('Build & Push Docker Image') {
      steps {
        script {
          def appImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
          docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
            appImage.push()
            appImage.push('latest')  // Optional: tag latest
          }
        }
      }
    }
    stage('Deploy to Kubernetes') {
      steps {
        withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
          sh "kubectl set image deployment/demo1-java-app demo1-java-app=${IMAGE_NAME}:${IMAGE_TAG}"
          sh "kubectl rollout status deployment/demo1-java-app"
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

