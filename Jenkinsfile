pipeline {
  agent { label 'node1' }
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
        sh "docker build -f Dockerfile-terraform -t ${DOCKER_ACCOUNT}/terraform:latest ."
        sh "docker build -f Dockerfile-cli -t ${DOCKER_ACCOUNT}/cli:latest . "
      }
    }


    stage('Publish') {
      when {
        branch 'master'
      }
      steps {
        withDockerRegistry([ credentialsId: "docker_hub_login", url: "" ]) {
          sh "docker push ${DOCKER_ACCOUNT}/terraform:latest"
          sh "docker push ${DOCKER_ACCOUNT}/cli:latest"
        }
      }
    }
  }
}
