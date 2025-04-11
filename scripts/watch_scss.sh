#!/bin/bash

# Universal SCSS Watch Script
# Usage:
#   ./watch-scss.sh [input SCSS] [output CSS] [output minified CSS]
# Example:
#   ./watch-scss.sh assets/scss/main.scss assets/css/main.css assets/css/main.min.css

INPUT_SCSS=$1
OUTPUT_CSS=$2
OUTPUT_MIN=$3

# Directory containing the input file
INPUT_DIR=$(dirname "$INPUT_SCSS")

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check for required arguments
if [[ -z "$INPUT_SCSS" || -z "$OUTPUT_CSS" || -z "$OUTPUT_MIN" ]]; then
    echo -e "${YELLOW}Usage: $0 input.scss output.css output.min.css${NC}"
    exit 1
fi

# Check if Dart Sass is installed
if ! command -v sass &> /dev/null; then
    echo -e "${YELLOW}Dart Sass not found. Installing...${NC}"
    npm install -g sass
fi

# Clean up any rogue .css/.map files in the input directory
clean_input_folder() {
    echo -e "${YELLOW}Cleaning rogue CSS/map files in $INPUT_DIR...${NC}"
    find "$INPUT_DIR" -type f \( -name "*.css" -o -name "*.map" \) -exec rm -f {} +
}

# Compilation step
compile() {
    clean_input_folder

    echo -e "${YELLOW}Compiling SCSS:${NC}"
    echo -e "  Source: $INPUT_SCSS"
    echo -e "  Output: $OUTPUT_CSS"
    echo -e "  Minified: $OUTPUT_MIN"

    sass "$INPUT_SCSS":"$OUTPUT_CSS" \
         --style=expanded \
         --source-map \
         --source-map-urls=relative

    sass "$INPUT_SCSS":"$OUTPUT_MIN" \
         --style=compressed \
         --no-source-map

    echo -e "${GREEN}Compiled successfully!${NC}"
}

# Initial compile
compile

# Only enter watch loop if --watch flag is present
if [[ "$4" == "--watch" ]]; then
    echo -e "${YELLOW}Watching $INPUT_DIR for changes...${NC}"

    if command -v fswatch &> /dev/null; then
        fswatch -o "$INPUT_DIR" | while read _; do
            compile
        done
    elif command -v inotifywait &> /dev/null; then
        while true; do
            inotifywait -r -e modify,create,delete "$INPUT_DIR"
            compile
        done
    else
        echo -e "${YELLOW}fswatch/inotifywait not found. Using polling fallback...${NC}"
        LAST_HASH=""
        while true; do
            NEW_HASH=$(md5sum "$INPUT_SCSS")
            if [[ "$NEW_HASH" != "$LAST_HASH" ]]; then
                echo -e "${YELLOW}Change detected. Recompiling...${NC}"
                compile
                LAST_HASH="$NEW_HASH"
            fi
            sleep 2
        done
    fi
fi
