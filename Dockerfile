# Build stage
FROM alpine:3.14.3 AS builder

RUN apk --no-cache add openjdk11 maven
RUN mkdir /app
COPY . /app/
WORKDIR /app
RUN mvn clean install


# Run stage
FROM alpine:3.14.3

RUN apk --no-cache add openjdk11-jre
RUN mkdir /opt/spring-boot-helloworld
COPY --from=builder /app/target/hello-world-0.0.1-SNAPSHOT.jar /opt/spring-boot-helloworld/
ENTRYPOINT ["java", "-jar", "/opt/spring-boot-helloworld/hello-world-0.0.1-SNAPSHOT.jar"]
EXPOSE 8080