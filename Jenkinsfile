pipeline {
  agent { label 'master' }
  environment{
    DOCKER_ACCOUNT = "registersp.funcionalcorp.net.br"
    CONTAINER_NAME = "terraform"
    IMAGE = "registersp.funcionalcorp.net.br/terraform"
    image_name = "cloud/terraform"
    }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  triggers {
    cron('@daily')
  }

  // stages {
  //   stage('Build') {
  //     steps {
  //       sh "docker build -f Dockerfile-terraform -t ${DOCKER_ACCOUNT}/cloud/terraform:${env.BUILD_NUMBER} ."
  //     }
  //   }

// BUILD Pipeline Funcional
    stage('Build_C_FUNC') {
      steps {
        container('docker') {
          script {
            docker.withRegistry('https://' + "${docker_registry}", 'register_hub_login') {
                def dockerImage = docker.build("${image_name}:${env.BUILD_NUMBER}")
                dockerImage.push()
            }
          }
        }
      }
    }

//BUILD Pipeline CLOUD Guru
//     stage('Build_C-GURU') {
//         when {
//             branch 'main'
//         }
//         steps {
//             script {
//                 app = docker.build("${IMAGE}")
//                 app.inside {
//                     sh 'echo $(curl localhost:9090)'
//                 }
//             }
//         }
//     }
   
   
    // stage('Push_Image') {
    //     when {
    //         branch 'main'
    //     }
    //     steps {
    //         script {
    //             docker.withRegistry("${REGISTRY}", 'docker_hub_login') {
    //                 app.push("${env.BUILD_NUMBER}")
    //                 app.push("latest")
    //             }
    //         }
    //     }
    // }




    // stage('Publish') {
    //   when {
    //     branch 'master'
    //   }
    //   steps {
    //     withDockerRegistry([ credentialsId: "register_hub_login", url: "" ])
        
        
    //     //docker.withRegistry('https://' + "${docker_registry}", 'registersp-credentials')
        
        
    //      {
    //       sh "docker push ${DOCKER_ACCOUNT}/terraform:${env.BUILD_NUMBER}"
    //       sh "docker push ${DOCKER_ACCOUNT}/cli:${env.BUILD_NUMBER}"
    //     }
    //   }    
    // }
    
    // stage('Deploy') {
    //   when {
    //     branch 'master'
    //   }
    //   steps {
    //     sh "sed 's/terraform:v1/terraform:v${env.BUILD_NUMBER}/' pods.yaml > node-app-pod.yaml"
    //     sh "kubectl --kubeconfig ~/.ssh/k8s.infra apply -f node-app-pod.yaml"
    //    }
    // }

}
