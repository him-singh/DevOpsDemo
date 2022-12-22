pipeline {
    agent any
    tools {
      maven 'maven'
    }

       

    stages {
               
        stage('Build') {
            steps {
                sh script: "mvn clean package"
            }
        }
        stage('SonarQube Analytics') {
            steps {
                withSonarQubeEnv('sonar-6') {
                    sh 'mvn clean package sonar:sonar'
                }
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            
        }
        stage('Deploy on Tomcat9') {
            steps {
                deploy adapters: 
                    [
                        tomcat9
                        (
                            credentialsId: '079dcf3c-3b29-42ec-beba-cee2da6ac99d', 
                            path: '', 
                            url: 'http://43.204.97.142:8080/'
                        )
                    ], 
                    contextPath: 'DevOpsDemo', 
                    war: '**/*.war'
            }
            
        }
        stage('Upload to Nexus') {
            steps {
                nexusArtifactUploader artifacts: [
                  [
                    artifactId: 'DevOpsDemo', 
                    classifier: '', 
                    file: 'target/DevOpsDemo.war', 
                    type: 'war'
                  ]
                ], 
                  credentialsId: 'jenkins', 
                  groupId: 'com.blazeclan', 
                  nexusUrl: '43.205.113.14:8081', 
                  nexusVersion: 'nexus3', 
                  protocol: 'http', 
                  repository: 'jenkins-maven', 
                  version: '0.0.1'
            }
        }
        
    }
}
