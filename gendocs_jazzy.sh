cd Source
jazzy --clean \
  --exclude=Carthage/*,build/* \
  --min-acl private \
  --output ../Documentation \
  --theme fullwidth \
  --documentation=../*.md
