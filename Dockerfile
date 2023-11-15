FROM tomcat:8
# take the war and copy the webapps to tomcat
Copy target/*.war /usr/local/tomcat/webapps/XYZtechnologies-1.0.war