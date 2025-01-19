# Multi stage build (Build Stage)
# Use Maven as the base image for the build stage
FROM maven:3.9.9-eclipse-temurin-21 AS build
# Copy the entire project directory into the /app directory inside the container
COPY . /app
# Set the working directory to /app inside the container
WORKDIR /app
# Run Maven to clean and build the project, producing the JAR file
RUN mvn clean package
# Runtime Stage
FROM eclipse-temurin:21-jre-alpine 
# Copy the built JAR file from the build stage to the runtime image
COPY --from=build /app/target/dockermastery-0.0.1-SNAPSHOT.jar /app/dockermastery.jar
# Set the working directory to /app inside the runtime container
WORKDIR /app
#Expose port 8080 for the application to listen on
EXPOSE 8080
# Define the entry point to run the application
ENTRYPOINT ["java", "-jar", "dockermastery.jar"]
