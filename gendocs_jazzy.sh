cd Source
jazzy --clean \
  --author "Matt Whitlock" \
  --exclude=Carthage/*,build/* \
  --min-acl private \
  --output ../Documentation \
  --theme fullwidth \
  --documentation=../docs/*.md \
  --readme ../README.md
