FROM maven:3.8-openjdk-11 as builder

WORKDIR /build
COPY ./src ./src
COPY ./WebContent ./WebContent
COPY ./pom.xml ./pom.xml

RUN mvn clean package

FROM tomcat:jdk11-openjdk

WORKDIR /opt
COPY --from=builder /build/WebContent ./WebContent

RUN useradd user
USER user

COPY --from=builder /build/target/PYX-jar-with-dependencies.jar ./app.jar

ENTRYPOINT ["java", "-jar", "/opt/app.jar"]