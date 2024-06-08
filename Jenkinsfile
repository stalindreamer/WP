pipeline {
    agent any

       
    stages {

            stage('Test') {
      steps {
        echo 'Testing...'
        snykSecurity(
          snykInstallation: 'snyk-tool',
          snykTokenId: '0941a202-9571-4b42-8f17-518d8ad5273d',
          // place other parameters here
        )
      }
    }
        stage('SonarQube Analysis') {
            steps {
                script {
            scannerHome = tool 'sonar-qubes'// must match the name of an actual scanner installation directory on your Jenkins build agent
        }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
			withSonarQubeEnv('sonar-qube') {// If you have configured more than one global server connection, you can specify its name as configured in Jenkins
          sh "${scannerHome}/bin/sonar-scanner"
}
                timeout(time: 100, unit: 'MINUTES') {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"
                    }
                }
            }
        }
    }
}
}
