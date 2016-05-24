#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker run --rm -it -p 4000:4000 -v "$DIR":/site madduci/docker-github-pages:1.0 serve --watch --force_polling  --host 0.0.0.0 --drafts
