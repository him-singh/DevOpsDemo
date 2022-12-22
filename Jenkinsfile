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
        stage('Deploy on Tomcat9') {
            steps {
                deploy adapters: 
                    [
                        tomcat9
                        (
                            credentialsId: 'c7ea887d-fa1c-4a22-823b-6f420b83c3e6', 
                            path: '', 
                            url: 'http://13.126.227.54:8080/'
                        )
                    ], 
                    contextPath: 'DevOpsDemo', 
                    war: '**/*.war'
            }
            
        }
    }
}
