#!/bin/bash

# script uploads built files/makes releases

workingDirectory=$(pwd)

echo "🐚 🐚:: Starting postBuild script ..."

destination=$(jq -r '.buildDestinationFolder' $workingDirectory/buildFiles/parameters.json)
build=$(jq -r '.build' $workingDirectory/buildFiles/parameters.json)
uploadTo=$(jq -r '.uploadTo' $workingDirectory/buildFiles/parameters.json)
destFolder=$HOME/Documents/${destination}
version=$(jq -r '.version' $workingDirectory/buildFiles/parameters.json)
action=$(jq -r '.actionMac' $workingDirectory/buildFiles/parameters.json)

if [[ $action == *"BUILD_COMPILED_STRUCTURE"* ]]; then

# uploadapp.sh uploads build to FTP server
#	/bin/bash $workingDirectory/buildFiles/scripts/uploadapp.sh $destFolder $build $uploadTo

	# use public Github repository to make release there
	/bin/bash $workingDirectory/buildFiles/scripts/release_structure.sh $destFolder $build $version
fi
