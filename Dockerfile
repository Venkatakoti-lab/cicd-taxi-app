From tomcat:9
LABEL project="taxi-cicd" \
      environment="dev"
COPY ./taxi-booking/target/taxi-booking-1.0.1.war /usr/local/tomcat/webapps
EXPOSE 8080
