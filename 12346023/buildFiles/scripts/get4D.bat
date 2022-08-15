rem download 4D Volume Desktop, leave it in Documents folder, we will refer to it in buildApp.4DSettings XML file

echo "BAT: Downloading 4D Windows ..."
curl -s -o  %HOMEDRIVE%%HOMEPATH%\Documents\4D.zip %1
echo "BAT: 4D Windows downloaded, unzipping archive ..."
unzip -q  %HOMEDRIVE%%HOMEPATH%\Documents\4D.zip -d  %HOMEDRIVE%%HOMEPATH%\Documents\
echo "BAT: 4D unzipped"
