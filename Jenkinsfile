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
          steps {
            sh '''test
'''
          }
        }

      }
    }

  }
}