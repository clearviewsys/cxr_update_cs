//%attributes = {"executedOnServer":true}
// saveFileOnServer ($tableName; $fileName; ->$fileContent)
// EXECUTE ON SERVER

C_TEXT:C284($1; $tableName; $2; $fileName)
C_POINTER:C301($3; $fileContent)
C_TEXT:C284($resourcesFolder)

Case of 
	: (Count parameters:C259=3)
		$tableName:=$1
		$fileName:=$2
		$fileContent:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$resourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12

If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 


$resourcesFolder:=$resourcesFolder+$tableName+Folder separator:K24:12

If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 

BLOB TO DOCUMENT:C526($resourcesFolder+$fileName; $fileContent->)


