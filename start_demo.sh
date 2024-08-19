#!/usr/bin/env bash
# SPDX-License-Identifier: BSD-3-Clause

set -o nounset
set -o errexit
set -o pipefail

function iterate() {
    local dir="$1"
    for file in "$dir"/*; do
        if [ -d "$file" ]; then
            if [[ "$file" == *"_posts" ]];then
                rm -r "$file"
                continue
            fi
            iterate "$file"
        fi
    done
}

rm -rf _site
rm -rf .jekyll_cache
iterate "_posts"

bundle exec jekyll serve

