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
                    ECR_URL = sh (script: "./ci/ecr_login.sh", returnStdout: true)
                    sh "docker tag ${PROJECT} ${ECR_URL}/${IMAGE}"
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