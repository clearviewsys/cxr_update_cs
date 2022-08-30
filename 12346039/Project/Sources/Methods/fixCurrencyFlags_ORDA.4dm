//%attributes = {}
// fixCurrencyFlags_ORDA
// This method fixed currencies flags based on the flags table
// it reassigns the pictures to the flags
// #ORDA version

C_OBJECT:C1216($esCurrency; $esFlags; $esCurrencies)
C_LONGINT:C283($i; $n)
C_PICTURE:C286($flag)

For each ($esCurrency; ds:C1482.Currencies.all())
	$esFlags:=ds:C1482.Flags.query("CurrencyCode = :1"; $esCurrency.ISO4217)
	If ($esFlags#Null:C1517)
		$esCurrency.Name:=$esFlags[0].CurrencyName  // #ORDA 
		$esCurrency.Flag:=$esFlags[0].flag  // #orda ; doesn't work in v17.3
		$esCurrency.save()
	End if 
End for each 


