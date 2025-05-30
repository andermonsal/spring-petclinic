pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'amonsalve763/spring-petclinic'
    DOCKER_TAG   = 'latest'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main',
            url:    'https://github.com/andermonsal/spring-petclinic.git',
            credentialsId: 'github-token'
      }
    }

    stage('Maven Build') {
      agent {
        docker {
          image 'maven:3.9.6-eclipse-temurin-17'
          args  '-v $HOME/.m2:/root/.m2 --entrypoint=""'
        }
      }
      steps {
        sh 'mvn clean install'
      }
    }

    stage('Docker Build') {
      agent any
      steps {
        sh '''
          docker build \
            -t ${DOCKER_IMAGE}:${DOCKER_TAG} \
            .
        '''
      }
    }

    stage('Docker Push') {
      when { branch 'main' }
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'docker-hub-creds',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
          '''
        }
      }
    }
  }

  post {
    always {
      echo "Pipeline completado - Limpieza de workspace"
    }
  }
}

