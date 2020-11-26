pipeline {
	agent any
	stages {
		stage("Lint Dockerfile") {
			steps {
				sh "docker run --rm -i hadolint/hadolint < Dockerfile"
			}
		}

		stage('Docker build & push') {
            steps {
                script {
                    dockerImage = docker.build("mvechtomova/udacity-devops-capstone")
	                docker.withRegistry('', 'dockerhub_credentials') {
						dockerImage.push("latest")
						dockerImage.push("v2")
					}
		        }
            }
		}
        stage('Deploy to EKS') {
            steps {
		        withAWS(credentials: 'aws-static', region: 'us-west-2') {
			        sh "aws eks --region us-west-2 update-kubeconfig --name UdacityCapstoneProject-cluster"
                    sh "kubectl apply -f k8s/udacity-capstone.yaml"
                    sh "kubectl get nodes"
                    sh "kubectl get pods"
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
