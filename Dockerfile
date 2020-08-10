FROM maven:3.5-jdk-8 as maven_builder

WORKDIR /app

ADD ../pom.xml .

RUN mvn dependency:go-offline -B

ADD .. .

RUN mvn package

FROM tomcat:9.0.17-jre11

COPY --from=maven_builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war