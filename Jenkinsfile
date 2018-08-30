#!/usr/bin/env groovy

pipeline {
		agent any
    stages {
    		stage('Transfering Files') {
           steps {
              echo 'Transfering Files..'
              sh 'sudo rm -rf web/sites/default/settings.local.php  web/sites/default/settings.php environment'
              sshagent(['JenkinsSSHKey']) {
                sh '''
										alias dev="ssh -o StrictHostKeyChecking=no ubuntu@dev.indiedevshop.com"
										dev "mv /var/www/html/drupal/web/sites/default/settings.php ~/tmp"
										dev "sudo rm -rf /var/www/html/drupal/* "
										scp -o StrictHostKeyChecking=no -r ./ ubuntu@dev.indiedevshop.com:~/tmp
										dev "sudo mv ~/tmp/settings.php ~/tmp/web/sites/default/"
										dev "sudo mv ~/tmp/* /var/www/html/drupal/"
										dev "sudo rm -rf ~/tmp/*"
										dev "sudo chown -R www-data:www-data /var/www/html/drupal/"
                    dev "sudo chmod -R 755 /var/www/html/drupal/"
                '''
               }
        		}
        }
        stage('Build') {
            steps {
                echo 'Building..'
                sshagent(['JenkinsSSHKey']) {
									 sh '''
												alias dev="ssh -o StrictHostKeyChecking=no ubuntu@dev.indiedevshop.com"
												alias dev="ssh -o StrictHostKeyChecking=no ubuntu@dev.indiedevshop.com"
												dev "sudo composer install"
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
