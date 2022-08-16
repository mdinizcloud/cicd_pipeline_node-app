pipeline {
  agent { label 'master' }
  environment{
    DOCKER_ACCOUNT = "registersp.funcionalcorp.net.br"
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
        sh "docker build -f Dockerfile-terraform -t ${DOCKER_ACCOUNT}/cloud/terraform:${env.BUILD_NUMBER} ."
        sh "docker build -f Dockerfile-cli -t ${DOCKER_ACCOUNT}/cloud/cli:${env.BUILD_NUMBER} . "
      }
    }

    stage('Publish') {
      when {
        branch 'master'
      }
      steps {
          sh "docker push ${DOCKER_ACCOUNT}/cloud/terraform:${env.BUILD_NUMBER}"
          sh "docker push ${DOCKER_ACCOUNT}/cloud/cli:${env.BUILD_NUMBER}"
        }
      }    
    
    stage('Deploy') {
      when {
        branch 'master'
      }
      steps {
        sh "sed 's/terraform:v1/terraform:v${env.BUILD_NUMBER}/' pods.yaml > node-app-pod.yaml"
        sh "kubectl --kubeconfig ~/.ssh/k8s.infra apply -f node-app-pod.yaml"
       }
    }
  }
}

