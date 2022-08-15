#!/bin/bash

workingDirectory=$(pwd)

echo "🐚:🐚: Downloading 4D ..."
# download 4D
curl -s -o $HOME/Documents/4D.zip $1
echo "🐚:🐚: 4D v19.2 downloaded, unzipping archive ..."
unzip -q $HOME/Documents/4D.zip -d $HOME/Documents/
echo "🐚🐚:: 4D unzipped"
