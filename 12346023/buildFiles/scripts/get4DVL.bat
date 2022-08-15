rem download 4D Volume Desktop, leave it in Documents folder, we will refer to it in buildApp.4DSettings XML file

echo "BAT: Downloading 4D Volume Desktop Windows ..."
curl -s -o  %HOMEDRIVE%%HOMEPATH%\Documents\4D_VL_win.zip %1
echo "BAT: 4D Volume Desktop Windows downloaded, unzipping archive ..."
unzip -q  %HOMEDRIVE%%HOMEPATH%\Documents\4D_VL_win -d  %HOMEDRIVE%%HOMEPATH%\Documents\
echo "BAT: 4D Volume Desktop unzipped"
