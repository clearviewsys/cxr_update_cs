set workingDirectory=%GITHUB_WORKSPACE%
set scripts=%GITHUB_WORKSPACE%\buildFiles\scripts\

set action=$(jq -r '.action' %workingDirectory%\buildFiles\parameters.json)

rem if not x%str1:BUILD_APP=%==x%str1% echo It contains bcd

if not x%action:BUILD_APP=%==x%action% (
	set url4dvl=$(jq -r '.winVL_URL' %workingDirectory%\buildFiles\parameters.json)
	%scripts%get4DVL.bat %url4dvl%
)
