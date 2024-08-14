# Use a Maven image to build the application
FROM maven:3.9.4-eclipse-temurin-17 as build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the entire project
COPY . .

# Build the Spring Boot application
RUN mvn package -Dcheckstyle.skip

# Use an OpenJDK image to run the application
FROM eclipse-temurin:17-jdk-jammy

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the Maven build image
COPY --from=build /app/target/*.jar app.jar

# Expose the port the app runs on
EXPOSE 8081

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
