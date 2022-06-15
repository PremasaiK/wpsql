
pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('docker-premasaik')
		POD_NAME = "tmp"
	}

	stages {

		stage('Build') {

			steps {
				sh 'docker build -t premasaik/wordpress .'
			}
		}
		stage('Login to Docker') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push to Docker') {

			steps {
				sh 'docker push premasaik/wordpress'
				
			}
		}

		
		stage('Deploy to K8s')
		{
			steps{
				sshagent(['premasaik-k8s'])
				{
					sh 'scp -v -r -o StrictHostKeyChecking=no /home/premasai/wpsql/wordpress.yml /home/premasai/wpsql/mysql.yml premasai@127.0.0.1:/home/premasai'
					
					script{
						try{
              						sh 'ssh premasai@127.0.0.1 kubectl apply -k ./'
							//sh 'ssh premasai@127.0.0.1 kubectl apply -f wordpress-deployment.yaml'
							sh 'ssh premasai@127.0.0.1 kubectl get pods | grep "^wordpress-mysql*"'
							sh 'ssh premasai@127.0.0.1 kubectl get pods | grep "^word*"'
							sleep 5
							ret1 = sh ( script:'ssh premasai@127.0.0.1 kubectl get pods | grep "^wordpress-mysql*" | awk \'{print $3}\'',returnStdout: true).trim()
							println ret1
							ret2 = sh ( script:'ssh premasai@127.0.0.1 kubectl get pods | grep "^wordpress*" | awk \'{print $1}\'',returnStdout: true).trim()
							echo "1"
							println "${ret2}"
							echo "2"
							println ret2
							echo "3"
							echo  ret2
							}catch(error)
							{
							 echo "failed"							}
					}
				}
			}
		}
	}

	post {
		always {
			sh 'docker logout '
		}
	}

}
