pipeline {
    options
    {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    agent any
    environment 
    {
        PROJECT = 'udacity-capstone/backend'
        IMAGE = ''
        VERSION = ''
    }
    stages {

        stage('Docker Test') {
            steps {
                sh 'make docker-test'
            }
        }

        stage('Version image'){
            steps{
                script{
                    VERSION = "${GIT_COMMIT}".take(7)
                    IMAGE = "${PROJECT}:${VERSION}" 
                }
            }
        }
        
        stage('Upload to ECR') {
            options {
                withAWS(region:'us-east-2',credentials:'aws-jenkins') 
            }
            steps {
                script{
                    sh 'echo "Uploading content with AWS creds"'
                    LOGIN_SCRIPT = sh (script: 'aws ecr get-login --no-include-email', returnStdout: true)
                    ECR_URL = sh (script: "echo ${LOGIN_SCRIPT} | cut -d/ -f3", returnStdout: true)
                    sh 'eval $(${LOGIN_SCRIPT})'
                    sh "docker tag ${PROJECT} ${IMAGE}"
                    sh "docker push ${ECR_URL}/${IMAGE}"
                }
            }
        }
    }
    post{
        always{
            sh "docker rmi ${IMAGE} | true"
        }
    }
}