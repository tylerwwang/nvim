#Script used to clean project

FILE=$1
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

		cd $BUILD_FOLDER


	make clean-all
	cd ..
	rm project.conf
	cd ..
	rm -r $BUILD_FOLDER

else
	echo "Projected not configured. Please configure the project before cleaning."
fi
