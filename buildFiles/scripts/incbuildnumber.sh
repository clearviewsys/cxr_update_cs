#!/bin/bash

# increases build number and pushes back modified parameters.json file

workingDirectory=$(pwd)

build=$(jq -r '.build' $workingDirectory/buildFiles/parameters.json)

build=$((build+1))

jq --argjson mybuildno "$build" '.build = $mybuildno' $workingDirectory/buildFiles/parameters.json > $HOME/Documents/tmp.json

mv $HOME/Documents/tmp.json $workingDirectory/buildFiles/parameters.json

# do not push if run locally, it will start Github action

if [[ $RUNNER == *"GIT"* ]]; then
	git config --global user.name 'Github action'
	git config --global user.email 'milan@clearviewsys.com'
	git commit -am "Uploaded parameters.json with new build number ${build}"
	git push
	echo "New JSON parameters file pushed back ${build}"
fi
