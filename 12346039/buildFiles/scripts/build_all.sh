#!/bin/bash

echo "🐚 : Start of script: $(date)"

workingDirectory=$(pwd)

# disable Gatekeeper and application translocating, may save us some processing cycles
sudo spctl --master-disable
echo "🐚 : macOS Gatekeeper disabled"


action=$(jq -r '.actionMac' $workingDirectory/buildFiles/parameters.json)

if [[ $action == *"BUILD_APP"* ]]; then
	if [[ $1 == "NOVL" ]]; then
		echo "🐚 : Not downloading 4D Volume desktop"
	else
		url4dvl=$(jq -r '.macVL_URL' $workingDirectory/buildFiles/parameters.json)
		/bin/bash $workingDirectory/buildFiles/scripts/get4DVL.sh $url4dvl
	fi 
fi

if [[ $action == *"BUILD_SERVER"* ]]; then
	url4dvl=$(jq -r '.macServer_URL' $workingDirectory/buildFiles/parameters.json)
	/bin/bash $workingDirectory/buildFiles/scripts/get4DServer.sh $url4dvl
	if [[ $action == *"INCLUDE_WIN_CLIENT"* ]]; then
		url4dvl=$(jq -r '.winVL_URL' $workingDirectory/buildFiles/parameters.json)
		/bin/bash $workingDirectory/buildFiles/scripts/get4Win4DVL.sh $url4dvl
	fi
fi

url=$(jq -r '.maclicenses_URL' $workingDirectory/buildFiles/parameters.json)

# download developer licenses archive, extract it and move them in correct location for 4D to use them
/bin/bash $workingDirectory/buildFiles/scripts/licenses.sh $url

if [[ $2 == "NO4D" ]]; then
	echo "🐚 : Not downloading 4D"
else
	# get and extract 4D standalone
	url4d=$(jq -r '.mac4D_URL' $workingDirectory/buildFiles/parameters.json)
	/bin/bash $workingDirectory/buildFiles/scripts/get4D.sh $url4d
fi

compilerOptions="--dataless --headless"
# compiler="/Applications/4D.app/Contents/MacOS/4D"
compiler="$HOME/Documents/4D.app/Contents/MacOS/4D"
projectFile=$workingDirectory/Project/CXR7.4DProject


# run 4D and let 4D do the work
echo "🐚: Starting 4D at $(date)"

# some examples:
#"$compiler" $compilerOptions --project "$projectFile" --user-param "{\"action\":\"COMPILE_ONLY\"}"
#"$compiler" --headless --dataless --project "Project/CXR7.4DProject" --user-param "{\"action\":\"COMPILE_ONLY\"}"
#"$compiler" --headless --dataless --project "Project/CXR7.4DProject" --user-param "{\"action\":\"COMPILED_STRUCTURE\"}"

userParams=$(jq -r '.' $workingDirectory/buildFiles/parameters.json)
"$compiler" --headless --dataless --project "$projectFile" --user-param "$userParams"

echo "🐚: 4D done at $(date)"

echo "🐚: Build script done at $(date)"
