FROM openjdk:17
WORKDIR /app
ADD target/*.jar grocerystore.jar
ADD https://github.com/microsoft/ApplicationInsights-Java/releases/download/3.2.9/applicationinsights-agent-3.2.9.jar /applicationinsights-agent-3.2.9.jar
ENV APPLICATIONINSIGHTS_CONNECTION_STRING="InstrumentationKey=58afbe86-7142-4e09-a107-1076a958d84c;IngestionEndpoint=https://australiaeast-1.in.applicationinsights.azure.com/;LiveEndpoint=https://australiaeast.livediagnostics.monitor.azure.com/;ApplicationId=57fd0bae-602d-48d4-bcd3-ea750db9e259"
EXPOSE 8080
ENTRYPOINT ["java", "-javaagent:/applicationinsights-agent-3.2.9.jar", "-Dapplicationinsights.connection.string=${APPLICATIONINSIGHTS_CONNECTION_STRING}", "-jar", "grocerystore.jar"]
