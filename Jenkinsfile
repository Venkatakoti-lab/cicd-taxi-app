pipeline {
    agent {
        label 'dev'
    }
    environment {
        PATH = "/opt/apache-maven-3.9.11/bin:${env.PATH}"
        SONAR_TOKEN = credentials('SONAR_TOKEN')
    }
    stages{
        stage('build'){
            steps{
                echo "#####BUILD STARTED #########"
                sh 'mvn package'
                echo "##### BUILD COMPLETED ########"
            }
        }
        stage('test'){
            steps{
                echo "##### UNIT TEST STARTED #####"
                sh 'mvn surefire-report:report'
                echo "###### UNIT TEST COMPLETED #########"
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    sh """
                    mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.1.2184:sonar \
                    -Dsonar.projectKey=taxi-app112 \
                    -Dsonar.organization=taxi-app112 \
                    -Dsonar.host.url=https://sonarcloud.io \
                    -Dsonar.token=${SONAR_TOKEN}
                    """
                }
            }
        }

        stage('Cleanup') {
            steps {
                cleanWs()
            }
        }

    }
}