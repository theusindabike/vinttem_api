# https://g00glen00b.be/docker-spring-boot/
# Using the alpine image as a base​
FROM openjdk:8-jdk-alpine

# http://blog.zot24.com/tips-tricks-with-alpine-docker/ For keeping size small
RUN apk add --no-cache curl

# Must pass the jar file location to docker at run time via --build-arg JAR_FILE=path/to/jarfile.jar
ARG JAR_FILE=

# https://stackoverflow.com/questions/17466699/not-able-to-build-a-specific-dockerfile
# https://www.ctl.io/developers/blog/post/dockerfile-add-vs-copy/
# Copy the current directory contents into the container at /app
COPY ${JAR_FILE} app.jar

# Setting environment variables
# Note: this application relies on environment variables that contain secrets. Can pass along to image via:
# https://stackoverflow.com/questions/30494050/how-do-i-pass-environment-variables-to-docker-containers
ENV JAVA_OPTS -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000

ENV PORT 8080

# Setting catalina home
ENV CATALINA_HOME /usr/local/tomcat

# Setting spring active profile
ENV SPRING_PROFILES_ACTIVE postgresql

# https://blog.codeship.com/a-beginners-guide-to-the-dockerfile/
# Expose debug port and port 8080
EXPOSE 8000 8080

# https://spring.io/guides/gs/spring-boot-docker/
# https://stackoverflow.com/questions/41935435/understanding-volume-instruction-in-dockerfile
# Setup logging volume and
VOLUME [ "$CATALINA_HOME/logs", "$CATALINA_HOME/downloads/webpages"]

# Actuator health check
HEALTHCHECK --interval=15m --timeout=10s --retries=3 --start-period=1m CMD curl --fail http://localhost:8080/restaurantscores/health || exit 1

# http://containertutorials.com/docker-compose/spring-boot-app.html
# App entry point that must be used
ENTRYPOINT ["java"]

# Using cmd since it can be overridden at run time and Heroku deployment requires this
# https://www.ctl.io/developers/blog/post/dockerfile-entrypoint-vs-cmd/
CMD ["-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]