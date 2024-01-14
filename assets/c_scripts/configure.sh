#file to cnfigure project

ARGS=$1

PROJ_DIR="$PWD"

mkdir -p .build 2> /dev/null
touch ".build/project.conf" > /dev/null

if [ "$ARGS" = "debug" ]
then
	if [[ -f ".build/project.conf" ]]
	then
		rm ".build/project.conf"
	fi

	echo "debug" >> ".build/project.conf"

	export RUNTIME_DIR="";

	mkdir .build/debug 2> /dev/null
	cd .build/debug/
	cmake ../.. \
		-DCMAKE_BUILD_TYPE=Debug \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
		-DCMAKE_LIBRARY_OUTPUT_DIRECTORY="$PROJ_DIR"/out/debug \
		-DCMAKE_RUNTIME_OUTPUT_DIRECTORY="$PROJ_DIR"/out/debug

	mv -f compile_commands.json ../../ 2> /dev/null

elif [ "$ARGS" = "release" ]
then
	if [[ -f ".build/project.conf" ]]
	then
		rm ".build/project.conf"
	fi

	echo "release" >> ".build/project.conf"
	export RUNTIME_DIR="";

	mkdir .build/release 2> /dev/null
	cd .build/release/
	cmake ../.. \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
		-DCMAKE_LIBRARY_OUTPUT_DIRECTORY="$PROJ_DIR"/out/release \
		-DCMAKE_RUNTIME_OUTPUT_DIRECTORY="$PROJ_DIR"/out/release

	mv -f compile_commands.json ../../ 2> /dev/null
else
	echo "Missing argument: build type missing from arguement list."
fi

