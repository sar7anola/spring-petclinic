FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /src
COPY . .

RUN mvn -B -DskipTests package



FROM eclipse-temurin:17-jre
WORKDIR /app

COPY --from=build /src/target/*.jar /app/app.jar
EXPOSE 8080

HEALTHCHECK CMD curl -fsS http://localhost:8080/actuator/health || exit 1
ENTRYPOINT ["java","-jar","/app/app.jar"]
