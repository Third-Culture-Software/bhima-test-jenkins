pipeline {
  agent any
  stages {
    stage('Start E2E Tests') {
      parallel {
        stage('Start E2E Tests') {
          agent any
          steps {
            echo 'Starting'
          }
        }

        stage('Execute remote script') {
          agent any
          steps {
            sh '''/home/jenkins/run_e23_tests


'''
          }
        }

      }
    }

  }
}