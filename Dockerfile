FROM maven:3.5.2-jdk-8-alpine AS development
RUN mkdir -p /app
WORKDIR /app
COPY . .
RUN mvn clean package -Dmvn.test.skip=true

FROM java:8-jre-alpine AS production
COPY --from=development /app/target/eureka-server-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8761

ENTRYPOINT ["java","-jar","/app.jar"]