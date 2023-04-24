mkdir %HOMEDRIVE%%HOMEPATH%\Documents\artifacts


rem set env vars to comply with local_mainyml.bat so all the scripts have the same values

set jq=jq
set curl=curl
set sevenzip=7z

rem set env vars used in all batch files
@call %GITHUB_WORKSPACE%\buildFiles\scripts\setenvvars.bat

rem set current directory to one where repository is
rem cd my4DApp


rem we build only from main branch, uncomment for production
git switch main


echo =================== DONE INITIALIZING STUFF ==============================

@call %scripts%\build_all.bat

echo =================== DONE BUILDING ========================================

if not exist %STATUSFILE% (@call %scripts%\postBuild.bat)

echo =================== DONE POST BUILD TASKS ================================
echo
echo

rem list env vars to output for debugging
set

powershell -command "Get-EventLog -LogName System -EntryType Error" > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\eventlog.txt
