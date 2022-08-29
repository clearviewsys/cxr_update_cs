C_TIME:C306($doc)
C_TEXT:C284($json)
C_COLLECTION:C1488($log)

$doc:=Open document:C264("")

If (OK=1)
	
	CLOSE DOCUMENT:C267($doc)
	
	$json:=Document to text:C1236(Document; "UTF-8")
	
	$log:=JSON Parse:C1218($json)
	
	Form:C1466.mglog:=$log
	
End if 
