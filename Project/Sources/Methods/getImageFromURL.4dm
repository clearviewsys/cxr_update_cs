//%attributes = {}
C_PICTURE:C286($0; $thePicture)
C_TEXT:C284($1; $url)
C_LONGINT:C283($err)

$url:=$1

ON ERR CALL:C155("onErrCallIgnore")

$err:=HTTP Get:C1157($url; $thePicture)

ON ERR CALL:C155("")

If ($err=200)
	
	$0:=$thePicture
	
End if 
