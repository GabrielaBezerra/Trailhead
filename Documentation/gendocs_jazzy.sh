cd ../Source
jazzy --clean \
  --exclude=Carthage/*,build/* \
  --min-acl private \
  --output ../Documentation/Jazzy \
  --theme fullwidth \
  --documentation=../Documentation/*.md
