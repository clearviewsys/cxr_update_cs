//%attributes = {}
// makeWireAcountID (currencySymbol;boolean isPayable)

// cheque receivable account ID


C_TEXT:C284($1; $0)
C_BOOLEAN:C305($2)
If ($2)
	$0:="WirePayable-"+Uppercase:C13($1)
Else 
	
	$0:="WireReceivable-"+Uppercase:C13($1)
End if 