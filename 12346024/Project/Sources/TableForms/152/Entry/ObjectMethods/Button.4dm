C_TEXT:C284($accessPath)
$accessPath:=Select folder:C670("Select the destination folder")
If (OK=1)
	[FTP_Sites:152]localFilePath:10:=$accessPath
End if 
