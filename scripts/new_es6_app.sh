#!/bin/bash

# Exit on error
set -e

# --- Colors ---
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

APP_NAME=$1
SCRIPTS="$HOME/.dotfiles/scripts"

# --- Check: missing argument ---
if [[ -z "$APP_NAME" ]]; then
  echo -e "${RED}✖ Error: Please provide a project name.${NC}"
  echo "Usage: newes6 your-project-name"
  exit 1
fi

# --- Check: valid folder name ---
if [[ ! "$APP_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo -e "${RED}✖ Error: Project name '$APP_NAME' contains invalid characters.${NC}"
  echo "Only letters, numbers, dashes, and underscores are allowed."
  exit 1
fi

# --- Check: already exists ---
if [[ -d "$APP_NAME" ]]; then
  echo -e "${RED}✖ Error: Directory '$APP_NAME' already exists.${NC}"
  exit 1
fi

# --- Create folder structure ---
mkdir -p "$APP_NAME"/{assets/{css,js/{controllers,managers,utils,vendor},scss,icons,swatches},config}
touch "$APP_NAME"/assets/css/.gitkeep
touch "$APP_NAME"/assets/js/controllers/.gitkeep
touch "$APP_NAME"/assets/js/managers/.gitkeep
touch "$APP_NAME"/assets/js/utils/.gitkeep
touch "$APP_NAME"/assets/js/vendor/.gitkeep
touch "$APP_NAME"/assets/icons/.gitkeep
touch "$APP_NAME"/assets/swatches/.gitkeep

# --- Create SCSS files ---
cat <<EOF > "$APP_NAME/assets/scss/app.scss"
@use 'core';
@use 'style';
EOF

cat <<EOF > "$APP_NAME/assets/scss/core.scss"
@use 'functions';
@use 'mixins';
@use 'reset';
@use 'animations';
@use 'variables';
@use 'themes';
@use 'components';
@use 'utilities';
EOF

cat <<EOF > "$APP_NAME/assets/scss/style.scss"
:root {
    // root variables
}

body {
    background-color: var(--bg-body);
    color: var(--text-body);
    display: flex;
    flex-direction: column;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen,
        Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    line-height: 1.4;
    margin: 0;
    min-height: 100vh;
    padding-top: 0;
}
EOF

for PARTIAL in functions mixins reset animations variables themes components utilities; do
  echo "// $PARTIAL partial" > "$APP_NAME/assets/scss/_$PARTIAL.scss"
done

# --- JS entry point ---
echo "// Entry point" > "$APP_NAME/assets/js/app.js"

# --- index.html ---
cat <<EOF > "$APP_NAME/index.html"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>$APP_NAME</title>
  <link rel="stylesheet" href="assets/css/app.css" />
</head>
<body>
  <script type="module" src="assets/js/app.js"></script>
</body>
</html>
EOF

# --- .gitignore ---
cat <<EOF > "$APP_NAME/.gitignore"
Makefile
node_modules/
assets/css/*.css
assets/css/*.css.map
*.log
.DS_Store
.sass-cache/
EOF

# --- .Makefile.template (for version control) ---
cat <<EOF > "$APP_NAME/.Makefile.template"
# Replace this path with your local path to watch_scss.sh
SCRIPTS := /path/to/your/scripts

SCSS_IN := assets/scss/app.scss
CSS_OUT := assets/css/app.css
MIN_OUT := assets/css/app.min.css
JS_DIR  := assets/js
HTML    := index.html

# ...rest of your Makefile here
EOF

# --- package.json & dev tools ---
cd "$APP_NAME"
npm init -y > /dev/null
npm install --save-dev eslint chokidar-cli browser-sync > /dev/null

# --- ESLint config ---
cat <<EOF > .eslintrc.json
{
  "env": {
    "browser": true,
    "es2021": true
  },
  "extends": "eslint:recommended",
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "rules": {
    "no-unused-vars": "warn",
    "no-console": "off",
    "semi": ["error", "always"],
    "quotes": ["error", "single"]
  }
}
EOF

echo "node_modules/" > .eslintignore
echo "assets/js/vendor/" >> .eslintignore

# --- Makefile (local only) ---
cat <<EOF > Makefile
# ============================
# Config
# ============================

SCRIPTS  := $SCRIPTS
SCSS_IN  := assets/scss/app.scss
CSS_OUT  := assets/css/app.css
MIN_OUT  := assets/css/app.min.css
JS_DIR   := assets/js
HTML     := index.html

# ============================
# Build Commands
# ============================

build:
	@echo "🔨 Building SCSS..."
	@\$(SCRIPTS)/watch_scss.sh \$(SCSS_IN) \$(CSS_OUT) \$(MIN_OUT)

# ============================
# Watchers
# ============================

watch:
	@echo "👀 Watching SCSS and JS..."
	@bash -c "make watch-css & make watch-js & wait"

watch-css:
	@echo "🎨 Watching SCSS: \$(SCSS_IN)"
	@\$(SCRIPTS)/watch_scss.sh \$(SCSS_IN) \$(CSS_OUT) \$(MIN_OUT) --watch

watch-js:
	@echo "🧠 Watching JS: \$(JS_DIR)"
	@npx chokidar "\$(JS_DIR)/**/*.js" -c "npx eslint \$(JS_DIR)"

# ============================
# Linting
# ============================

lint:
	@echo "🔍 Linting JS..."
	@npx eslint \$(JS_DIR)

fix:
	@echo "🧼 Fixing JS style issues..."
	@npx eslint \$(JS_DIR) --fix

# ============================
# Live Reload
# ============================

serve:
	@echo "🚀 Starting browser-sync server..."
	@npx browser-sync start --server --files "\$(HTML)" "\$(CSS_OUT)" "\$(JS_DIR)/**/*.js"

# ============================
# Dev Environment
# ============================

dev:
	@echo "⚡ Launching full dev environment..."
	@bash -c "make watch & make serve & wait"

# ============================
# Cleanup
# ============================

clean:
	@echo "🧹 Cleaning SCSS build output..."
	@find assets/scss -type f \( -name "*.css" -o -name "*.map" \) -exec rm -f {} +
	@rm -f \$(CSS_OUT) \$(MIN_OUT) \$(CSS_OUT).map
EOF

# --- Git Init ---
if [[ -f .gitignore ]]; then
  git init -q
  echo -e "${GREEN}✔ Git repo initialized.${NC}"
fi

echo -e "${GREEN}✔ Project '$APP_NAME' created successfully!${NC}"
echo -e "→ You're now in the project folder. Run ${YELLOW}make dev${NC} to start building and reloading."
