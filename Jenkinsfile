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
        				sshagent(['JenkinsSSHKey']) {
                	sh 'ssh -o StrictHostKeyChecking=no jenkins@dev.indiedevshop.com'
                }
						 		sh 'ssh -o StrictHostKeyChecking=no jenkins@dev.indiedevshop.com rm -rf /var/www/temp_deploy/dist/'
						 		sh 'ssh -o StrictHostKeyChecking=no jenkins@dev.indiedevshop.com mkdir -p /var/www/temp_deploy'
						 		sh 'scp --o StrictHostKeyChecking=no jenkins@dev.indiedevshop.com:/var/www/temp_deploy/dist/'
						 		sh 'ssh -o StrictHostKeyChecking=no jenkins@dev.indiedevshop.com “rm -rf /var/www/example.com/dist/ && mv /var/www/temp_deploy/dist/ /var/www/example.com/”'
						}
        }
    }
}

