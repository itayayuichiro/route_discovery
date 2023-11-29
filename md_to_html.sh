#!/bin/bash
for i in $(seq 1 100); do
  if [ -e "./md/article${i}.md" ]; then
    pandoc -f markdown -t html --template=mytemplate "./md/article${i}.md" > "./docs/article${i}.html"
  fi
done
pandoc -f markdown -t html --template=mytemplate "./md/index.md" > "./docs/index.html"
