pipeline {
    agent any

    parameters {
        choice(
            name: 'NGINX_HOST',
            choices: ['both', 'web1', 'web2'],
            description: 'Select which Nginx server(s) to view'
        )

        string(
            name: 'NUM_LINES',
            defaultValue: '200',
            description: 'Number of lines to display from the Nginx config'
        )
    }

    environment {
        SSH_KEY = credentials('nginx-ssh-key')
        NGINX_FILE = "/etc/nginx/sites-enabled/localhost"
    }

    stages {
        stage('View Nginx Configuration') {
            steps {
                script {

                    // ---------------------------
                    // Select target hosts
                    // ---------------------------
                    def targetHosts = []

                    if (params.NGINX_HOST == "both") {
//                        targetHosts = ["172.31.42.57", "172.31.42.58"] // Replace with web1 & web2 IPs
                        targetHosts = ["172.31.42.57", "172.31.42.57"]
                    } else if (params.NGINX_HOST == "web1") {
                        targetHosts = ["172.31.42.57"]
                    } else if (params.NGINX_HOST == "web2") {
                        targetHosts = ["172.31.42.58"]
                    }

                    // ---------------------------
                    // Execute cat on each host
                    // ---------------------------
                    targetHosts.each { host ->
                        echo "Showing first ${params.NUM_LINES} lines of Nginx config on server: ${host}"

                        sh """
                            ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ec2-user@${host} '
                                sudo sed -n "1,${NUM_LINES}p" ${NGINX_FILE}
                            '
                        """
                    }
                }
            }
        }
    }
}
