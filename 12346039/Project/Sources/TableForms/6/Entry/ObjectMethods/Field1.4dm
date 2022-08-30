If (Form event code:C388=On Clicked:K2:4)
	// getBuild
	If (Shift down:C543)
		loadPicture(""; Self:C308)
	Else 
		C_OBJECT:C1216($es)  // # ORDA
		$es:=ds:C1482.Flags.query("CurrencyCode = :1"; [Currencies:6]ISO4217:31)
		If ($es#Null:C1517)  // you have to make sure the record exist
			[Currencies:6]Flag:3:=$es[0].flag
		End if 
	End if 
End if 