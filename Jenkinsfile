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
        stage('Import Config') {
                	 steps {
                				echo 'Import Config..'
                				sshagent(['JenkinsSSHKey']) {
                        	sh '''
                             alias dev="ssh -o StrictHostKeyChecking=no jenkins@dev.indiedevshop.com"
                             dev "cat /var/www/html/indiedevshop.dev/config/sync/system.site.yml | grep uuid | tail -c +7 | head -c 36 | /var/www/html/indiedevshop.dev/vendor/bin/drush config-set -y system.site uuid - "
                             dev "/var/www/html/indiedevshop.dev/vendor/bin/drush config-import sync --yes"
                        '''
                        }
        						}
                }
    }
}

