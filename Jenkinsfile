pipeline {
    agent any
    
    options {
    ansiColor('xterm')
    }
    triggers {
        // 每天9点构建
        cron('H 9 * * *')
    }


    parameters { 
        string(defaultValue: 'latest', name: 'GIT_TAG', description: '默认master\n1.指定branch/tag' )
    booleanParam(name: 'NEED_PACKAGE', defaultValue: true, description: '是否打包') 
    }



    stages {

        stage('checkout') {
            steps {
                echo "========="
                    echo "检出源码"
                    checkout scm
                    script {
                        if (env.GIT_TAG == 'latest') {
                                sh '''
                            git checkout -b ${GIT_TAG}
                            '''
                        } else{
                            sh '''
                            git checkout  ${GIT_TAG}
                        '''
                        }
                    }
                
                    echo "========="
            }
        }


        stage('build-image') {
            steps {
                echo '======================================='
                    echo '编译镜像'
                    echo '======================================='
            }
        }


        stage('test') {
            steps {
                echo '======================================='
                    echo 'test..'
                    echo '======================================='

            }
        }

        stage('package') {
            steps {
                echo '======================================='
                    echo '打包编译文件'
                    echo '======================================='
                script {
                        echo env.NEED_PACKAGE
                        if (env.NEED_PACKAGE) {
                            sh """
                            export GIT_TAG=`echo ${GIT_TAG}|sed "s|/|_|g"`
                            echo "======="
                            echo ${GIT_TAG}
                            echo "======="
                            #cd ${WORKSPACE}
                            #bash package.sh

                            make build_tar_gz

                            """


                        } else {
                            echo "nonononono need package...."
                            // echo "指定编译版本 ${GIT_TAG},发布到指定目录"

                        }

                    }
            }
        }
            
        stage("SonarQube analysis") {
            // 只有在 dev 分支才发送到 SonarQube 进行代码分析
            //when {
            //    branch 'dev'
            //}
            //sonar.logintoken 固定
            steps {
                echo '======================================='
                echo 'SonarQube 源码分析'
                echo '======================================='
                withSonarQubeEnv('sonarqube') {
                    //sh 'mvn sonar:sonar -Dsonar.host.url=http://sonarqube.basin.ali:9000 -Dsonar.login=78de1d060cdffc09fcfc0047be15ac0a5f50d2e0'
                    // sh '''
                    //   docker run --rm -v $(pwd):/root/src  \
                    //     --add-host sonarqube.basin.ali:47.100.219.148 \
                    //     zaquestion/sonarqube-scanner sonar-scanner \
                    //     -Dsonar.host.url=http://sonarqube.basin.ali:9000 \
                    //     -Dsonar.login=78de1d060cdffc09fcfc0047be15ac0a5f50d2e0 \
                    //     -Dsonar.projectKey=basin-${JOB_NAME} \
                    //     -Dsonar.projectName="${JOB_NAME}" \
                    //     -Dsonar.projectVersion=1 \
                    //     -Dsonar.language=py  \
                    //     -Dsonar.python.pylint=/usr/bin/pylint \
                    //     -Dsonar.sources=./
                    // '''
                }
            }
            //其他语言
        }

        
       


        
        stage('publish snapshots') {

             steps {
                echo '======================================='
                echo '发布到snapshots'
                echo '======================================='
                script {
                    if(env.GIT_TAG=='latest'){
                        sshPublisher(
                            publishers: [
                                sshPublisherDesc(
                                    configName: 'release-server',
                                    transfers: [
                                            sshTransfer(
                                                    // excludes: '**/ambari-metrics-assembly*.rpm',
                                                    execCommand: '',
                                                    execTimeout: 120000,
                                                    flatten: false,
                                                    makeEmptyDirs: false,
                                                    noDefaultExcludes: false,
                                                    patternSeparator: '[, ]+',
                                                    remoteDirectory: "${JOB_NAME}/snapshots",
                                                    remoteDirectorySDF: false,
                                                    //removePrefix: 'dist/docker_images',
                                                    //sourceFiles: 'dist/docker_images/*.tar,dist/docker_images/*.tar.gz'
                                                    removePrefix: '',
                                                    sourceFiles: '*.tar.gz'
                                            )
                                    ],
                                    usePromotionTimestamp: false,
                                    useWorkspaceInPromotion: false,
                                    verbose: true
                                )
                            ]
                        )
                    }
               
               }
            }
        }


        stage('publish release') {

             steps {
                echo '======================================='
                echo '发布到releases'
                echo '======================================='
                script {
                    if(env.GIT_TAG != 'latest'){
                        sshPublisher(
                            publishers: [
                                sshPublisherDesc(
                                    configName: 'release-server',
                                    transfers: [
                                            sshTransfer(
                                                    // excludes: '**/ambari-metrics-assembly*.rpm',
                                                    // excludes: '**/*.tar',
                                                    execCommand: '',
                                                    execTimeout: 120000,
                                                    flatten: false,
                                                    makeEmptyDirs: false,
                                                    noDefaultExcludes: false,
                                                    patternSeparator: '[, ]+',
                                                    remoteDirectory: "${JOB_NAME}/release",
                                                    remoteDirectorySDF: false,
                                                    //removePrefix: 'dist/docker_images',
                                                    //sourceFiles: 'dist/docker_images/*.tar,dist/docker_images/*.tar.gz'
                                                    removePrefix: '',
                                                    sourceFiles: '*.tar.gz'
                                            )
                                    ],
                                    usePromotionTimestamp: false,
                                    useWorkspaceInPromotion: false,
                                    verbose: true
                                )
                            ]
                        )
                    }
               
               }
            }
        }


    }
    //post 这段直接复制
    post {
         always {
             echo 'One way or another, I have finished'
             deleteDir() /* clean up our workspace */
         }
        success {
            httpRequest consoleLogResponseBody: true, contentType: 'APPLICATION_JSON_UTF8', httpMode: 'POST', ignoreSslErrors: true, requestBody: """{
                "msgtype": "link",
                    "link": {
                        "title": "${env.JOB_NAME}${env.BUILD_DISPLAY_NAME} 构建成功",
                        "text": "项目[${env.JOB_NAME}${env.BUILD_DISPLAY_NAME}] 构建成功，构建耗时 ${currentBuild.durationString}",
                        "picUrl": "http://icons.iconarchive.com/icons/paomedia/small-n-flat/1024/sign-check-icon.png",
                        "messageUrl": "${env.BUILD_URL}"
                    }
            }""", responseHandle: 'NONE', url: 'https://oapi.dingtalk.com/robot/send?access_token=fd87df4f83611b4c4cf31d5ad48f890f9603b57b1cac3d52fb80df8b86a5b629'
        }
        failure {
            httpRequest consoleLogResponseBody: true, contentType: 'APPLICATION_JSON_UTF8', httpMode: 'POST', ignoreSslErrors: true, requestBody: """{
                "msgtype": "link",
                    "link": {
                        "title": "${env.JOB_NAME}${env.BUILD_DISPLAY_NAME} 构建失败",
                        "text": "项目[${env.JOB_NAME}${env.BUILD_DISPLAY_NAME}] 构建失败，构建耗时 ${currentBuild.durationString}",
                        "picUrl": "http://www.iconsdb.com/icons/preview/soylent-red/x-mark-3-xxl.png",
                        "messageUrl": "${env.BUILD_URL}"
                    }
            }""", responseHandle: 'NONE', url: 'https://oapi.dingtalk.com/robot/send?access_token=fd87df4f83611b4c4cf31d5ad48f890f9603b57b1cac3d52fb80df8b86a5b629'
        }
    }
}
