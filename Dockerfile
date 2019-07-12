FROM tomcat:8

MAINTAINER GG
WORKDIR /var/lib/jenkins/workspace/PipeSharedLib
COPY /target/*.war /usr/local/tomcat/webapps/

EXPOSE 8080
