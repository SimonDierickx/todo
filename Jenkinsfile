node {
    stage('Preparation') {
        catchError(buildResult: 'SUCCESS') {
            sh 'docker stop todo'
            sh 'docker rm todo'
        }
    }
    stage('Build') {
        build 'todo-app'
    }
    stage('Results') {
        build 'todo-test'
    }
}
