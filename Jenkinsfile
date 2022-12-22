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
	stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    script{
                        def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                   }
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
                  credentialsId: 'nexus-admin', 
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
                            credentialsId: 'tomcat-new1', 
                            path: '', 
                            url: 'http://13.126.227.54:8080/'
                        )
                    ], 
                    contextPath: 'DevOpsDemo', 
                    war: '**/*.war'
            }
            
        }
    }
    post {
		always {
			script {
				CONSOLE_LOG = "${env.BUILD_URL}/console"
				BUILD_STATUS = currentBuild.currentResult
				if (currentBuild.currentResult == 'SUCCESS') {
					CI_ERROR = "NA"
					}
				}
				
				sendSlackNotifcation()
		}
	}
}
def sendSlackNotifcation() 
{ 
	if ( currentBuild.currentResult == "SUCCESS" ) {
		buildSummary = "Job:  ${env.JOB_NAME}\n Status: *SUCCESS*\n Build Report: ${env.BUILD_URL}"

		slackSend color : "good", message: "${buildSummary}", channel: 'jenkins'
		}
	else {
		buildSummary = "Job:  ${env.JOB_NAME}\n Status: *FAILURE*\n Error description: *${CI_ERROR}* \nBuild Report :${env.BUILD_URL}"
		slackSend color : "danger", message: "${buildSummary}", channel: 'jenkins'
		}
}
