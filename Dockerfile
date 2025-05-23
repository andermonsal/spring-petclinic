
FROM anapsix/alpine-java
LABEL maintainer="andermonsal@gmail.com"
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
