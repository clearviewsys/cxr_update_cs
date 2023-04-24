//%attributes = {}
C_TEXT:C284($0)
C_TEXT:C284($1; $xmlObj; $destFolder; $destFolderPath)


If (Count parameters:C259>0)
	$xmlObj:=$1
Else 
	$xmlObj:=backup_getConfigXML
End if 

If ($xmlObj#"")
	
	$destFolder:=DOM Find XML element:C864($xmlObj; "/Preferences4D/Backup/DataBase/LastBackupLogPath/Item1")
	
	If ($destFolder#"")
		If ($destFolder#"00000000000000000000000000000000")  // 32 x "0"
			DOM GET XML ELEMENT VALUE:C731($destFolder; $destFolderPath)
		End if 
	End if 
	
	If (Count parameters:C259=0)
		backup_CloseConfig($xmlObj)
	End if 
	
	$0:=$destFolderPath
	
End if 
