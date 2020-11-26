pipeline {
	agent any
	stages {
		stage("Lint Dockerfile") {
			steps {
				script {
                    docker.image('hadolint/hadolint:latest-debian').inside() {
                        sh "hadolint Dockerfile"
                    }
                }
			}
		}


		stage('Docker build & push') {
            steps {
                script {
                    dockerImage = docker.build("mvechtomova/udacity-devops-capstone:latest")
	                docker.withRegistry('', 'dockerhub_credentials') {
						dockerImage.push()
					}
		        }
            }
		}
        stage('Deploy to EKS') {
            steps {
		        withAWS(credentials: 'aws-static', region: 'us-west-2') {
			        sh "aws eks --region eu-west-1 update-kubeconfig --name udacity-devops-capstone"
                    sh "kubectl apply -f udacity-capstone.yaml"
			    }
            }
        }
        stage("Clean up docker") {
            steps {
                script {
                    sh "docker system prune"
                }
            }
        }
    }
}
