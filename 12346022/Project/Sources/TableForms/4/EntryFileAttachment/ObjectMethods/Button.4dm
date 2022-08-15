C_OBJECT:C1216($o)
C_TIME:C306($hRef)
C_TEXT:C284($posixPath)
C_OBJECT:C1216($o)
C_TEXT:C284($path)

$hRef:=Open document:C264("")

If (OK=1)
	
	Form:C1466.creationDate:=Current date:C33(*)
	Form:C1466.filePath:=document
	CLOSE DOCUMENT:C267($hRef)
	Form:C1466.filePropertiesObj:=Path to object:C1547(Form:C1466.filePath)
	WA OPEN URL:C1020(webArea; Form:C1466.filePath)
	Form:C1466.posixPath:=Convert path system to POSIX:C1106(Form:C1466.filePath)
	Form:C1466.fileName:=Form:C1466.filePropertiesObj.name
	Form:C1466.mimeType:=getMimeTypeByExtention(Form:C1466.filePropertiesObj.extension)
	Form:C1466.createdByUser:=getApplicationUser  //<>ApplicationUser
End if 