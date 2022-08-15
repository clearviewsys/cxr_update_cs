//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($1)
C_TEXT:C284($0)
C_TEXT:C284($prefix)

If ($1=True:C214)
	$prefix:=String:C10(Random:C100; "C00-00000")
Else 
	$prefix:=String:C10(Random:C100; "B00-00000")
End if 
$0:=$prefix+"-"+String:C10(Sequence number:C244([WebSessions:15]))