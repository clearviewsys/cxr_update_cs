//%attributes = {}
// PE_LoadPictureInArea

C_POINTER:C301($1; $picturePtr)
C_TEXT:C284($2; $webAreaName)

C_TEXT:C284(PictureFilePath; $url; $jpgFile)
C_TEXT:C284($resourcesFolder)

Case of 
		
	: (Count parameters:C259=2)
		$picturePtr:=$1
		$webAreaName:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$resourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16; *)

// Save picture and create the file for the doka utility
If (Picture size:C356($picturePtr->)>0)
	PE_savePictureForWebArea($picturePtr)
	PE_ShowPictureInArea($webAreaName)
End if 


