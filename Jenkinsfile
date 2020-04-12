pipeline {
    options
    {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    agent any
    environment 
    {
        PROJECT = 'udacity-capstone/backend'
        ECRURL = 'https://910704919207.dkr.ecr.us-west-2.amazonaws.com'
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
            steps {
                withAWS(region:'us-east-2',credentials:'aws-jenkins') {
                    sh 'echo "Uploading content with AWS creds"'
                    sh 'eval $(aws ecr get-login --no-include-email)'
                    sh "docker tag ${PROJECT} ${IMAGE}"
                    sh "docker push ${ECRURL}/${IMAGE}"
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