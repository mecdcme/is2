FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY target/*.jar is2.jar
ENTRYPOINT ["java","-jar","/is2.jar"]