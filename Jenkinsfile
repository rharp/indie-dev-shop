#!/usr/bin/env groovy

pipeline {
		agent {
    	node {
        label 'my-defined-label'
    	}
		}
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'make composer-install'
                sh 'vendor/bin/drush site-install minimal --account-pass=admin --yes'
                sh 'cat ./config/sync/system.site.yml |grep uuid | tail -c +7 | head -c 36 |vendor/bin/drush config-set -y system.site uuid - ";'
                sh 'vendor/bin/drush config-import sync --yes;'
            }
        }
    }
}
