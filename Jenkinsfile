pipeline {
  agent { label 'master' }
  environment{
    DOCKER_ACCOUNT = "ma31121990"
    DOCKER_LOGIN = "docker_hub_login"
    CONTAINER_NAME_1 = "terraform"
    CONTAINER_NAME_2 = "cli"

    }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  triggers {
    cron('@daily')
  }

  stages {
    stage('Build') {
      steps {
        sh "docker build -f Dockerfile-terraform -t ${DOCKER_ACCOUNT}/terraform:${env.BUILD_NUMBER} ."
        sh "docker build -f Dockerfile-cli -t ${DOCKER_ACCOUNT}/cli:${env.BUILD_NUMBER} . "
      }
    }

    stage('Publish') {
      when {
        branch 'master'
      }
      steps {
        withDockerRegistry([ credentialsId: "docker_hub_login", url: "" ]) {
          sh "docker push ${DOCKER_ACCOUNT}/terraform:${env.BUILD_NUMBER}"
          sh "docker push ${DOCKER_ACCOUNT}/cli:${env.BUILD_NUMBER}"
        }
      }
    }

    stage('Deploy') {
      when {
        branch 'master'
      }
      steps {
        sh "sed 's/v1/${env.BUILD_NUMBER}/' pods.yaml > node-app-pod.yaml"
        sh "kubectl apply -f ~/."
     
      }
    }
  }
}

