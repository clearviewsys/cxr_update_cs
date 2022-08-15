#!/bin/bash

# script downloads licenses, expands them and copies them so 4D will run as Development Professional allowing us to compile and build

workingDirectory=$(pwd)

curl -s -o $HOME/Documents/dev_v19_mac.zip $1

echo "🐚:🐚:: Licenses downloaded"

if [ -d "$HOME/Documents/Licenses" ]; then
	echo "🐚:🐚:: Licenses in Documents exists"
else
	mkdir $HOME/Documents/Licenses
	echo "🐚:🐚:: Created Licenses folder in Documents folder"
fi

# extract licenses from archive
unzip $HOME/Documents/dev_v19_mac.zip -d $HOME/Documents/Licenses/

if [ -d "$HOME/Library/Application support/4D" ]; then
	echo "🐚:🐚:: 4D folder exists"
else 
	mkdir "$HOME/Library/Application support/4D"
fi

if [ -d "$HOME/Library/Application support/4D/Licenses" ]; then
	echo "🐚:🐚:: Licenses folder exists"
else 
	mkdir "$HOME/Library/Application Support/4D/Licenses"
fi

# copy licenses so 4D is licensed as Developer Professional
# leave originals in Documents folder, we will refer to them in buildApp.4DSettings XML file
cp $HOME/Documents/Licenses/* $HOME/Library/Application\ Support/4D/Licenses/
echo "🐚:🐚:: Licenses copied to " $HOME/Library/Application\ Support/4D/Licenses/