#!/usr/bin/env groovy

pipeline {
		agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'composer install --ignore-platform-reqs'
            }
        }
        stage('Transfering Files') {
        	 steps {
        				echo 'Transfering..'
                sh 'rm -rf ../html'
                sh 'mkdir ../html'
                sh 'cp -r ./ ../html'
						 		sh 'ssh -i  /home/ubuntu/.ssh/id_rsa jenkins@dev.indiedevshop.com -o StrictHostKeyChecking=no rm -rf /var/www/temp_deploy/dist/'
						}
        }
    }
}

