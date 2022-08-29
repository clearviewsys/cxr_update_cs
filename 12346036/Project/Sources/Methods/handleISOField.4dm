//%attributes = {}
// handleISOField (->isoField)
// this method is used inside the ISO4217 and toISO4217 fields in the currency entry form

C_POINTER:C301($1)

pickFlags($1)
If ([Currencies:6]ISO4217:31#"")
	If ([Currencies:6]toISO4217:32="")
		[Currencies:6]toISO4217:32:=<>baseCurrency
	End if 
	
	If ([Currencies:6]toISO4217:32=<>BaseCurrency)
		If ([Currencies:6]CurrencyCode:1="")
			[Currencies:6]CurrencyCode:1:=[Currencies:6]ISO4217:31
		End if 
		[Currencies:6]isDisplayOnly:33:=False:C215
		
		setIfNotNullString(->[Currencies:6]Name:2; [Flags:19]CurrencyName:2)
		[Currencies:6]Country:22:=[Flags:19]Country:3
		[Currencies:6]Flag:3:=[Flags:19]flag:4
		
	Else   // base is another currency (non CAD)
		
		[Currencies:6]CurrencyCode:1:=[Currencies:6]ISO4217:31+"/"+[Currencies:6]toISO4217:32
		[Currencies:6]isDisplayOnly:33:=True:C214
		[Currencies:6]hasCashAccount:23:=False:C215
		[Currencies:6]hasChequeAccount:24:=False:C215
	End if 
	
End if 