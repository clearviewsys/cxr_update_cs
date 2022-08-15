C_BOOLEAN:C305($set)

CONFIRM:C162("Enforce denomination entry on selected currencies"; "Make Mandatory"; "Make Optional")
If (OK=1)
	$set:=True:C214
Else 
	$set:=False:C215
End if 

CONFIRM:C162("Are you sure you want to enforce denomination entry on selection?")
If (OK=1)
	USE SET:C118("$currencies_LBSet")
	READ WRITE:C146([Currencies:6])
	APPLY TO SELECTION:C70([Currencies:6]; [Currencies:6]doRequestDenoms:53:=$set)
	READ ONLY:C145([Currencies:6])
End if 