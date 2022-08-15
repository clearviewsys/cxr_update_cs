//%attributes = {}
// AU_SaveEssentials ( {$targetPath} ; {$sourcePath} )
// Make a copy of the current database located in $sourcePath to $targetPath

C_TEXT:C284($1; $2; $sourcePath; $targetPath; $oldVersionFolder)

$oldVersionFolder:="ReplacedFiles_"+String:C10(Current date:C33(*))+"_"+String:C10(Current time:C178(*))+Folder separator:K24:12
$oldVersionFolder:=Replace string:C233($oldVersionFolder; "-"; "_")
$oldVersionFolder:=Replace string:C233($oldVersionFolder; "/"; "_")
$oldVersionFolder:=Replace string:C233($oldVersionFolder; ":"; "")

Case of 
		
	: (Count parameters:C259=0)
		
		$targetPath:=Temporary folder:C486+$oldVersionFolder
		$sourcePath:=Get 4D folder:C485(Database folder:K5:14)
		
	: (Count parameters:C259=1)
		
		$targetPath:=$1
		$sourcePath:=Get 4D folder:C485(Database folder:K5:14)
		
	: (Count parameters:C259=2)
		
		$targetPath:=$1
		$sourcePath:=$2
		
	Else 
		ASSERT:C1129(False:C215; "Invalid number of parameters")  // TODO: Generic Function
End case 

$targetPath:=$targetPath+Folder separator:K24:12
$targetPath:=Replace string:C233($targetPath; Folder separator:K24:12+Folder separator:K24:12; Folder separator:K24:12)

$sourcePath:=$sourcePath+Folder separator:K24:12
$sourcePath:=Replace string:C233($sourcePath; Folder separator:K24:12+Folder separator:K24:12; Folder separator:K24:12)

If (Test path name:C476($targetPath)#Is a folder:K24:2)
	CREATE FOLDER:C475($targetPath)
End if 

If (Test path name:C476($sourcePath)=Is a folder:K24:2)
	copyDocuments($sourcePath; $targetPath)
	//copyDocuments ($targetPath;$sourcePath+$oldVersionFolder)
Else 
	// ALERT("Source path is invalid: "+$sourcePath)
	// TODO: Save this issue to a log file
	
End if 

