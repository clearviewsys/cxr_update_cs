//openPictureFile(->[LinkedDocs]ScannedImage)
C_OBJECT:C1216($o)
C_TEXT:C284($path)
C_TIME:C306($hRef)
$hRef:=Open document:C264("")

If (OK=1)
	//$path:=Convert path system to POSIX(document)
	$path:=document
	CLOSE DOCUMENT:C267($hRef)
	//createLinkedDocsRecordFromPath($path)
	createLinkedDocFile(Current default table:C363; $path)
	
	POST OUTSIDE CALL:C329(Current process:C322)
End if 