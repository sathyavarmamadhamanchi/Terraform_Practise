FROM alpine/git as Build
WORKDIR /app
RUN git clone https://github.com/HouariZegai/Calculator.git

FROM maven:3.5-jdk-8-alpine as install
WORKDIR /app
COPY --from=0/app/Calculator
RUN mvn clean install

FROM openjdk:11.0.13-jre-slim
WORKDIR /app
COPY --from=1/app/Calculator.jar
CMD ["java","-jar","/app/Calculator.jar"]


