//%attributes = {}
C_TEXT:C284($path)
$path:=Request:C163("path of data file to open")
If (OK=1)
	OPEN DATA FILE:C312($path)
End if 