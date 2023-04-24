REM Batch file to release standalone Windows app

rem cd %1%
rem cd "Final Application"

rem switch to HOMEDRIVE, sometimes repo is cloned on drive D:
%HOMEDRIVE%

cd %destFolder%
dir
cd "Final Application"

dir /s *.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\dirlisting_releaseapp.txt

echo "Releasing Windows standalone app"
echo "Repo for standalone app is %repoURL%"

IF DEFINED uploadURL (@call %scripts%\release_app_upload.bat)

IF DEFINED repoURL (@call %scripts%\release_app_gh.bat %1% %2% %3%)
