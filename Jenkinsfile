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
        				sshagent(['JenkinsSSHKey']) {
                	sh '''
                     alias dev="ssh -o StrictHostKeyChecking=no jenkins@dev.indiedevshop.com"
                     dev "rm -rf /var/www/temp_deploy"
                     dev "mkdir -p /var/www/temp_deploy"
                     scp -o StrictHostKeyChecking=no -r ./ jenkins@dev.indiedevshop.com:/var/www/temp_deploy/dist
                     dev "rm -rf /var/www/example.com/dist/ && mv /var/www/temp_deploy/dist/ /var/www/html/"
                '''
                }
						}
        }
    }
}

