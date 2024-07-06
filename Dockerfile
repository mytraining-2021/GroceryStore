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

# Set the Application Insights environment variables
ENV APPLICATIONINSIGHTS_CONNECTION_STRING="InstrumentationKey=58afbe86-7142-4e09-a107-1076a958d84c;IngestionEndpoint=https://australiaeast-1.in.applicationinsights.azure.com/;LiveEndpoint=https://australiaeast.livediagnostics.monitor.azure.com/;ApplicationId=57fd0bae-602d-48d4-bcd3-ea750db9e259"


# Copy the built artifact from the build stage
COPY --from=build /home/app/target/*.jar /usr/local/lib/grocerystore.jar

# Set the container to run the application
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/grocerystore.jar"]



