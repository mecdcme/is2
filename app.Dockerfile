FROM maven:3.5.2-jdk-8 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:8-jdk-alpine

ENV SPRING_DATASOURCE_URL jdbc:mysql://localhost:3306/IS2?allowPublicKeyRetrieval=true&useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC

COPY --from=build /usr/src/app/target/is2.jar /usr/app/is2.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/is2.jar"]
