#!/usr/bin/env bash
# SPDX-License-Identifier: BSD-3-Clause

set -o nounset
set -o errexit
set -o pipefail
set -o noclobber

VERSION="1.0"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

DATE=$(date +"%Y-%m-%d")
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
TITLE=""
SLUG=""

_get_title() {
    read -rp "Post title: " TITLE
}

_set_slug() {
    SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' -)
}

_write_file() {
    {
        echo "---" 
        echo "title: $TITLE"
        echo "date: $DATE"
        echo "categories:"
        echo "-"
        echo "keywords:"
        echo "description: \"\""
        echo "last_updated:"
        echo "---"
        echo
        echo "* TOC"
        echo "{:toc}"
        echo
        echo "##"
    } >> "$1";
}

help() {
    echo "Helper script for working new posts"
    echo
    echo "Syntax: posts.sh [d|n|c|h|v]"
    echo "options:"
    echo "d     Create a new draft"
    echo "n     Create a new post"
    echo "c     Convert a draft to a post"
    echo "h     Print this help"
    echo "v     Print version information"
}

version() {
    printf "${GREEN}posts.sh${NC} v$VERSION\n"
}

create_post() {
    _get_title
    _set_slug

    mkdir -p _posts/"$YEAR"/"$MONTH"

    post=_posts/"$YEAR"/"$MONTH"/"$DATE"-"$SLUG".md
    _write_file "$post"
    vim "$post"
}

create_draft() {
    _get_title
    _set_slug

    draft=_drafts/"$DATE"-"$SLUG".md
    _write_file "$draft"
    vim "$draft"
}

if [ $# -eq 0 ]; then
    >&2 printf "${RED}ERROR${NC} At least one argument is required\n"
    exit 1
fi

while getopts "dnchv" option; do
    case $option in
        d)
            create_draft
            exit 0
            ;;
        n)
            create_post
            exit 0
            ;;
        c)
            echo "Not Implemented"
            exit 1
            ;;
        h)
            help
            exit 0
            ;;
        v)
            version
            help
            exit 0
            ;;
        \?)
            echo
            help
            exit 1
            ;;
    esac
done

