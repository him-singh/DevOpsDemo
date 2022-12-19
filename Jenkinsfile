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

        stage('Upload to Nexus') {
            steps {
                nexusArtifactUploader artifacts: [
                  [
                    artifactId: 'DevOpsDemo', 
                    classifier: '', 
                    file: 'target/*.war', 
                    type: 'war'
                  ]
                ], 
                  credentialsId: 'jenkins', 
                  groupId: 'com.blazeclan', 
                  nexusUrl: '43.204.97.142:8081', 
                  nexusVersion: 'nexus2', 
                  protocol: 'http', 
                  repository: 'http://ec2-43-204-97-142.ap-south-1.compute.amazonaws.com:8081/repository/maven-central-repo/', 
                  version: '0.0.1'
            }
        }
     
    }
}
