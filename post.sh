#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause

# Get current date, year, and month
DATE=$(date +"%Y-%m-%d")
YEAR=$(date +"%Y")
MONTH=$(date +"%m")

# Get title from user input
read -rp "Post title: " TITLE
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' -)

# Create year and month directories if they don't exist
mkdir -p _posts/"$YEAR"/"$MONTH"

# Create the file with YAML frontmatter
cat > _posts/"$YEAR"/"$MONTH"/"$DATE"-"$SLUG".md <<EOL
---
title: "$TITLE"
date: $DATE
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
