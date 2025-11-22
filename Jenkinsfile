pipeline{
    agent {
        label 'maven'
    }
    environment {
        PATH = "/opt/apache-maven-3.9.11/bin:${env.PATH}"
    }
    stages{
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
    }
}