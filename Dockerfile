# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jre-alpine
COPY --from=build /target/*.war app.war
EXPOSE 10000
ENTRYPOINT ["java", "-jar", "app.war"]