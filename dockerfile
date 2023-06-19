FROM tomcat
ADD jenkins-docker/addressbook.war /usr/local/tomcat/webapps
CMD "catalina.sh" "run"
EXPOSE 8080

