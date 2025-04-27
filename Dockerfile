FROM anapsix/alpine-java
LABEL maintainer="shanem@liatrio.com"
COPY /target/spring-petclinic.jar /home/spring-petclinic.jar
CMD ["java","-jar","/home/spring-pet.jar"]