pipeline{
	agent any
	tools {
		maven 'mvn3'
	}
	

	stages{
		stage('build using maven'){
			steps{
				echo 'stage1'
				echo 'build using maven'
				sh 'mvn clean package'
			}
		}
		
		stage('Docker build'){
			steps{
				echo 'stage2'
				echo 'Docker build'
				sh "docker build . -t amiyaranjansahoo/image1:${env.BUILD_NUMBER}"
			}
		}
		
		stage('Docker login and push'){
			steps{
				echo 'stage3'
				echo 'Docker login and push'
				withCredentials([string(credentialsId: 'dockerhubpswd', variable: 'dockerhbpwd')]) {
					sh "docker login -u amiyaranjansahoo -p ${dockerhbpwd}"
					sh "docker push amiyaranjansahoo/image1:${env.BUILD_NUMBER}"
				}
			}
		}
		
		stage('Permission change'){
			steps{
          sh "chmod +x modifyTag.sh"
          sh "./modifyTag.sh ${env.BUILD_NUMBER}"
        
			}
		}

    stage('Deploy to k8s'){
			steps{
        sshagent(['minikube']) {
          sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.35.170 kubectl apply -f node-app-pod.yml services.yml"
        }
        
			}
		}

    
	}
	
}
