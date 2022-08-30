C_TEXT:C284($path)
C_TIME:C306($hRef)
$hRef:=Open document:C264("")

If (OK=1)
	//$path:=Convert path system to POSIX(document)
	$path:=document
	CLOSE DOCUMENT:C267($hRef)
	
	WA OPEN URL:C1020(webArea; $path)
	[WebAttachments:86]FilePath:3:=Convert path system to POSIX:C1106($path)
	//set $path to the web area
	//set $path file namet to field
	
End if 