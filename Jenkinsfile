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
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            
        }
        
        stage('SonarQube Analytics') {
            steps {
                withSonarQubeEnv('sonar-6') {
                    sh 'mvn clean package sonar:sonar'
                }
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
                  nexusUrl: '43.204.97.142:8081', 
                  nexusVersion: 'nexus3', 
                  protocol: 'http', 
                  repository: 'maven-central-repo', 
                  version: '0.0.1'
            }
        }
     
    }
}
