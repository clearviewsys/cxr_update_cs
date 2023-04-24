rem commits, pushes and createse github release of windows standalone

if [%repoURL%] == [null] GOTO isNULL

mkdir %HOMEPATH%\Documents\app_repo

rem WHO_TO_TRUST is secret in environment variable set in main.yml jobs section as first thing before everything
rem RUNNER_ACTOR is also set in main.yml

git clone https://%RUNNER_ACTOR%:%WHO_TO_TRUST%@%repoURL% %HOMEPATH%\Documents\app_repo

del /s /q %HOMEPATH%\Documents\app_repo\*.*


echo "CMD : Making release of windows standalone app ..."
echo "CMD: Copying files ..."

xcopy /Y /S /E *.* %HOMEPATH%\Documents\app_repo\*.*

echo CMD : End copying to standalone release repository ..."

cd %HOMEPATH%\Documents\app_repo
echo %WHO_TO_TRUST% | gh auth login --with-token
git add .
git commit -m "Releasing version %3% build %2% of Windows standalone app"
git push -q
gh release create "%releasetag%" --notes "Release %3% build %2%"
cd %workingDirectory%

:isNULL

GOTO :EOF
