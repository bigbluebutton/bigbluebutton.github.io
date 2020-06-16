#!/bin/bash

# architecture-overview.md -> /home/firstuser/dev/ffdixon.github.io/_posts/2015-04-04-architecture-overview.md

set -x

for file in *.md; do
  ./clean.rb $file > /tmp/out/$file
done

