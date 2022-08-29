//%attributes = {}
// makeCashAcountID (currencySymbol;{machineID})

C_TEXT:C284($1; $2; $0)
Case of 
	: (Count parameters:C259=1)
		$0:="Cash-"+Uppercase:C13($1)
	: (Count parameters:C259=2)
		If ($2="00")  // safe

			$0:="Cash-"+Uppercase:C13($1)
		Else 
			$0:="Cash-"+Uppercase:C13($1)+"-"+$2
		End if 
End case 