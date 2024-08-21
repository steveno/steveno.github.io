---
title: "Docker Basics in 30 seconds"
date: 2024-08-18
categories:
- 
keywords: docker podman containers
description: "Docker Basics in 30 seconds"
last_updated: 2024-08-19
---

* TOC
{:toc}

## Introduction

When I first started learning Docker, it was really baffling for me. I thought
I understood Linux and it's terminology pretty well, but Docker really threw me
for a loop. In hindsight it feels pretty silly, but at the time it was serious
    and I was lost. So this is a quick primer for anyone else who is learning
    Docker and confused by all the new words.

## Basic Terminology

So it's best to think of the basic parts of Docker as if they were real
physical things, like a picture or a sketch that you drew.
* **Image** - Using the sketch analogy, this is the sketch you drew. You can
  photocopy this sketch as many times as you need. More technically, an `image`
  is just a pre-built system. Nine times out of ten, it's a complete OS,
  generally with something special installed. For example, the MariaDB images
  are just Ubuntu with MariaDB already installed.
* **Container** - A container is a copy of your image that you can actually
  play with. You take your sketch and you photocopy it over and over. Every
  copy you make you modify somehow. Maybe you color it with pens. Cut pieces
  off of it. Maybe on one you use acrylics, and on another you use watercolors.
  Regardless, you can make as many copies as you want, and every copy starts
  off exactly the same. So in Docker, `container`s work exactly like this. You
  download the image from DockerHub, you install some packages, add some users,
  maybe modify some config files, and boom you now have a working virtual
  machine to use.
* **Dockerfile** - This is the "code" you write to build an image which
  eventually becomes a container. A `Dockerfile` is where you tell Docker what
  OS you want to start with (generally, you will start with a pre-existing OS
  container you pull from Dockerhub). You can also add files to it, run
  scripts, modify configuration, install packages, expose ports, etc. When
  someone asks if you have experience with Docker, the ins and outs of
  `Dockerfile`s is most likely what they're going to quiz you on.

## Docker Commands

### Working with images

* **[Pull](https://docs.podman.io/en/latest/markdown/podman-pull.1.html)** -
  This pulls down and an existing image from DockerHub or from another
  repository of your choice.
* **[Build](https://docs.podman.io/en/latest/markdown/podman-build.1.html)** -
  This builds the image, using a `Dockerfile`, that you can use to create
  containers from.

### Working with containers

* **[Create](https://docs.podman.io/en/latest/markdown/podman-create.1.html)**
  - Creates a new container from an existing image. It does _not_ start it
    though. If you check the status of your containers, your newly created
    container show the status of "created."
* **[Start](https://docs.podman.io/en/latest/markdown/podman-start.1.html)** -
  This starts your container. With physical computers you would call this
  `boot` or something similar, but `start` actually makes more sense in this
  context (in my opinion).
* **[Run](https://docs.podman.io/en/latest/markdown/podman-run.1.html)** - This
  one really confused me, because all the tutorials for Docker use this command
  and leave out the previous two. This both `create`s your container and
  `start`s it in one command.

