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
                     alias dev="ssh -o StrictHostKeyChecking=no ubuntu@dev.indiedevshop.com"
                     dev "rm -rf /var/www/html/temp/dev"
                     dev "mkdir -p /var/www/html/temp/dev"
                     scp -o StrictHostKeyChecking=no -r ./ ubuntu@dev.indiedevshop.com:/var/www/html/temp/dev/
                     dev "rm -rf /var/www/html/drupal/* && mv /var/www/html/temp/dev/* /var/www/html/drupal/"
                '''
                }
						}
        }
        stage('Import Config') {
                	 steps {
                				echo 'Import Config..'
                				sshagent(['JenkinsSSHKey']) {
                        	sh '''
                             alias dev="ssh -o StrictHostKeyChecking=no ubuntu@dev.indiedevshop.com"
                             dev "cat /var/www/html/drupal/config/sync/system.site.yml | grep uuid | tail -c +7 | head -c 36 | /var/www/html/drupal/vendor/bin/drush config-set -y system.site uuid - "
                             dev "/var/www/html/drupal/vendor/bin/drush config-import sync --yes"
                        '''
                        }
        						}
                }
    }
}

