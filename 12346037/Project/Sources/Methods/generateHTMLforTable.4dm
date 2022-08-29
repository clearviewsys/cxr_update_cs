//%attributes = {}
// generateHTMLforTable (->table) -> htmlText

C_POINTER:C301($1)
C_LONGINT:C283($i)

C_TEXT:C284($title; $body; $field; $htmlPage; $col1; $col2; $col3; $webVar)
$title:=Table name:C256($1)

For ($i; 1; Get last field number:C255($1))
	If (Is field number valid:C1000($1; $i))  // Jan 16, 2012 18:25:45 -- I.Barclay Berry 
		$field:=Field name:C257(Table:C252($1); $i)
		$webVar:="web"+$field
		$col1:=HTMLTableColumn($field)
		$col2:=HTMLTableColumn(HTMLHiddenField($webVar; HTML4DVAR($webVar))+HTML4DVAR($webVar))
		$col3:=HTMLTableColumn(HTMLField($webVar; ""))
		$body:=$body+(HTMLTableRow($col1+$col2+$col3))
	End if 
End for 
$body:=HTMLTable($body)
$htmlPage:=HTMLPage($title; $body)

C_TIME:C306(vhDocRef)
vhDocRef:=Create document:C266("_"+Table name:C256($1)+".html")  // Create new document called Note 

If (OK=1)
	SEND PACKET:C103(vhDocRef; $htmlPage)  // Write one word in the document 
	
	CLOSE DOCUMENT:C267(vhDocRef)  // Close the document 
	
End if 