//%attributes = {}
C_TEXT:C284($curr)

If (CBCURRENCIES<Size of array:C274(CBCURRENCIES))
	
	CBCURRENCIES:=CBCURRENCIES+1
	$curr:=CBCURRENCIES{CBCURRENCIES}
	CBCURRENCIES{0}:=$curr
	
	fillTellerProofArrays($curr)
Else 
	BEEP:C151
End if 
