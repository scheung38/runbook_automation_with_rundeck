FROM jordan/rundeck:latest

MAINTAINER Sebastian Cheung <sebastian_cheung@live.com>

# Install EC2 node plugin from https://github.com/rundeck-plugins/rundeck-ec2-nodes-plugin
COPY rundeck-ec2-nodes-plugin-1.5.3.jar /var/lib/rundeck/libext/rundeck-ec2-nodes-plugin-1.5.3.jar

# Install our SSH key
COPY infra-auto.pem /var/lib/rundeck/.ssh/id_rsa
COPY infra-auto.pub /var/lib/rundeck/.ssh/id_rsa.pub

RUN chown rundeck:rundeck /var/lib/rundeck/.ssh/*

ENV SERVER_URL=http://localhost:4440

EXPOSE 4440
