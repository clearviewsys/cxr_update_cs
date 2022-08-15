#!/bin/bash

# make release for compiled structure to public Github repo

workingDirectory=$(pwd)

destinationFolder=$1
build=$2
version=$3

mkdir $HOME/Documents/another_repo/
# git clone https://madamov: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@github.com/clearviewsys/cxr_update_cs.git $HOME/Documents/another_repo
git clone https://madamov:$WHO_TO_TRUST@github.com/clearviewsys/cxr_update_cs.git $HOME/Documents/another_repo

rm -R $HOME/Documents/another_repo/*

mkdir $HOME/Documents/another_repo/${build}/


echo "🐚 🐚 : Making release of compiled structure ..."
cd $destinationFolder
cd Compiled\ Database

echo "🐚 🐚 : Copying files ..."

cp -R * $HOME/Documents/another_repo/${build}/

ls -al $HOME/Documents/another_repo/${build}/ > $HOME/Documents/artifacts/build_listing.txt

echo "🐚 🐚 : End copying to release repository ..."

