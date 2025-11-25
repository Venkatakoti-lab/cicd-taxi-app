def registry = 'https://trialycxxke.jfrog.io/artifactory'
def imageName = 'trialycxxke.jfrog.io/taxi1-docker-local/taxiapp'
def version   = '1.0.1'

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
        stage("Jar Publish") {
            steps {
                script {
                        echo '<--------------- Jar Publish Started --------------->'
                        def server = Artifactory.newServer url:registry ,  credentialsId:"jfrog-cred"
                        def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                        def uploadSpec = """{
                            "files": [
                                {
                                "pattern": "/home/ubuntu/jenkins/workspace/taxi-booking/taxi-booking/target/(*)",
                                "target": "taxi1-libs-release-local/{1}",
                                "flat": "false",
                                "props" : "${properties}",
                                "exclusions": [ "*.sha1", "*.md5"]
                                }
                            ]
                        }"""
                        def buildInfo = server.upload(uploadSpec)
                        buildInfo.env.collect()
                        server.publishBuildInfo(buildInfo)
                        echo '<--------------- Jar Publish Ended --------------->'  
                }
            }   
        }
        stage(" Docker Build ") {
            steps {
                script {
                    echo '<--------------- Docker Build Started --------------->'
                    app = docker.build(imageName+":"+version)
                    echo '<--------------- Docker Build Ends --------------->'
                }
            }
        }
        stage (" Docker Publish "){
            steps {
                script {
                    echo '<--------------- Docker Publish Started --------------->'  
                        docker.withRegistry('https://trialycxxke.jfrog.io', 'jfrog-cred'){
                            app.push()
                        }    
                    echo '<--------------- Docker Publish Ended --------------->'  
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