C_TEXT:C284($group)

If (Records in set:C195("$Currencies_LBSet")=0)
	ALERT:C41("Please highlight some records first.")
Else 
	$group:=Request:C163("Please enter the group name?")
	READ WRITE:C146([Currencies:6])
	USE SET:C118("$Currencies_LBSet")
	If ($group#"")
		APPLY TO SELECTION:C70([Currencies:6]; [Currencies:6]CurrencyGroup:34:=$group)
	End if 
	READ ONLY:C145([Currencies:6])
End if 

