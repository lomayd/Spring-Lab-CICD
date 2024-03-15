FROM openjdk:17-jdk
ARG JAR_FILE=/build/libs/*.jar
COPY ${JAR_FILE} /home/ubuntu/cicd/server.jar
ENTRYPOINT ["java","-jar","/home/ubuntu/cicd/server.jar"]