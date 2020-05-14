FROM maven:3.6-jdk-11 AS build

COPY src /usr/src/app/src
COPY RScripts /usr/is2/RScripts
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:11-jdk-slim

COPY --from=build /usr/src/app/target/is2.jar /usr/app/is2.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/is2.jar"]
