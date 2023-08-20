pipeline{
	agent any
	tools {
		maven 'mvn3'
	}
	environment {
		CommitID=latestCommitID()
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
				sh 'docker build . -t amiyaranjansahoo/image1:${CommitID}'
			}
		}
		
		stage('Docker login and push'){
			steps{
				echo 'stage3'
				echo 'Docker login and push'
				withCredentials([string(credentialsId: 'dockerhubpswd', variable: 'dockerhbpwd')]) {
					sh 'docker login -u amiyaranjansahoo -p {dockerhbpwd}'
					sh 'docker push amiyaranjansahoo/image1:${CommitID}
				}
			}
		}
		
		stage('Transfer to docker machine'){
			steps{
				echo 'stage4'
				echo 'Transfer to docker machine'
				sshagent(['tomcat']) {
					sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.47.189 docker container rm -f myweb'
					sh 'ssh ec2-user@172.31.47.189 docker container run -itd amiyaranjansahoo/image1:${CommitID} -p 8080:8080 --name myweb'
				}
				
			}
		}
	}
	
	def latestCommitID() {
	def latestCommitID=sh returnStdout: true, script: 'git rev-parse HEAD'
	return latestCommitID
} 
}
