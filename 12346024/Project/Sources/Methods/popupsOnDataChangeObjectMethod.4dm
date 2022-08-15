//%attributes = {}
C_TEXT:C284($1; $formObjectProperty)

If (Form event code:C388=On Data Change:K2:15)
	
	$formObjectProperty:=$1
	
	Form:C1466[$formObjectProperty].selected:=OBJECT Get name:C1087(Object current:K67:2)
	
End if 
