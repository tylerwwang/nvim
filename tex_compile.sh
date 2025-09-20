#!/bin/bash

# Usage: tex_compile.sh [-o] filename directory

OPEN=false

# Check for -o flag
if [[ "$1" == "-o" ]]; then
    OPEN=true
    shift
fi

FILENAME="$1"
DIR="$2"
PDF="${FILENAME%.tex}.pdf"

echo Compiling $PDF ...

if [[ -z "$FILENAME" || -z "$DIR" ]]; then
    echo "Usage: $0 [-o] filename directory"
    exit 1
fi

# Change to the file directory
cd "$DIR" || { echo "Failed to change directory to $DIR"; exit 1; }

# Compile with latexmk
latexmk -pdf "$FILENAME"
EXIT_CODE=$?
latexmk -c

# Clean auxiliary files if compilation succeeded
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "Compilation failed!"
    exit $EXIT_CODE
fi

# Open PDF if requested
if [[ "$OPEN" == true ]]; then
    if [[ -f "$PDF" ]]; then
        # macOS: use open, Linux: use xdg-open
        if command -v open >/dev/null 2>&1; then
            open "$PDF"
        elif command -v xdg-open >/dev/null 2>&1; then
            xdg-open "$PDF"
        else
            echo "PDF compiled, but no known command to open it."
        fi
    else
        echo "PDF not found: $PDF"
    fi
fi

if [[ -f "$PDF" ]]; then
    # macOS: use open, Linux: use xdg-open
    if command -v open >/dev/null 2>&1; then
        open -R "$PDF"
    fi
else
    echo "PDF not found: $PDF"
fi

