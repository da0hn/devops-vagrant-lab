FROM maven:3.5-jdk-8 as buildstage
RUN mkdir /opt/notes
WORKDIR /opt/notes
RUN git clone https://github.com/da0hn/java-app-vagrant-lab.git /opt/notes
RUN mvn package -DskipTests

FROM openjdk:8-jdk-alpine
RUN addgroup -S notes && adduser -S notes -G notes
RUN mkdir /opt/notes
RUN chown -R notes:notes /opt/notes
USER notes:notes
WORKDIR /opt/notes
COPY --from=buildstage /opt/notes/target/easy-notes-1.0.0.jar .
COPY application.properties application.properties
ENTRYPOINT [ "java", "-jar", "/opt/notes/app.jar" ]
