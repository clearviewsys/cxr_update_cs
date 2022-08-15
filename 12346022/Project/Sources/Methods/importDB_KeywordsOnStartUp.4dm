//%attributes = {"executedOnServer":true}
// ----------------------------------------------------------------------------------------
// importKeywordsOnStartUp
// Execute only on SERVER SIDE
// ----------------------------------------------------------------------------------------


C_BLOB:C604($importParams)
C_TEXT:C284($resourceFolder; $fileName; $exportParamsFileName; $xmlFile; $resourcesFolder; $importParamsFileName)
C_BOOLEAN:C305($importTables)

$resourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12
If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 

$resourcesFolder:=$resourcesFolder+"Keywords"+Folder separator:K24:12
If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 


$importTables:=False:C215

allRecordsDB_Keywords
//DELETE SELECTION([Keywords]) // For testing

If (Records in selection:C76([DB_Keywords:105])=0)
	
	$fileName:=$resourcesFolder+"Keywords.4ie"
	$importParamsFileName:=$resourcesFolder+"KeywordsParams.xml"
	
	// Import Keywords table
	If ((Test path name:C476($fileName)=Is a document:K24:1) & (Test path name:C476($importParamsFileName)=Is a document:K24:1))
		
		DOCUMENT TO BLOB:C525($importParamsFileName; $importParams)
		$xmlFile:=BLOB to text:C555($importParams; Mac text without length:K22:10)
		$xmlFile:=Replace string:C233($xmlFile; "Keywords.4ie"; $fileName)
		TEXT TO BLOB:C554($xmlFile; $importParams; UTF8 text without length:K22:17)
		IMPORT DATA:C665($fileName; $importParams)
	End if 
	
	allRecordsDB_Translations
	DELETE SELECTION:C66([DB_Translations:110])  // For testing
	
	$fileName:=$resourcesFolder+"Translations.4ie"
	$importParamsFileName:=$resourcesFolder+"TranslationsParams.xml"
	
	If (Records in selection:C76([DB_Translations:110])=0)
		
		// Import Translations Table
		If ((Test path name:C476($fileName)=Is a document:K24:1) & (Test path name:C476($importParamsFileName)=Is a document:K24:1))
			
			DOCUMENT TO BLOB:C525($importParamsFileName; $importParams)
			$xmlFile:=BLOB to text:C555($importParams; Mac text without length:K22:10)
			$xmlFile:=Replace string:C233($xmlFile; "Translations.4ie"; $fileName)
			TEXT TO BLOB:C554($xmlFile; $importParams; UTF8 text without length:K22:17)
			IMPORT DATA:C665($fileName; $importParams)
		End if 
		
	Else 
		myAlert("Keywords table couldn't be imported. Keywords or Translations data doesn't exist in "+$resourcesFolder+" folder.")
	End if 
	
	
End if 
