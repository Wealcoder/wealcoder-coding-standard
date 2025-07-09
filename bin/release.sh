#!/bin/sh
set -e

# Ensure working directory is clean
if [ -n "$(git status --porcelain)" ]; then
  echo "❌ Working tree is not clean. Please commit or stash changes before releasing."
  exit 1
fi

echo "➤ Fetching the latest tags..."
git fetch --tags
echo "✓ Latest tags fetched!"

LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "No tags found")
echo "➤ Last release tag: $LAST_TAG"

read -p "Enter the version number to release (e.g. 1.2.3): " VERSION

# Validate version format
if ! echo "$VERSION" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$'; then
  echo "❌ Invalid version format. Use semantic versioning (e.g., 1.2.3)."
  exit 1
fi

echo "➤ Preparing release for v$VERSION..."
read -p "Are you sure you want to release version $VERSION? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Release cancelled."
    exit 1
fi

echo "➤ Updating version number in PHP files..."
# Detect OS for sed compatibility
if [[ "$OSTYPE" == "darwin"* ]]; then
  find . -type f -name '*.php' -exec sed -i '' -E "s/(@version)[[:space:]]+[0-9.]+/\1 $VERSION/" {} \;
else
  find . -type f -name '*.php' -exec sed -i -E "s/(@version)[[:space:]]+[0-9.]+/\1 $VERSION/" {} \;
fi
echo "✓ Version number updated!"

echo "➤ Committing and tagging..."
git add .
git commit -m "Release v$VERSION"
git tag -a "v$VERSION" -m "Release v$VERSION"
git push origin "$(git symbolic-ref --short HEAD)" --tags
echo "✓ Git tag v$VERSION pushed!"

# Optional: Create GitHub release if `gh` is installed
if command -v gh > /dev/null; then
  echo "➤ Creating GitHub release..."
  gh release create "v$VERSION" --title "v$VERSION" --notes "Automated release v$VERSION"
  echo "✓ GitHub release created!"
else
  echo "ℹ️ GitHub CLI not found. GitHub release not created. You can install it from https://cli.github.com/"
fi
