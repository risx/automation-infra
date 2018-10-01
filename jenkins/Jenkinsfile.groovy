pipeline {
    agent any
    options {
        timeout(time: 180, unit: 'MINUTES')
        ansiColor('xterm')
        buildDiscarder(logRotator(daysToKeepStr: '15', numToKeepStr: '30'))
    }

    environment {
        ANSIBLE_FORCE_COLOR = 'true'
        AWS_DEFAULT_OUTPUT = 'json'
    }

    parameters {
        booleanParam(name: 'BUILD', defaultValue: false, desription: '')
        string(name: 'APPLICATION', defaultValue: '', desription: '')
    }

    stages {
        stage('Initial Stage') {
            steps {
                assert APPLICATION
                assert BUILD

                currentBuild.displayName = BUILD_NAME

                echo '''
                ~~~ PARAMETERS ~~~
                ${params}
                '''

                sh 'printenv'
            }
        }
        
    }
}