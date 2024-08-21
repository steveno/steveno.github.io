---
title: "How I Build my Resume"
date: 2024-08-17
categories:
- 
keywords: resume latex
description: "How I build my resume using LaTeX"
last_updated: 2024-08-19
---

* TOC
{:toc}

## Introduction

I am really proud of my resume. I have been using the same template for over a
decade now, but compared to 90% of the resumes I see in the wild mine still
ranks among some of best looking in my opinion. How do I do it? Let's take a
look!

## Tools

Before we take a look under the hood let's look at the tools I use. First, I
write my resume in [LaTeX](https://www.latex-project.org/). When I first
started down this path I had to learn LaTeX just for my resume. The reality is,
it's not hard to learn at all. My biggest issue with LaTeX, because I only use
it for my resume, is I have trouble remembering various formatting commands and
such. Every time I have to edit my resume, I end up having to Google how to
*\<fill in the blank\>*.

While I have been using vim for even longer than I have been using LaTeX to
write my resume, I don't use vim to compose the LaTeX. Instead I use
[TeXstudio](https://www.texstudio.org/). I install it via
[flatpak](https://www.flatpak.org/) on my Ubuntu machine, which currently
installs version 4.7.3. While, with a lot of work, I might be able to build a
configuration in vim that gives me 90% of what I use TeXstudio for, the reality
is that editing LaTeX for my resume is not similar at all to writing typical
programming code (e.g. python or go). So I don't really miss the vim
keybindings.

Finally, I always distribute my resume as PDF. A decade ago this was a pain for
me because recruiters especially would always ask me for a MS Word version of
my resume, but nowadays that's not an issue. I have not been asked for a copy
of my resume in Word in several years now.

## Basic Setup

My resume actually consists of three LaTeX files. The resume file itself
(`resume.tex`), along with `header.tex`, and `footer.tex`. I have it split
among three files because I treat it like a template. The header and footer of
the document are also shared with the cover letter and my references. This way
when I want to do something like update the color scheme or my phone number, I
can change it in one place and all of my documents are updated. No more sending
out a resume and a cover letter with different addresses on them.

## resume.tex

Let's start by taking a look at `resume.tex`. The first two lines of code
really explain everything. First, I create a new command (think of this like a
variable) that holds the name of this document. In this case I'm creating my
resume. Next we have an `\input` command. The `\input` command reads in the
text from the listed file and processes it as if it were written in the file
the `\input` command is in.

```latex
\newcommand{\doctype}{Resume}
\input{../header.tex}
```

This is a really powerful way to break up your documents. So, for example,
let's take a quick look at `header.tex`. In there I have the following line:

```latex
\begin{document}
```

This, without the matching `\end{document}` document registers as an error in
your editor, but when you go to build your file, LaTeX puts them all together
and builds the file for you without error or warning.

Finally, I end `resume.tex` by including `footer.tex`.

```latex
\input{../footer.tex}
```

## header.tex

Now, let's take a closer look at `header.tex`. This is where I keep most of the
basic boiler plate for all of my documents related to my resume. I want a
consistent look and feel through out, and 90% of that is achieved here.

First, we have the document class which just tells LaTeX what kind of document
it's building.
```latex
\documentclass[letterpaper,11pt]{article}
```

Then I setup the margins.
```latex
\setlength{\voffset}{0.1in}
\setlength{\paperwidth}{8.5in}
\setlength{\paperheight}{11in}
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}
\setlength{\topmargin}{-0.5in}
\setlength{\textheight}{9.5in}
\setlength{\textwidth}{7.5in}
\setlength{\oddsidemargin}{-0.5in}
\setlength{\evensidemargin}{-0.5in}
```

Next, I setup some packages I use to create a custom colored box that I use for
section headings. I also set my font here and the character encoding.

```latex
\usepackage{color} % custom colors
\usepackage[pdftex]{graphicx} % images in the footer
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage{charter} % my chosen font
```

After that, I setup page numbers.

```latex
\usepackage{lastpage}
\usepackage{fancyhdr}
\pagestyle{fancy}
% Without this line you get the page number by
% default in the middle of the footer
\fancyhf{}
% Gets rid of an annoying line across the top
% of the page
\renewcommand{\headrulewidth}{0pt}
% pageref* suppresses the hyperlink
\rfoot{Page \thepage \hspace{1pt} of \pageref*{LastPage}}
```

From there it's really just about starting off the document. I want all my
documents to have the same "header" of information, my name, address, phone
number, etc. so I set that all here. And that is where the document abruptly
ends. If you were to run the header though LaTeX alone it would error out.

## footer.tex

Finally, let's look at `footer.tex`. The footer is incredibly simple compared
to the header. I use the `includegraphics` commands to include links to my
GitHub and Linkedin profile as pictures of their logos and and a closing
`end{document}`. Once, again, like the previous two documents, alone
`footer.tex` only produces errors.

## Conclusion

If that was too much to follow, or you just want to crib off an example, I
have, luckily for you, created a [template
repository](https://github.com/steveno/resume_template) where you can find
everything I covered here.
