OVERWRITE=0

# Check for -o flag
while getopts ":o" opt; do
    case $opt in
        o)
            OVERWRITE=1
            ;;
        *)
            ;;
    esac
done

# Shift processed options
shift $((OPTIND - 1))

TEMPLATE_FILE="$HOME/.config/nvim/assets/tex_templates/$1.tex"

if [ -z "$2" ]; then
    echo "Error: Please provide file name."
    exit 1
fi

NEW_NAME="$2"

if [ -z "$3" ]; then
    NEW_PATH=""
else
    NEW_PATH="$3/"
	mkdir -p "$NEW_PATH" >/dev/null
fi

NEW_FILE="$NEW_PATH$NEW_NAME.tex"

if [ -e "$NEW_FILE" ] && [ $OVERWRITE -eq 0 ]; then
    echo "Error: $NEW_FILE already exists. Use -o to overwrite."
    exit 1
fi

cp $TEMPLATE_FILE $NEW_FILE || { echo "Error: template not found."; exit 1; }

MACRO_STRING="%__MACROS-HERE__%"
MACRO_LINE_NUM=$(grep -n "$MACRO_STRING" "$NEW_FILE" | cut -d: -f1)
MACRO_FILE="$HOME/.config/nvim/assets/tex_templates/macros.tex"

echo $MACRO_LINE_NUM

if [ -n "$MACRO_LINE_NUM" ]; then
    sed -i '' "${MACRO_LINE_NUM} {
        r $MACRO_FILE
        d
    }" "$NEW_FILE"
fi
