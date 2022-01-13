.PHONY: all
all: clean build
	docker run --rm -it -v "${PWD}/build/libs/ROOT.war:/usr/local/tomcat/webapps/ROOT.war" -p 8080:8080 tomcat:10-jdk8-corretto

.PHONY: clean
clean:
	rm -rf build

.PHONY: build
build:
	./gradlew build
