#!/usr/bin/env bash

# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

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

