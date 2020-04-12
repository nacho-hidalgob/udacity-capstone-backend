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
        stage('Lint pylint') {
            steps {
                sh 'make lint'
            }
        }

        stage('Version Image') {
            steps {
                script{
                    VERSION = "${GIT_COMMIT}".take(7)
                    IMAGE = "${PROJECT}:${VERSION}" 
                }
            }
        }

        stage('Docker build'){
            steps{
                script{
                    docker.build("${IMAGE}")
                }
            }
        }

        stage('Upload to ECR') {
            steps {
                withAWS(region:'us-east-2',credentials:'aws-jenkins') {
                    sh 'echo "Uploading content with AWS creds"'
                    sh 'eval $(aws ecr get-login --no-include-email)'
                    sh "docker push ${ECRURL}/${IMAGE}"
                }
            }
         }
    }
    post{
        always{
            // make sure that the Docker image is removed
            sh "docker rmi $IMAGE | true"
        }
    }
}