pipeline {
    agent any

    environment {
        SONAR_SCANNER_HOME = tool 'sonar-qubes'
    }


    
    stages {

        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-qubes') {
                    bat "${SONAR_SCANNER_HOME}/bin/sonar-scanner"
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
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
