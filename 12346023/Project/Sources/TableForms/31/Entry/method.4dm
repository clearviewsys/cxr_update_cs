C_TEXT:C284(vLastCodeUsed)
HandleEntryFormMethod
If (onNewRecordEvent)
	SET FIELD RELATION:C919([Denominations:31]Currency:2; Automatic:K51:4; Structure configuration:K51:2)
	UNLOAD RECORD:C212([Flags:19])
End if 

If (Form event code:C388=On Load:K2:1)
	If (([Denominations:31]Currency:2="") & (vLastCodeUsed#""))
		[Denominations:31]Currency:2:=vLastCodeUsed
		handleFillDenominationsArray
		GOTO OBJECT:C206([Denominations:31]Value:3)
	Else 
		GOTO OBJECT:C206([Denominations:31]Currency:2)
	End if 
	
End if 

If (Form event code:C388=On Clicked:K2:4)
	//relateOne (->[Flags];->[Denominations]Currency;->[Flags]CurrencyCode)
	
End if 

If (Form event code:C388=On Close Box:K2:21)
	SET FIELD RELATION:C919([Denominations:31]Currency:2; Structure configuration:K51:2; Structure configuration:K51:2)
End if 