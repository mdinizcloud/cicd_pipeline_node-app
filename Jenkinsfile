pipeline {
  agent { label 'master' }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  triggers {
    cron('@daily')
  }

 stages {
// BUILD Pipeline Funcional
    stage('Build_C_FUNC') {
      steps {
         script {
            docker.withRegistry('https://' + "${docker_registry}", 'register_hub_login') {
                def dockerImage = docker.build("${image_name}:${env.BUILD_NUMBER}")
                dockerImage.push()
              }
          }
        }
     }
 
    stage('Deploy_PRD') {
      steps {
        sh "sed 's/terraform:1/terraform:${env.BUILD_NUMBER}/' pods.yaml > node-app-pod.yaml"
        sh "kubectl --kubeconfig ~/.ssh/k8s.infra apply -f node-app-pod.yaml"
        sh "kubectl --kubeconfig ~/.ssh/k8s.infra apply -f services.yaml"
       }
    }

  }
}