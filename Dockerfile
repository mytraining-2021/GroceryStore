FROM openjdk:11-jre-slim
WORKDIR /app
COPY target/helloworld.jar GroceryStore.jar
COPY path/to/applicationinsights-agent-3.2.6.jar applicationinsights-agent.jar
ENV APPLICATION_INSIGHTS_IKEY="InstrumentationKey=58afbe86-7142-4e09-a107-1076a958d84c;IngestionEndpoint=https://australiaeast-1.in.applicationinsights.azure.com/;LiveEndpoint=https://australiaeast.livediagnostics.monitor.azure.com/;ApplicationId=57fd0bae-602d-48d4-bcd3-ea750db9e259"
EXPOSE 8080
ENTRYPOINT ["java", "-javaagent:/app/applicationinsights-agent.jar", "-jar", "GroceryStore.jar"]
