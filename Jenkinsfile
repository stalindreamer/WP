pipeline {
    agent any

       
    stages {

        
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
			withSonarQubeEnv('sonar-qubes') {// If you have configured more than one global server connection, you can specify its name as configured in Jenkins
          sh "${scannerHome}/bin/sonar-scanner"
}
                timeout(time: 1, unit: 'MINUTES') {
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
