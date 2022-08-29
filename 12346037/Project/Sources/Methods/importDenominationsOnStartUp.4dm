//%attributes = {"executedOnServer":true}
// importDenominationsOnStartUp
// Imports all the Denominations Records if it is necessary
// Must BE EXECUTED ON SERVER


C_BLOB:C604($importParams)
C_TEXT:C284($resourceFolder; $fileName; $exportParamsFileName; $xmlFile; $resourcesFolder; $importParamsFileName; $imgFolder)
C_BOOLEAN:C305($importTables)


$importTables:=False:C215
$resourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12
If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 

$resourcesFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12+"Denominations"+Folder separator:K24:12
If (Test path name:C476($resourcesFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($resourcesFolder)
End if 


allRecordsDenominations

If (Records in selection:C76([Denominations:31])=0)
	
	$fileName:=$resourcesFolder+"Denominations.4ie"
	$importParamsFileName:=$resourcesFolder+"DenominationsParams.xml"
	
	// Import Denominations table
	If ((Test path name:C476($fileName)=Is a document:K24:1) & (Test path name:C476($importParamsFileName)=Is a document:K24:1))
		
		DOCUMENT TO BLOB:C525($importParamsFileName; $importParams)
		$xmlFile:=BLOB to text:C555($importParams; Mac text without length:K22:10)
		$xmlFile:=Replace string:C233($xmlFile; "Denominations.4ie"; $fileName)
		TEXT TO BLOB:C554($xmlFile; $importParams)
		IMPORT DATA:C665($fileName; $importParams)
		
		
		$imgFolder:=$resourcesFolder+"img"+Folder separator:K24:12
		If (Test path name:C476($imgFolder)#Is a folder:K24:2)
			CREATE FOLDER:C475($imgFolder)
		End if 
		
		// Save the denominations images.
		ALL RECORDS:C47([Denominations:31])
		
		
		While (Not:C34(End selection:C36([Denominations:31])))
			$fileName:=$imgFolder+[Denominations:31]DenominationID:1+".jpg"
			If (Test path name:C476($fileName)=Is a document:K24:1)
				READ PICTURE FILE:C678($fileName; [Denominations:31]SpecimenScan:5)
				If (OK=1)
					SAVE RECORD:C53([Denominations:31])
				Else 
					// Ignore this file.
				End if 
			End if 
			
			NEXT RECORD:C51([Denominations:31])
		End while 
		
	Else 
		myAlert("Denominations table couldn't be imported. File with data or images doesn't exist in "+$resourcesFolder+" folder.")
	End if 
	
End if 

