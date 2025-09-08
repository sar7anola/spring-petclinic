# Use official JDK image
FROM openjdk:21-jdk-slim

# Set working directory
WORKDIR /app

# Copy jar file from target (after mvn package)
COPY target/*.jar app.jar

# Expose app port
EXPOSE 9966

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]

