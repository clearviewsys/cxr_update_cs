//%attributes = {}

// Commit changes to www.bitbukcet repository (user: clearviewsys password: same as Designer

C_TEXT:C284($inputStream; $outputStream; $errorStream; $commandPath; $projectFolder; $commitmsg)

$inputStream:=""
$commandPath:=""

$projectFolder:=Get 4D folder:C485(Database folder:K5:14)+"methods"+Folder separator:K24:12
$commandPath:=$projectFolder+"commit.bat"
LAUNCH EXTERNAL PROCESS:C811($commandPath; $inputStream; $outputStream; $errorStream)


