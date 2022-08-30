//%attributes = {}
// sets path to built application or client server apps
// sets the destination folder for built application in in build XML settings file

#DECLARE($destPath : Text; $xml : Text)->$new_xml : Text


var $xml_ref; $elementPath; $destPath; $element_found : Text

$xml_ref:=DOM Parse XML variable:C720($xml)


If (OK=1)
	
	If (Is macOS:C1572)
		$elementPath:="/Preferences4D/BuildApp/BuildMacDestFolder/"
	Else 
		If (Is Windows:C1573)
			$elementPath:="/Preferences4D/BuildApp/BuildWinDestFolder/"
		End if 
	End if 
	
	$element_found:=DOM Find XML element:C864($xml_ref; $elementPath)
	
	If (OK=1)
	Else 
		$element_found:=DOM Create XML element:C865($xml_ref; $elementPath)
	End if 
	
	DOM SET XML ELEMENT VALUE:C868($element_found; $destPath)
	
	logLineInLogEvent("Destination path set: "+$destPath)
	
	DOM EXPORT TO VAR:C863($xml_ref; $new_xml)
	
	DOM CLOSE XML:C722($xml_ref)
	
End if 
