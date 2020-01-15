FROM maven:3.6-jdk-8-alpine AS build

COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:8-jdk-alpine

ENV SPRING_DATASOURCE_URL jdbc:postgresql://35.205.163.10:5432/postgres
ENV SPRING_DATASOURCE_USERNAME postgres
ENV SPRING_DATASOURCE_PASSWORD postgres
ENV SPRING_DATASOURCE_DRIVERCLASSNAME org.postgresql.Driver
ENV SPRING_DATASOURCE_PLATFORM postgresql

COPY --from=build /usr/src/app/target/is2.jar /usr/app/is2.jar
#COPY wait-for /usr/app/wait-for
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/is2.jar"]
