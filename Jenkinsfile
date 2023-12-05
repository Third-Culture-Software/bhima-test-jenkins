pipeline {
  agent any
  stages {
    stage('Start E2E Tests') {
      agent any
      steps {
        echo 'Starting'
      }
    }

    stage('Run E2E test') {
      steps {
        sh '''/home/jenkins/run_e2e_tests
'''
      }
    }

  }
}