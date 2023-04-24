C_TEXT:C284($text)
If (Form event code:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
Else 
	$text:=textToSearch
End if 

//$emps:=ds.Customers.query("firstname = :1 or lastname = :1";$text+"@")