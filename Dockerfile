# Use the official Maven image for a build stage
FROM maven:3.8.4-openjdk-11 as build

# Copy the project files into the container
COPY src /home/app/src
COPY pom.xml /home/app

# Build the application
WORKDIR /home/app
RUN mvn clean package -DskipTests

# Use OpenJDK for the final base image
FROM openjdk:11-jre-slim

# Copy the built artifact from the build stage
COPY --from=build /home/app/target/*.jar /usr/local/lib/grocerystore.jar

# Set the container to run the application
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/grocerystore.jar"]
