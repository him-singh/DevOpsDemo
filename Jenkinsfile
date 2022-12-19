pipeline {
    agent any
    tools {
        maven 'Maven 3.8.6'
        jdk 'Java 17.0.5.8'
    }
       

    stages {
        stage('Build') {
            steps {
                sh script: 'mvn clean package'
            }
        }        

        stage('Upload to Nexus') {
            steps {
                nexusArtifactUploader artifacts: [
                  [
                    artifactId: 'DevOpsDemo', 
                    classifier: '', 
                    file: 'target/DevOpsDemo-0.0.1.war', 
                    type: 'war'
                  ]
                ], 
                  credentialsId: 'nexus', 
                  groupId: 'com.blazeclan', 
                  nexusUrl: 'ec2-43-204-97-142.ap-south-1.compute.amazonaws.com:8081', 
                  nexusVersion: 'nexus2', 
                  protocol: 'http', 
                  repository: 'http://ec2-43-204-97-142.ap-south-1.compute.amazonaws.com:8081/repository/maven-central-repo/', 
                  version: '0.0.1'
            }
        }
     
    }
}
