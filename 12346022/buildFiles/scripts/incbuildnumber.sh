#!/bin/bash

# increases build number and pushes modified parameters.json

workingDirectory=$(pwd)

build=$(jq -r '.build' $workingDirectory/buildFiles/parameters.json)

build=$((build+1))

jq --argjson mybuildno "$build" '.build = $mybuildno' $workingDirectory/buildFiles/parameters.json > $HOME/Documents/tmp.json

mv $HOME/Documents/tmp.json $workingDirectory/buildFiles/parameters.json

git config --global user.name 'Github action'
git config --global user.email 'milan@clearviewsys.com'
git commit -am "Uploaded parameters.json with new build number ${build}"
git push

echo "New JSON parameteres pushed back ${build}"
