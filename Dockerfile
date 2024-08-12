# Stage 1: Build the application
FROM maven:3.8.3-openjdk-17-slim AS build
WORKDIR /home/app
COPY spring-petclinic /home/app
RUN ./mvnw clean install

# Stage 2: Run the application
FROM openjdk:17-jdk-slim
COPY --from=build /home/app/target/spring-petclinic-3.3.0-SNAPSHOT.jar /usr/local/lib/app.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar", "--server.port=8081"]