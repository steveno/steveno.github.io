---
title: Setting up Mutt
date: 2024-09-19
tags: [mutt, email]
categories:
-
description: "How I setup Mutt as a first time user"
last_updated: 2025-04-16
quote: "Hebrews 10:25 - not forsaking the assembling of ourselves together, as
is the manner of some, but exhorting one another, and so much the more as you
see the Day approaching."
---

* TOC
{:toc}

I have been using Gmail since college. I don't know exactly, but it was sometime
in the early 2000s. [Mutt](http://www.mutt.org/) has been around this whole time
and yet I have never used it. I just always assumed I would not like it because
it could not display pictures. I mean, how many emails do you get, especially
that are not tech related, that do not include images? 
<!--more-->
I will admit I did install it one time, I can't remember if I was able to
actually get it working or not, but either way, I removed it the same day and
didn't look back. Until this week.

## Motivation

I was actually motivated to try Mutt after reading a [blog
post](https://blog.sergeantbiggs.net/posts/aerc-a-well-crafted-tui-for-email/)
about [aerc](https://aerc-mail.org/). The guy actually sold Aerc pretty well.
Enough that I set out to download it and install it myself. Why then did I
immediately give up and try mutt instead? Two words: [GPG](https://gnupg.org/)
integration. GPG integration with Aerc is presently, at best, a bit hacky.

## Install

I use Ubuntu on my personal machines, so I went the easy route this time and
just installed Mutt using `apt`.

```shell
sudo apt install mutt
```

I'm sure there are other ways to do it, that may even get me a newer version,
but Mutt is a pretty old, and stable, piece of software. Whatever version Ubuntu
gives me is almost certainly good enough.

## Configuration

### GMail

Setting up Gmail was really easy. Five minutes or less of Google and you can
figure it out.

```text
set from = "oliver.steven@gmail.com"
set realname = "Steven Oliver"
set imap_user = "oliver.steven@gmail.com"
set smtp_url = "smtps://oliver.steven@smtp.gmail.com"

# Remote folders
set folder = "imaps://imap.gmail.com/"
set spoolfile = "+INBOX"
set postponed = "+[Gmail]/Drafts"
set record = "+[Gmail]/Sent Mail"
set trash = "+[Gmail]/Trash"
```

So what about your password? That was the tricky part for me. Setting up an
application password for Mutt to use with Gmail is easy. Google helpfully gives
you an easy to follow How To
[article](https://knowledge.workspace.google.com/kb/how-to-create-app-passwords-000009237).

The tricky part is how to store said password on your hard drive, or worse, in
your dotfiles repository without sharing your email with the entire world? This,
again, is where GPG comes into play... except I did not want to use GPG for
this, I wanted to use [age](https://github.com/FiloSottile/age). Why? Because
[chezmoi](https://www.chezmoi.io/) uses age, and I wanted to minimize the amount
of different tools I have to keep track of in my head. In my personal opinion,
age is also significantly easier to use. Which leaves you with, why did I care
about GPG in the first place? Because age specifically states it was not
designed to be used with email.

The first thing I did was setup age to be used with chezmoi. That's pretty [well
documented](https://www.chezmoi.io/user-guide/encryption/age/), and a bit off
topic for this post, so I won't go into it here. First, create your passwords
file to include in your `muttrc`. I simply named mine `password`.

```text
# Imap settings
set imap_pass = "your app password"

# Smtp settings
set smtp_pass = "your app password"
```

Next, you'll encrypt that file with age to produce a `password.age` file.
```bash
age -o password.age -r <your public key created with age> password
```

The contents of `password.age` should look similar to this.
```text
age-encryption.org/v1
-> X25519 1/7OSVyRVCbCR1geEVmih4EZKsGmZnc9GkDk+NRLDio
LsQSBcuwCO+7UZtsrG5G/CVuTQOjrYkI6/K1XeNa93s
--- d57B50H1L5J+URqkt+x5AZLS1I7MoKhb/umk73TaMUQ
ÈÒ=ïÅ»hùÌ¶¢`£0¬SÁPóÁÀÑ|ÂHóÍ'»æ
```

Finally, you can add this line to your `muttrc` to have Mutt decrypt your
password file for you when Mutt opens.
```text
source "age -d -i /home/steveno/.config/chezmoi/key.txt ~/.config/mutt/passwords.age |"
```

### Macro to delete emails
A convenience feature I implemented was writing a macro to have Mutt delete
emails in a way that was similar to how GMail does so on its website. This was
surprisingly easy to do. StackOverflow was of little help honestly. The method I
ended up figuring out is simpler than anything they had.

```text
macro index,pager d "<delete-message><sync-mailbox><enter>"
```

### GPG
This was really easy. Just fix the line that has your key in it.

```text
# Encryption
set crypt_use_gpgme = yes
set pgp_autosign = yes
set pgp_sign_as = 0x05368C44AB2AF31E
set pgp_replyencrypt = yes
```

### Other

The last bits of my config I copied wholesale from a blog I have since lost
track of. The same bits can be found just about everywhere. Similar to vim when
Neovim was started, Mutt feels old and in desperate need of a refresh. Similar
to Neovim, doing things like making extremely popular options the default, would
probably go a long way.

```text
set ssl_force_tls = yes
set abort_nosubject = no
set mail_check = 60
set timeout = 10
set sort = "reverse-date-received"
set signature = "~/.config/mutt/signature"
set copy = no
set menu_scroll=yes

# Auto views
auto_view text/html
```

## Final Words

I really like Mutt so far. I am going to, at the very least, keep it installed
and keep using it. There are some things I haven't quite figured out that bother
me. The biggest being how to "archive" messages. Gmail is a bit strange as an
email client because folders and labels are synonymous. So moving a message from
the inbox to your "All mail" folder is not an obvious task. If you Google that
you'll probably be a bit horrified to see the answers similar to how I was.
Regardless, I really like Mutt and I think you're doing yourself a disservice if
you don't try it too.

