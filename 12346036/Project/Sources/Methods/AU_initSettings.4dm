//%attributes = {"executedOnServer":true}

// AU_initSettings
// Create the Automatic Updates config file

C_TEXT:C284($rootRef)
C_TEXT:C284($xmlTag; $xmlPath; $itemRef)

$xmlPath:=Get 4D folder:C485(Database folder:K5:14)+"AU_settings.xml"

If (Test path name:C476($xmlPath)#Is a document:K24:1)
	
	$rootRef:=DOM Create XML Ref:C861("AU_settings")
	$itemRef:=DOM Create XML element:C865($rootRef; "AU_settings/automatic_updates_allowed")
	DOM SET XML ELEMENT VALUE:C868($itemRef; "0")
	
	DOM EXPORT TO FILE:C862($rootRef; $xmlPath)
	DOM CLOSE XML:C722($rootRef)
	
End if 
