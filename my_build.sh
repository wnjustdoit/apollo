#!/bin/bash

mvn clean install -DskipTests

mvn docker:build -pl apollo-configservice

docker run -p 8073:8073 \
    -e SPRING_DATASOURCE_URL="jdbc:mysql://192.168.1.249:3306/ApolloConfigDB?characterEncoding=utf8" \
    -e SPRING_DATASOURCE_USERNAME=root -e SPRING_DATASOURCE_PASSWORD=1234567 \
    -e SERVER_PORT=8073 \
    -e EUREKA_INSTANCE_IP_ADDRESS=127.0.0.1 \
    -d -v /tmp/apollologs:/opt/logs --name apollo-configservice apolloconfig/apollo-configservice:1.7.1

