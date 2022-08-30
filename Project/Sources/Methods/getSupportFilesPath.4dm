//%attributes = {}
// this method returns the directory where the Support file are
// returns a path to where support files are; otherwise return null string and alert.
C_TEXT:C284($0; $testPath; $currentPath)

$testPath:=Get 4D folder:C485(Database folder:K5:14)+"CX_SupportFiles"+Folder separator:K24:12
If (Test path name:C476($testPath)#Is a folder:K24:2)
	CREATE FOLDER:C475($testPath)
	//myAlert ("Please place CX_SupportFiles folder in "+$testPath)
	//$currentPath:=Select folder("Please locate the CX_SupportFiles")
	//CREATE ALIAS($testPath;$currentPath)
End if 
$0:=$testPath
