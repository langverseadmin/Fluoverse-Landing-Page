#!/bin/bash
set -e

flutter build web --release --pwa-strategy=none

# Add cache-busting query string
version=${COMMIT_REF:-$DEPLOY_ID}
find build/web -name '*.html' -exec sed -i "s/\.js\"/\.js?v=${version}\"/g" {} +
find build/web -name 'flutter.js' -exec sed -i "s/\.js\"/\.js?v=${version}\"/g" {} +