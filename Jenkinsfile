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

  post {
    always { 
      archiveArtifacts artifacts: 'results.zip, results/summary.txt', fingerprint: true
      junit 'results/*.xml'
    }

    failure {  
      mail to: 'jmcameron@gmail.com', 
      subject: 'Failing BHIMA End-to-end Tests',
      from: 'noreply+jenkins@bhima-test.local', 
      body: "Details: ${env.JOB_NAME} Build Number: ${env.BUILD_NUMBER} Build: ${env.BUILD_URL} Console Output: ${env.BUILD_URL}/console"
    }  

  }
}
