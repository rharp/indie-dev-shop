#!/usr/bin/env groovy

pipeline {
		agent any
    stages {
    		stage('Transfering Files') {
           steps {
              echo 'Transfering Files..'
              sshagent(['JenkinsSSHKey']) {
                sh '''
										alias dev="ssh -o StrictHostKeyChecking=no ubuntu@dev.indiedevshop.com"
										dev "rm -rf /var/www/html/drupal/*"
										scp -o StrictHostKeyChecking=no -r ./ ubuntu@dev.indiedevshop.com:/var/www/html/drupal
										dev "sudo chown -R www-data:www-data /var/www/html/drupal/"
                    dev "sudo chmod -R 755 /var/www/html/drupal/"
                '''
               }
        		}
        }
        stage('Build') {
            steps {
                echo 'Building..'
                sh '''
										alias dev="ssh -o StrictHostKeyChecking=no ubuntu@dev.indiedevshop.com"
										dev "composer install"
                '''
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
        stage('Clear Cache') {
            steps {
                 echo 'Clearing Cache..'
                 sshagent(['JenkinsSSHKey']) {
									 sh '''
												alias dev="ssh -o StrictHostKeyChecking=no ubuntu@dev.indiedevshop.com"
												dev "/var/www/html/drupal/vendor/bin/drush cache-clear drush"
												dev "/var/www/html/drupal/vendor/bin/drush cr"
									 '''
                  }
             }
        }
    }
}
