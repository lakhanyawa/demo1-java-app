# Spring Boot 'Hello World' application

## Introduction
This guide aims to instruct the beginners on how to create, build and run a Simple Java Web App based on Spring Boot framework.
Before we begin, I'd like to appreciate Mr. Marcin Wojtysiak's effort in creating [this amazing tutorial](https://github.com/martinwojtus/tutorials/tree/master/spring-boot/hello-world). Also, [here](https://frontbackend.com/spring-boot/your-first-spring-boot-application-hello-world) here you can find detailed instructions on how to use it.

## Containerizing the Application
Eventually, the process of building container images will be a part of CI/CD workflow and will be defined in the CI/CD workflow's configuration. But before it's done, you will have to build the image manually. To do that - install `Docker Engine` on your computer if it is not installed yet.
Clone the repository:
```
git clone https://github.com/andybondar/spring-boot-helloworld-example.git
```
Change directory to the `spring-boot-helloworld-example`
Run `docker build`:
```
docker build -t spring-boot-helloworld:0.0.1 .
```

At this point, the Application is built and ready to run. If you don't want to do a manual building - skip the next chapter.

## Running the Application on your Desktop

You may want to build the App manually and run it on your Desktop without containerizing it, also you may want to build a JAR archive and store it somewhere for later use. In this case, please follow the instructions below in this chapter.

### Requirements

* Java Runtime Environment 8 to 11
* maven 3.3+

### Manual build and running

Assuming that you have cloned the repository and changed the directory to the `spring-boot-helloworld-example`, do whatever changes you need in the Java code, save them and then type:

```
mvn spring-boot:run
```

Maven will build the Application and, if it succeeds, will start the Spring Boot:
```

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.5.RELEASE)

2021-05-29 19:18:57.855  INFO 69 --- [           main] com.springboot.Application               : Starting Application on 325181b77bfe with PID 69 (/opt/spring-boot-helloworld-example/target/classes started by root in /opt/spring-boot-helloworld-example)
2021-05-29 19:18:57.860  INFO 69 --- [           main] com.springboot.Application               : No active profile set, falling back to default profiles: default
2021-05-29 19:18:59.528  INFO 69 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2021-05-29 19:18:59.606  INFO 69 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2021-05-29 19:18:59.606  INFO 69 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.19]
2021-05-29 19:18:59.737  INFO 69 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2021-05-29 19:18:59.738  INFO 69 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 1805 ms
2021-05-29 19:19:00.046  INFO 69 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2021-05-29 19:19:00.329  INFO 69 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2021-05-29 19:19:00.338  INFO 69 --- [           main] com.springboot.Application               : Started Application in 3.224 seconds (JVM running for 27.806)
```

### Building JAR archive
In the project's root folder, run this:
```
mvn clean install
```
If it succeeds, you should be able to find `target/hello-world-0.0.1-SNAPSHOT.jar` in the `target` directory.

## Provisioning a Kubernetes Cluster
TBD

## Running the Application in a Kubernetes cluster
For now it is assumed that the Kubernetes Cluster is up and running and it is GKE Kubernetes Cluster. However, other Cloud Kubernetes Services, such as AWS EKS, AKS, etc. -  also will do.

### Send container image to container registry
In this tutorial we will use https://hub.docker.com/ container registry, but any alternative, like GCR or AWS ECR will do.

* tag your local image (use your own account name instead of `andriibondarua` hereafter):
```
docker tag { image_id } andriibondarua/spring-boot-helloworld:0.0.1
```

* generate access token in the DockerHub UI: **Account Settings -> Security -> New Access Token**, Follow the instructions
* login to DockerHub (use access token as password):
```
docker login -u andriibondarua
Password:
```

* push container repo to the reqistry:
```
docker push andriibondarua/spring-boot-helloworld:0.0.1
```

### k8s objects
There are 3 k8s objects that we're going to create here:
* Namespace
* Deployment
* Service

### Deployment
It is assumed that `kubectl` CLI is installed on you computer.
Connect to the Kubernetes Cluster, change directory to `k8s` and run the following commands:
```
kubectl apply -f ns.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml 
```

## Using CI to build and containerize the Application
### GitHub Actions
TBD

### Jenkins
TBD

### GitLab CI
TBD