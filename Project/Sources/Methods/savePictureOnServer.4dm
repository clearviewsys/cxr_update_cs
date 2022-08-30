//%attributes = {"executedOnServer":true}
// saveFileOnServer ($tableName; $folderName; $fileName; ->$fileContent)
// EXECUTE ON SERVER


C_TEXT:C284($1; $tableName; $2; $folderName; $3; $fileName)
C_POINTER:C301($4; $fileContent)
C_PICTURE:C286($picture)
Case of 
	: (Count parameters:C259=4)
		$tableName:=$1
		$folderName:=$2
		$fileName:=$3
		$fileContent:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($resourcesFolder; $fileName)

$resourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12

If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 

$resourcesFolder:=$resourcesFolder+$tableName+Folder separator:K24:12

If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 


$resourcesFolder:=$resourcesFolder+$folderName+Folder separator:K24:12

If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 


BLOB TO PICTURE:C682($fileContent->; $picture)
WRITE PICTURE FILE:C680($resourcesFolder+$fileName; $picture)
