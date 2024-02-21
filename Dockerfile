FROM openjdk:11
ARG JAR_FILE=target/*.war
COPY ${JAR_FILE} app.wr
ENTRYPOINT ["java","-war","/app.war"]
EXPOSE 8081
