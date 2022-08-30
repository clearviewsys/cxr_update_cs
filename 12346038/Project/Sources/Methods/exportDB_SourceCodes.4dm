//%attributes = {"executedOnServer":true}

//
// exportDB_SourceCodes: This method is EXECUTED ON SERVER
// 

C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n; $i)
C_TEXT:C284($filename_t; $root_t; $xmlStructure; $xmlFile)
ARRAY TEXT:C222($code_at; 0)
ARRAY TEXT:C222($fileNames_at; 0)
ARRAY TEXT:C222($code_at; 0)
C_TEXT:C284($commandPath; $inputStream; $outputStream; $errorStream)
$inputStream:=""

$progress:=launchProgressBar("Exporting methods...")

$root_t:=Get 4D folder:C485(Database folder:K5:14)+"methods"+Folder separator:K24:12

If (Test path name:C476($root_t)#Is a folder:K24:2)
	CREATE FOLDER:C475($root_t; *)
End if 

// Delete all existing files  (fix bug when commiting deleted methods)
$commandPath:=$root_t+"deletefiles.bat"
LAUNCH EXTERNAL PROCESS:C811($commandPath; $inputStream; $outputStream; $errorStream)

// Generate the DB structure to the version control folder
//$xmlFile:=$root_t+"structure.xml"
//EXPORT STRUCTURE($xmlStructure)
//TEXT TO DOCUMENT($xmlFile;$xmlStructure)


METHOD GET PATHS:C1163(Path all objects:K72:16; $fileNames_at)
METHOD GET CODE:C1190($fileNames_at; $code_at)
$n:=Size of array:C274($fileNames_at)

Repeat 
	refreshProgressBar($progress; $i; $n)
	$filename_t:=$fileNames_at{$i}
	$filename_t:=Replace string:C233($filename_t; "/"; "-")
	$filename_t:=Replace string:C233($filename_t; "%"; "=")
	$filename_t:=$filename_t+".txt"
	
	// Do not allow empty file names
	If ($filename_t#".txt")
		SET BLOB SIZE:C606($blob_x; 0)
		TEXT TO BLOB:C554($code_at{$i}; $blob_x; UTF8 text without length:K22:17)
		BLOB TO DOCUMENT:C526($root_t+$filename_t; $blob_x)
	End if 
	
	setProgressBarTitle($progress; "Exporting :"+$filename_t)
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress)))

HIDE PROCESS:C324($progress)
//SHOW ON DISK($root_t)

// Commit changes to external repository 
commitToGitRepository
