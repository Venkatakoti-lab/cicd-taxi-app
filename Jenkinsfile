pipeline {
    agent {
        label 'maven'
    }
    environment {
        PATH = "/opt/apache-maven-3.9.11/bin:${env.PATH}"
        SONAR_TOKEN = credentials('SONAR_TOKEN')
    }
    stages{
        stage('Cleanup') {
            steps {
                cleanWs()
            }
        }
        stage('build'){
            steps{
                echo "#####BUILD STARTED #########"
                sh 'mvn package'
                echo "##### BUILD COMPLETED #######"
            }
        }
        stage('test'){
            steps{
                echo "##### UNIT TEST STARTED #####"
                sh 'mvn surefire-report:report'
                echo "###### UNIT TEST COMPLETED ########"
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    // Run SonarQube analysis
                    sh """
                    mvn sonar:sonar \
                    -Dsonar.projectKey=taxi-app11 \
                    -Dsonar.organization=taxi-app11 \
                    -Dsonar.host.url=https://sonarcloud.io \
                    -Dsonar.token=${SONAR_TOKEN}
                    """
                }
            }
        }

    }
}