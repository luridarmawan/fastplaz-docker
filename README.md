# FastPlaz Docker Template

![FastPlaz logo](http://fastplaz.com/logo-box.png)


## Introduction

Scripts in this repository will show you how to make docker images and use it to deploy fastplaz application. Deploy your FastPlaz Application will more easy and no need much effort. With Docker Compose you can deploy application in many server in simple step.

**FastPlaz** is one of the web framework that created with free pascal programming language. FastPlaz is very fast, lite and simple. Fastplaz has templating support, lots of plugins integration and Simple ORM (Object-Relational Mapping). FastPlaz can be used in shared hosting, not just in vps or dedicated server.
The official FastPlaz site can be found [fastplaz.com](http://www.fastplaz.com).

[**Docker**](https://www.docker.com) is a tool designed to make it easier to create, deploy, and run applications by using containers. Containers allow a developer to package up an application with all of the parts it needs, such as libraries and other dependencies, and ship it all out as one package.

Docker is a tool that is designed to benefit both developers and system administrators, making it a part of many DevOps (developers + operations) toolchains.

## What's Inside

The image is built on top of [`luri/free-pascal:multiarch`](https://hub.docker.com/r/luri/free-pascal) and contains:

- Ubuntu 20.04 LTS
- Free Pascal Compiler 3.2.2
- Apache 2.4 with CGI enabled (`.bin` and `.cgi` files are executed as CGI)
- FastPlaz framework (branch `development`) in `/projects/vendors/fastplaz`
- Echo example project in `/projects/echo`, already compiled
- Supported architectures: `linux/amd64` and `linux/arm64`

## How to use
### Generate Image

Make sure Docker is running and have good internet access,
then run this script

```
$./build.sh [ubuntu] [--push]
```

example:

```
$./build.sh
```

This script will build the image for your local platform and produce image: **fastplaz/ubuntu:latest**.

To build multi-architecture image (amd64 & arm64) and push it to Docker Hub, use `--push`
(requires `docker buildx` and `docker login`):

```
$./build.sh ubuntu --push
```

This will push **fastplaz/ubuntu:latest** and **fastplaz/ubuntu:multiarch**.

You can see the image result from this command

```
$docker images
```

![Docker Images](files/img/docker-images.png)

### Run Container

From Shell, run this script

```
$./container-run.sh
```

if you want to running in detached mode

```
$docker run -d -p 8080:80 fastplaz/ubuntu
```

Then open from your browser:

- http://localhost:8080
- http://localhost:8080/echo/?val1=value1

The Echo example will respond with JSON:

```
{ "code" : 0, "sitename" : "Echo Tester for FastPlaz", "GET" : { "val1" : "value1" }, "time" : "1ms" }
```

Try with any parameters using GET or POST method.


### Enter Container Bash Shell

From Shell, run this script

```
$./bash.sh
```

or with manual command:

```
$docker run -it -p 8080:80 fastplaz/ubuntu bash
```


#### Enter to existing active container

find your active container:

```
$docker ps
```

then execute this command:

```
$docker exec -it [container_id] bash
```

See this illustration
![Example 01](files/img/ex01.png)


### Compile Echo Project

Inside the container:

```
$cd /projects/echo/source/echo/
$./clean.sh
$./compile.sh
```

Output file: `/projects/echo/public_html/echo.bin`

Compiler options (unit paths, output file) are in `extra.cfg`.

### Update FastPlaz

Inside the container:

```
$/projects/vendors/fastplaz/update.sh
```


## Project Structure

```
build.sh                 build docker image
container-run.sh         run container (port 8080)
bash.sh                  run container and enter bash shell
files/
  Dockerfile-ubuntu      docker image definition
  app/                   scripts copied to /app in the image
  project-examples/echo  echo example project
```


## Hack On

That’s about it. Thanks for listening. I’ll be quiet from now on (unless there’s an update about the app—I’ll remind you for that!).

Cheers ..!
