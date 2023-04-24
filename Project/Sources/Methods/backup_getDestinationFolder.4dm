//%attributes = {}
C_TEXT:C284($0)
C_TEXT:C284($1; $xmlObj; $destFolder; $destFolderPath)


If (Count parameters:C259>0)
	$xmlObj:=$1
Else 
	$xmlObj:=backup_getConfigXMLRef
End if 

If ($xmlObj#"")
	
	$destFolder:=DOM Find XML element:C864($xmlObj; "/Preferences4D/Backup/Settings/General/DestinationFolder")
	
	If ($destFolder#"")
		
		DOM GET XML ELEMENT VALUE:C731($destFolder; $destFolderPath)
		
	End if 
	
	If (Count parameters:C259=0)
		backup_CloseConfig($xmlObj)
	End if 
	
	$0:=$destFolderPath
	
End if 
