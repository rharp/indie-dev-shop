#!/usr/bin/env groovy

pipeline {
		agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh '''
                	composer install --ignore-platform-reqs
                '''
            }
        }
        stage('Transfering Files') {
        	 steps {
        				echo 'Transfering Files..'
        				sshagent(['JenkinsSSHKey']) {
                	sh '''
                     alias dev="ssh -o StrictHostKeyChecking=no jenkins@dev.indiedevshop.com"
                     dev "rm -rf /var/www/temp_deploy"
                     dev "mkdir -p /var/www/temp_deploy"
                     scp -o StrictHostKeyChecking=no -r ./ jenkins@dev.indiedevshop.com:/var/www/temp_deploy/indiedevshop.dev
                     dev "rm -rf /var/www/html/indiedevshop.dev/ && mv /var/www/temp_deploy/indiedevshop.dev/ /var/www/html/"
                '''
                }
						}
        }
    }
}

