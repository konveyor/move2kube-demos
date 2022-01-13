# Java Gradle Web App

Webapp built with Gradle. Runs using Java servlet on Tomcat.

![alt text](usage.png)

## Usage

Simply running `make` will build the `ROOT.war` file and deploy it to a Tomcat web server using Docker.  
Access it on [http://localhost:8080](http://localhost:8080)

```console
$ make
rm -rf build
./gradlew build

BUILD SUCCESSFUL in 1s
2 actionable tasks: 2 executed
docker run --rm -it -v "/Users/user/Documents/code/remote/github.com/konveyor/move2kube-demos/samples/language-platforms/java-gradle/build/libs/ROOT.war:/usr/local/tomcat/webapps/ROOT.war" -p 8080:8080 tomcat:10-jdk8-corretto
Using CATALINA_BASE:   /usr/local/tomcat
Using CATALINA_HOME:   /usr/local/tomcat
Using CATALINA_TMPDIR: /usr/local/tomcat/temp
Using JRE_HOME:        /usr/lib/jvm/java-1.8.0-amazon-corretto
Using CLASSPATH:       /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar
Using CATALINA_OPTS:   
13-Jan-2022 18:59:05.294 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version name:   Apache Tomcat/10.0.14
13-Jan-2022 18:59:05.297 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server built:          Dec 2 2021 22:01:36 UTC
13-Jan-2022 18:59:05.297 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version number: 10.0.14.0
13-Jan-2022 18:59:05.297 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Name:               Linux
13-Jan-2022 18:59:05.298 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Version:            5.10.47-linuxkit
13-Jan-2022 18:59:05.298 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Architecture:          amd64
13-Jan-2022 18:59:05.298 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Java Home:             /usr/lib/jvm/java-1.8.0-amazon-corretto/jre
13-Jan-2022 18:59:05.298 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Version:           1.8.0_312-b07
13-Jan-2022 18:59:05.299 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Vendor:            Amazon.com Inc.
13-Jan-2022 18:59:05.299 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_BASE:         /usr/local/tomcat
13-Jan-2022 18:59:05.299 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_HOME:         /usr/local/tomcat
13-Jan-2022 18:59:05.302 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties
13-Jan-2022 18:59:05.302 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
13-Jan-2022 18:59:05.302 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djdk.tls.ephemeralDHKeySize=2048
13-Jan-2022 18:59:05.302 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.protocol.handler.pkgs=org.apache.catalina.webresources
13-Jan-2022 18:59:05.303 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dorg.apache.catalina.security.SecurityListener.UMASK=0027
13-Jan-2022 18:59:05.303 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dignore.endorsed.dirs=
13-Jan-2022 18:59:05.303 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.base=/usr/local/tomcat
13-Jan-2022 18:59:05.303 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.home=/usr/local/tomcat
13-Jan-2022 18:59:05.304 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.io.tmpdir=/usr/local/tomcat/temp
13-Jan-2022 18:59:05.309 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent Loaded Apache Tomcat Native library [1.2.31] using APR version [1.7.0].
13-Jan-2022 18:59:05.309 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent APR capabilities: IPv6 [true], sendfile [true], accept filters [false], random [true], UDS [true].
13-Jan-2022 18:59:05.312 INFO [main] org.apache.catalina.core.AprLifecycleListener.initializeSSL OpenSSL successfully initialized [OpenSSL 1.1.1g FIPS  21 Apr 2020]
13-Jan-2022 18:59:05.697 INFO [main] org.apache.coyote.AbstractProtocol.init Initializing ProtocolHandler ["http-nio-8080"]
13-Jan-2022 18:59:05.720 INFO [main] org.apache.catalina.startup.Catalina.load Server initialization in [690] milliseconds
13-Jan-2022 18:59:05.768 INFO [main] org.apache.catalina.core.StandardService.startInternal Starting service [Catalina]
13-Jan-2022 18:59:05.768 INFO [main] org.apache.catalina.core.StandardEngine.startInternal Starting Servlet engine: [Apache Tomcat/10.0.14]
13-Jan-2022 18:59:05.807 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deploying web application archive [/usr/local/tomcat/webapps/ROOT.war]
13-Jan-2022 18:59:06.091 INFO [main] org.apache.catalina.startup.HostConfig.deployWAR Deployment of web application archive [/usr/local/tomcat/webapps/ROOT.war] has finished in [283] ms
13-Jan-2022 18:59:06.097 INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-nio-8080"]
13-Jan-2022 18:59:06.112 INFO [main] org.apache.catalina.startup.Catalina.start Server startup in [390] milliseconds
```
