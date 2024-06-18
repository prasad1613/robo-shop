#
# Build Stage
#
FROM maven:3.6.3-jdk-8 AS build

WORKDIR /opt/shipping

# Copy and resolve dependencies
COPY pom.xml /opt/shipping/
RUN mvn dependency:go-offline

# Copy source code and build application
COPY src /opt/shipping/src/
RUN mvn package -DskipTests

#
# Runtime Stage
#
FROM openjdk:8-jdk-slim

EXPOSE 8080

WORKDIR /opt/shipping

ENV CART_ENDPOINT=cart:8080
ENV DB_HOST=mysql

# Copy the built JAR file from the build stage
COPY --from=build /opt/shipping/target/shipping-1.0.jar shipping.jar

# Reduce memory usage by setting JVM options
CMD ["java", "-Xmn256m", "-Xmx512m", "-jar", "shipping.jar"]

# #
# # Build
# #
# FROM debian:10 AS build

# RUN apt-get update && apt-get -y install maven

# WORKDIR /opt/shipping

# COPY pom.xml /opt/shipping/
# RUN mvn dependency:resolve
# COPY src /opt/shipping/src/
# RUN mvn package

# #
# # Run
# #
# FROM openjdk:8-jdk

# EXPOSE 8080

# WORKDIR /opt/shipping

# ENV CART_ENDPOINT=cart:8080
# ENV DB_HOST=mysql

# COPY --from=build /opt/shipping/target/shipping-1.0.jar shipping.jar

# CMD [ "java", "-Xmn256m", "-Xmx768m", "-jar", "shipping.jar" ]

