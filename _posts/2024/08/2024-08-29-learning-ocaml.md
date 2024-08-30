---
title: Learning OCaml
date: 2024-08-29
categories:
-
keywords: ocaml howto
description: "Getting started with OCaml"
last_updated:
---

* TOC
{:toc}

I have spent my entire career basically using two major languages; or at 
least language families. The first is the
[.NET](https://dotnet.microsoft.com/en-us/) languages. I started with
[VB.NET](https://learn.microsoft.com/en-us/dotnet/visual-basic/?WT.mc_id=dotnet-35129-website),
moved to
[C#](https://learn.microsoft.com/en-us/dotnet/csharp/?WT.mc_id=dotnet-35129-website),
and then ended up going back to VB.NET. I have spent more time than I would
like to admit to dabbling in VBA, but honestly, I don't really count that.
<!--more-->
Then I started a new job and picked up [python](https://www.python.org/). I
have been using python professionally ever since. Is that all I know? Of
course not. I have written a lot of [bash](https://www.gnu.org/software/bash/)
and [PowerShell](https://learn.microsoft.com/en-us/powershell/?view=powershell-7.4).
Again, I don't really count those. No one, that I know of, gets paid to write
bash for a living. I have spent free time learning [Go](https://go.dev/) and I
learned C++ in college. Those languages are great, but they feel like they're
in the same "family." I put that in quotes because a lot of people will want to
quibble about me lumping .NET, python, Go, and C++ in a family. In _a lot_ of
ways they're not, but they all "feel" about the same. They're mostly procedural,
object oriented, and most of that group also uses or borrows heavily from C's
syntax.

I want to teach myself something different. What are some "different" languages
in my opinion? Scheme and Lisp immediately come to mind for me. While I have
immense respect for both of them, and would like to, at some point, learn to
write at least one of those two effectively, today isn't that day. Instead I'm
looking to go fully functional. So that brings me to **OCaml**.

## Installation

I'm picky about how I install software. I spent two days worth of free time
fighting with [Gerbil Scheme](https://cons.io/) to make it install cleanly
(for my definition of clean). I eventually gave up and decided to skip learning
Gerbil altogether.

Generally speaking, I followed the
[instructions](https://dev.realworldocaml.org/install.html) laid out by the
book [Real World OCaml](https://dev.realworldocaml.org/) when setting up `opam`
and `ocaml`. I did deviate a little to make sure everything was "tidy" when I
finished which I will cover in detail here.

First, I went [here](https://opam.ocaml.org/doc/Install.html#Binary-distribution)
and downloaded the bash script to install the binary distribution. If you just
run it as they describe you can't pass any options to the script.

```bash
curl -fsSLO https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh
chmox +x install.sh
./install.sh --no-backup --fresh
```

The script will ask where you want to install everything to, so don't worry
about not specifying that when you invoke it. I try to keep as much as possible
in `~/.local` so I chose `~/.local/bin`. Assuming you have `~/.local/bin` in
your path, you should be able to run `opam` now and get the help menu.

```bash
opam
```

Now we get to the part where my OCD kicks in. I don't want my home directory
polluted with an `opam` directory. The next instruction listed in the book
will create `~/opam` for you and install everything there. _But_ you can
set an environment variable in your `~/.bashrc` and opam will install
everything there instead, so let's do that.

```bash
export OPAMROOT="/home/steveno/.local/share/opam"
```

Now, going back to following the directions from the book, we initialize opam.

```bash
opam --init
```

Now, if you run that and you get this message about bwrap being not permitted,
and it asking you if you want to disable sandboxing, _and_ you're running
Ubuntu, this fix worked for me.

```
bwrap: loopback: Failed RTM_NEWADDR: Operation not permitted
```

```bash
sudo touch /etc/apparmor.d/bwrap

{
    echo "abi <abi/4.0>,"
    echo "include <tunables/global>"
    echo "" 
    echo "profile bwrap /usr/bin/bwrap flags=(unconfined) {"
    echo " userns,"
    echo "" 
    echo " # Site-specific additions and overrides. See local/README for details."
    echo " include if exists <local/bwrap>"
    echo "}"
} >> /etc/apparmor.d/bwrap

sudo systemctl reload apparmor.
```

Finally, `opam init` is going to ask you if you want it to setup your bash
configuration for you or not. I picked yes the first time I did this, and now
that I have it integrated into my bash configuration the way I want it, I pick
no.

I went ahead and installed the recommended packages it talks about. I don't
really know what I am doing yet, so it seems like a safe bet for a learner.

```bash
opam install core core_bench utop
```

To finish off this post I, again, created the `.ocamlinit` file as directed.
```bash
{
    echo '#require "core.top";;'
    echo '#require "ppx_jane";;'
    echo 'open Base;;'
} >> ~/.ocamlinit
```

## Conclusion

That should give you a nice working install of `opam` and `ocaml`. And, except
for that init file at the end, your home directory should still be nice and
tidy as well!
