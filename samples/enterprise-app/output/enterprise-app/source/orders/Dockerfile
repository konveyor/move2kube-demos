#   Copyright IBM Corporation 2021
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

FROM registry.access.redhat.com/ubi8/ubi:latest AS builder
RUN yum install -y java-1.8.0-openjdk-devel
ENV SERVER_PORT 8080
ENV SPRING_PROFILES_ACTIVE prod-externaldb
WORKDIR /app
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn
RUN ./mvnw dependency:resolve
COPY . .
RUN ./mvnw clean package -Dmaven.test.skip -P prod-externaldb

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest
ENV SERVER_PORT 8080
ENV SPRING_PROFILES_ACTIVE prod-externaldb
RUN microdnf update \
   && microdnf install --nodocs \
      java-1.8.0-openjdk-devel \
   && microdnf clean all
COPY --from=builder /app/target/orders-2.0.0-SNAPSHOT.jar .
EXPOSE 8080
CMD ["java", "-jar", "orders-2.0.0-SNAPSHOT.jar"]