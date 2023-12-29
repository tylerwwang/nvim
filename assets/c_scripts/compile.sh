#file use to build code.
TARGET=$1
BUILD_FOLDER=""
BIN_FOLDER=""

if [[ -a ".build/project.conf" ]]
then
	input=".build/project.conf"
	while IFS= read -r line
	do
		BUILD_FOLDER=".build/$line"
		BIN_FOLDER="bin/$line"
	done < "$input"

	export RUNTIME_DIR="../../$BIN_FOLDER"

	cd $BUILD_FOLDER

	make $TARGET

	cd ../../
else
	echo "Projected not configured. Please configure the project before compilation."
fi

