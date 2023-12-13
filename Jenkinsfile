pipeline {
  agent any

  triggers {
    cron '''0 * * * *
  '''
  }

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

    stage('Print environment') {
      steps {
        sh '''/usr/bin/printenv | sort'''
      }
    }

  }

  post {
    always { 
      archiveArtifacts artifacts: 'results.zip, results/summary.txt', fingerprint: true
      junit skipPublishingChecks: true, testResults: 'results/*.xml'
    }

    changed {
      mail to: 'jmcameron@gmail.com', 
      subject: 'BHIMA Tests Regression',
      from: 'bhima@jmcameron.net', 
      body: "Details: ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}, \nBuild: ${env.BUILD_URL} \nConsole Output: ${env.BUILD_URL}console \n${env}"
    }

    failure {  
      mail to: 'jmcameron@gmail.com', 
      subject: 'BHIMA Tests Failure',
      from: 'bhima@jmcameron.net', 
      body: "Details: ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}, \nBuild: ${env.BUILD_URL} \nConsole Output: ${env.BUILD_URL}console \n${env}"
    }  

  }
}
