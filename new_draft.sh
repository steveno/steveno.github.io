#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause

# Get title from user input
read -rp "Post title: " TITLE
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' -)

# Create the file with YAML frontmatter
cat > _drafts/"$SLUG".md <<EOL
---
title: "$TITLE"
date:
categories:
- 
keywords: 
description: ""
last_updated:
---

* TOC
{:toc}

## 

EOL

vim _drafts/"$SLUG".md
