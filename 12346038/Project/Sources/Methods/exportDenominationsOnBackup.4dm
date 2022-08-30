//%attributes = {}

// exportDenominationsOnBackup
// Exports all the neccessary tables after executing a backup
// Must BE EXECUTED ON SERVER

C_BLOB:C604($exportParams)
C_BLOB:C604($blob)
C_TEXT:C284($resourceFolder; $imgFolder; $fileName; $exportParamsFileName; $resourcesFolder)

$imgFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12
If (Test path name:C476($imgFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($imgFolder)
End if 

$imgFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12+"Denominations"+Folder separator:K24:12
If (Test path name:C476($imgFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($imgFolder)
End if 


$imgFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12+"Denominations"+Folder separator:K24:12+"img"+Folder separator:K24:12
If (Test path name:C476($imgFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($imgFolder)
End if 


// Export Denominations images
ALL RECORDS:C47([Denominations:31])

While (Not:C34(End selection:C36([Denominations:31])))
	$fileName:=$imgFolder+[Denominations:31]DenominationID:1+".jpg"
	WRITE PICTURE FILE:C680($fileName; [Denominations:31]SpecimenScan:5)
	PICTURE TO BLOB:C692([Denominations:31]SpecimenScan:5; $blob; "image/jpeg")
	savePictureOnServer("Denominations"; "img"; [Denominations:31]DenominationID:1+".jpg"; ->$blob)
	NEXT RECORD:C51([Denominations:31])
End while 

// Export Denominations Table
$resourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12+"Denominations"+Folder separator:K24:12
$fileName:=$resourcesFolder+"Denominations.4ie"
$exportParamsFileName:=$resourcesFolder+"DenominationsParams.xml"

If (Test path name:C476($exportParamsFileName)#Is a document:K24:1)
	EXPORT DATA:C666($fileName; $exportParams; *)  // Try to create the export project
	BLOB TO DOCUMENT:C526($exportParamsFileName; $exportParams)  // Save the export Project
	saveFileOnServer("Denominations"; "DenominationsParams.xml"; ->$exportParams)
	
	DOCUMENT TO BLOB:C525($fileName; $blob)
	saveFileOnServer("Denominations"; "Denominations.4ie"; ->$blob)
Else 
	DOCUMENT TO BLOB:C525($exportParamsFileName; $exportParams)
	saveFileOnServer("Denominations"; "DenominationsParams.xml"; ->$exportParams)
	
	EXPORT DATA:C666($fileName; $exportParams)
	DOCUMENT TO BLOB:C525($fileName; $blob)
	saveFileOnServer("Denominations"; "Denominations.4ie"; ->$blob)
	
End if 

