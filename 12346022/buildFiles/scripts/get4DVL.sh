#!/bin/bash

# download 4D Volume Desktop, leave it in Documents folder, we will refer to it in buildApp.4DSettings XML file

workingDirectory=$(pwd)

echo "🐚:🐚: Downloading 4D Volume Desktop ..."
curl -s -o $HOME/Documents/4D_VL.zip $1
echo "🐚:🐚: 4D Volume Desktop downloaded, unzipping archive ..."
unzip -q $HOME/Documents/4D_VL -d $HOME/Documents/
echo "🐚:🐚: 4D Volume Desktop unzipped"
