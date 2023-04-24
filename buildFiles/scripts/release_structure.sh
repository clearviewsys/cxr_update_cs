#!/bin/bash

# make release for compiled structure to public Github repo

workingDirectory=$(pwd)

echo "Releasing compiled structure"
echo "curr dir in release_structure is $workingDirectory"

destinationFolder=$1
build=$2
version=$3

echo "Destination folder path in release_structure.sh: $destinationFolder"


repoURL=$(jq -r '.repoCompiledStruct' $workingDirectory/buildFiles/parameters.json)
uploadURL=$(jq -r '.uploadCompiledStruct' $workingDirectory/buildFiles/parameters.json)
appName=$(jq -r '.appName' $workingDirectory/buildFiles/parameters.json)
version=$(jq -r '.version' $workingDirectory/buildFiles/parameters.json)
buildnumber=$(jq -r '.build' $workingDirectory/buildFiles/parameters.json)
releasetag=v"$version"_build_"$buildnumber" 

echo "Repo for compiled structure is $repoURL, release tag is $releasetag"

# $WHO_TO_TRUST is secret in environment variable set in main.yml jobs section as first thing before everything
# $RUNNER_ACTOR is also set in main.yml


# cd $destinationFolder
# cd Compiled\ Database
# cd $appName

# make Settings folder for directory.json file
# mkdir Settings
# cp $workingDirectory/buildFiles/directory.json Settings/directory.json


if [ -z "$repoURL" ]; then
	echo "no repository defined"
else
	mkdir $HOME/Documents/compstruct_repo/
	git clone https://$RUNNER_ACTOR:$WHO_TO_TRUST@$repoURL $HOME/Documents/compstruct_repo
	echo "🐚🐚 : Deleting old files from repo..."
	rm -R $HOME/Documents/compstruct_repo/*
	echo "🐚🐚 : Copying files ..."
	cp -R * $HOME/Documents/compstruct_repo/
	ls -alR $HOME/Documents/compstruct_repo/ > $HOME/Documents/artifacts/build_listing.txt
	echo "🐚🐚 : End copying to compiled structure release repository ..."
	cd $HOME/Documents/compstruct_repo/
	echo $WHO_TO_TRUST | gh auth login --with-token
	git add .
	git commit -m "Releasing version $version build $buildnumber of compiled structure"
	git push
	gh release create "$releasetag" --notes "Release $version build $buildnumber"
	cd $workingDirectory
fi

if [ -z "$uploadURL" ]; then
	echo "no upload of compiled structure"
else

#	$HOME/Documents/createdmg/create-dmg --volname "${appName}_Structure" $HOME/Documents/${appName}_struct.dmg $destinationFolder/Compiled\ Database/*

	myStructDest="$destinationFolder/Compiled\ Database/"

	# create dmg using hdiutil directly without mounting the image, it takes long time and the image can't be detached
	hdiutil create -volname "${appName}_Structure" -srcfolder ${myStructDest} $HOME/Documents/${appName}_structtmp.dmg
	
	# compress image
	hdiutil convert $HOME/Documents/${appName}_structtmp.dmg -format UDBZ -o $HOME/Documents/${appName}_struct.dmg

	# create zip archive now for Windows
	cd $destinationFolder/Compiled\ Database/
	zip -rqy $HOME/Documents/${appName}_struct.zip *
	cd $workingDirectory
	
	myStructURL=$uploadURL$version/$build
	echo "Uploading to folder: $myStructURL"
	
#	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} -T $HOME/Documents/${appName}_struct.dmg ${uploadURL}
#	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} -T $HOME/Documents/${appName}_struct.zip ${uploadURL}
	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_struct.dmg ${myStructURL}/${appName}_struct.dmg
	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_struct.zip ${myStructURL}/${appName}_struct.zip

fi
