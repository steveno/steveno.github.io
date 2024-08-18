---
title: "Docker Basics in 30 seconds"
date: 2024-08-18
categories:
- 
keywords: docker
description: "Docker Basics in 30 seconds"
lastupdated:
---

* TOC
{:toc}

## Introduction
When I first started learning Docker, it was really baffling for me. I thought I understood
Linux and it's terminology pretty well, but Docker really threw me for a loop. In hindsight
it feels pretty silly, but at the time it was serious and I was lost. So this is a quick primer
for anyone else who is learning Docker and confused by all the new words.

## Basic Terminology
So it's best to think of the basic parts of Docker as if they were real physical things, like a
picture or a sketch that you drew.
* **Image** - In sketch analogy, this is the sketch you drew. You can photocopy this sketch as
many times as you need. More technically, an `image` is just a pre-built system. Nine times out
of ten it's a complete OS, generally with something special installed. For example, the MariaDB
images are just Ubuntu with MariaDB already installed.
* **Container** - So a container is a copy of your image that you can actually play with. You
take your new sketch and you photocopy it over and over. Every copy you make you
modify somehow. Maybe you color on it. Cut pieces off of it. Maybe on one your use markers, and
on another you use watercolors. Regardless, you can make as many copies as you want, and every
copy starts off exactly the same. So in Docker, `container`s work exactly like this. You download
the image from DockerHub, you install some packages, add some users, maybe modify some config
files, and boom you now have a working virtual machine to use. A `container`.
* **Dockerfile** - This is the "code" you write to build an image which eventually becomes a
container. A `Dockerfile` is where you tell Docker what OS you want to start with (generally, you
will start with a pre-existing OS container you pull from Dockerhub). You can also add files to it,
run scripts, modify configuration, install packages, expose ports, etc. When someone asks if you
have experience with Docker, the ins and outs of `Dockerfile`s is most likely what they're going to
quiz you on.

## Docker Commands

### Working with images
* **Pull** - This pulls down and existing image from DockerHub or another repository of your choice.
* **Build** - This build an image that you use to create containers from.

### Working with containers
* **Create** - Creates a new container from an existing image. It does _not_ start it though.
* **Start** - This starts your container. With physical computers you would call this `boot` maybe
or something similar, but `start` actually makes more sense in this context in my opinion.
* **Run** - This one really confused me, because all the tutorials for Docker use this command
and leave out the previous two definitions. This both `create`s your container and `start`s it in
one command.

