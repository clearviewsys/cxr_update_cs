//%attributes = {}
// exportKeywordsOnBackup
// Exports all the Keywords and Translations after executing a backup
// Must BE EXECUTED ON SERVER

C_BLOB:C604($exportParams)
C_BLOB:C604($blob)
C_TEXT:C284($resourceFolder; $fileName; $exportParamsFileName; $resourcesFolder; $exportParamsFileName)

$resourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12
If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 

$resourcesFolder:=$resourcesFolder+"Keywords"+Folder separator:K24:12
If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 


// Export Keywords 
$fileName:=$resourcesFolder+"Keywords.4ie"
$exportParamsFileName:=$resourcesFolder+"KeywordsParams.xml"
allRecordsDB_Keywords

If (Records in selection:C76([DB_Keywords:105])>0)
	
	If (Test path name:C476($exportParamsFileName)#Is a document:K24:1)
		
		EXPORT DATA:C666($fileName; $exportParams; *)  // Try to create te export project
		BLOB TO DOCUMENT:C526($exportParamsFileName; $exportParams)  // Save the export Project
		saveFileOnServer("Keywords"; "KeywordsParams.xml"; ->$exportParams)
		
		DOCUMENT TO BLOB:C525($fileName; $blob)
		saveFileOnServer("Keywords"; "Keywords.4ie"; ->$blob)
		
	Else 
		DOCUMENT TO BLOB:C525($exportParamsFileName; $exportParams)
		saveFileOnServer("Keywords"; "Keywords.4ie"; ->$blob)
		
		EXPORT DATA:C666($fileName; $exportParams)
		saveFileOnServer("Keywords"; "KeywordsParams.xml"; ->$exportParams)
		
	End if 
	
	
	// Export Translations 
	
	$fileName:=$resourcesFolder+"Translations.4ie"
	$exportParamsFileName:=$resourcesFolder+"TranslationsParams.xml"
	allRecordsDB_Translations
	
	If (Records in selection:C76([DB_Translations:110])>0)
		
		If (Test path name:C476($exportParamsFileName)#Is a document:K24:1)
			EXPORT DATA:C666($fileName; $exportParams; *)  // Try to create te export project
			
			BLOB TO DOCUMENT:C526($exportParamsFileName; $exportParams)  // Save the export Project
			saveFileOnServer("Keywords"; "TranslationsParams.xml"; ->$exportParams)
			
			DOCUMENT TO BLOB:C525($fileName; $blob)
			saveFileOnServer("Keywords"; "Translations.4ie"; ->$blob)
			
		Else 
			DOCUMENT TO BLOB:C525($exportParamsFileName; $exportParams)
			saveFileOnServer("Keywords"; "Translations.4ie"; ->$blob)
			
			EXPORT DATA:C666($fileName; $exportParams)
			saveFileOnServer("Keywords"; "TranslationsParams.xml"; ->$exportParams)
		End if 
	End if 
	
End if 
