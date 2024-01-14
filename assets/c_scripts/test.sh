#Script used to clean project

FILE=$1
BUILD_FOLDER=""
BIN_FOLDER=""
ARGS=$1

if [[ -a ".build/project.conf" ]]
then
	input=".build/project.conf"
	while IFS= read -r line
	do
		BUILD_FOLDER=".build/$line"
		BIN_FOLDER="bin/$line"
	done < "$input"

		cd $BUILD_FOLDER

	echo "\033[1;34mBuilding Project...\033[0m"
	make
	echo ""
	echo ""
	echo "\033[1;34mTesting Project...\033[0m"

	if [ "$ARGS" = "r" ]
	then
		ctest --output-on-failure --rerun-failed
	else
		ctest --output-on-failure
	fi
else
	echo "Projected not configured. Please configure the project before testing."
fi
