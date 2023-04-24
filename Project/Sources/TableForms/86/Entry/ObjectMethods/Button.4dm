C_OBJECT:C1216($o)
C_TIME:C306($hRef)
C_TEXT:C284($posixPath)
C_OBJECT:C1216($o)
C_TEXT:C284($path)

$hRef:=Open document:C264("")

If (OK=1)
	//$path:=Convert path system to POSIX(document)
	$path:=document
	//READ PICTURE FILE($path;[WebAttachments]Preview;*)
	//CREATE THUMBNAIL([WebAttachments]Preview;[WebAttachments]Preview;110;100;6)  //Needs Work Sizing img***
	[WebAttachments:86]Preview:12:=WAPI_pict2Thumbnail(->$path; 0; 96; 0.5)
	CLOSE DOCUMENT:C267($hRef)
	$o:=Path to object:C1547($path)
	//$o:=File($path)
	WA OPEN URL:C1020(webArea; $path)
	$posixPath:=Convert path system to POSIX:C1106($path)
	[WebAttachments:86]FilePath:3:=$posixPath
	[WebAttachments:86]FileName:5:=$o.name  //+$o.extension
	[WebAttachments:86]MimeType:10:=getMimeTypeByExtention($o.extension)
	Form:C1466.path:=document
	
	//set $path to the web area
	//set $path file namet to field
	
End if 