---
title: OCaml (very) Briefly
date: 2024-11-19
tags: ["ocaml"]
categories:
-
description: "A very brief overview of OCaml"
last_updated: 2025-04-16
quote: "Isaiah 58:11 - The LORD will guide you always; he will satisfy your
needs in a sun-scorched land and will strengthen your frame. You will be like a
well-watered garden, like a spring whose waters never fail."
---

In a previous post we installed OCaml. I was pedantic about it, so it wasn't
as easy as just using `apt` or `dnf`. Now that we have it installed and working,
let's take a look at OCaml, and try to get comfortable with the basics.
<!--more-->

## Operators

First, let's look at basic, elementary OCaml. Let's start with the usual. The
operators.

```ocaml
# 1 + 1;;
- : int = 2

# 1 - 1;;
- : int = 0

# 4 / 2;;
- : int = 2

# 4 * 2;;
- : int = 8
```

So far so good! We can add, substract, divide, and multiply integers. Let's
throw in some floats.

```ocaml
# 3.14 + 5;;
Error: This expression has type float/2 but an expression was expected of type
         int
       File "_none_", line 1:
         Definition of type float/2
```

Uh oh. We broke it. I do not really understand that error message. I do not know
why the type is `float` divided by `2`. It also tells me "Definition of type
float/2" but doesn't actually show me the definition.

Anyway, we can fix this using two more _mandatory_ periods.

```ocaml
# 3.14 +. 5.;;
- : float = 8.14
```

Note the period after the `+` sign and after the `5`. Let's try some variables.
The reason for these variables is due to OCaml being functional. Instead of
overloading the plus sign to work for integers and floats, they instead have a
seperate `+.` to work with floats.

## Variables and Functions

```ocaml
# let x = 1 + 2;;
val x : int = 3
```

Nice! We created a variable `x` and set it's value to `3`. There are of
course rules about what variables names can be. For example, they cannot start
with a capital letter or a number. Every language has little rules like this, so
I am going to skip that for now. Rules like that have never been a problem for
me, so I am not worried about it at this point.

Let's make some functions.

```ocaml
# let square x = x * x;;
val square : int -> int = <fun>

# square 3;;
- : int = 9

# let add x y = x + y;;
val add : int -> int -> int = <fun>

# add 3 4;;
- : int = 7
```

Some things of note. You do not have to have paraenthesis around your function
arguments. Now that we have made some variables and functions, the return
statement from the compiler has changed. It now reads `val ___` instead of just
a `-`. It also prints the types of the input and the output of the function. In
our case it's always `int`.

In the next post we'll take a further look at how things work in OCaml.
