pipeline {
  agent any
  stages {
    stage('Start E2E Tests') {
      agent any
      steps {
        echo 'Starting'
      }
    }

    stage('Run remote E2E tests') {
      steps {
        sh '''/home/jenkins/builds/run_tests'''
      }
    }

  }
}
