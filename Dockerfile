# Use Amazon Corretto 17 as the base image
FROM amazoncorretto:17

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven wrapper and pom.xml files first to leverage caching for dependencies
COPY ./mvnw ./mvnw
COPY ./pom.xml ./pom.xml
COPY ./.mvn ./.mvn
RUN chmod +x mvnw

# Run Maven to resolve dependencies
RUN ./mvnw dependency:resolve

# Copy the source code into the container
COPY ./src ./src

# Build the Spring Boot application
RUN ./mvnw package -DskipTests

COPY target/docker-example-1.1.3.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]

# Expose the default Spring Boot port
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "target/docker-example-1.1.3.jar"]