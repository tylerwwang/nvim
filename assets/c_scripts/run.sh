#file use to run code.
FILE=$1
BUILD_FOLDER=""
BIN_FOLDER=""

if [[ -a ".build/project.conf" ]]
then
	input=".build/project.conf"
	while IFS= read -r line
	do
		BIN_FOLDER="out/$line"
	done < "$input"

	if [[ -a "$BIN_FOLDER/$FILE" ]]
	then
		cd "$BIN_FOLDER"
		./"$FILE"
	else
		echo "Project not built. Please build project before running."
	fi
else
	echo "Projected not configured. Please configure the project before running."
fi

