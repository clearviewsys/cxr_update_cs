//%attributes = {}
// makeBank (currencySymbol;"BankName")
C_TEXT:C284($1; $2; $0)
Case of 
	: (Count parameters:C259=1)
		$0:="Bank-"+Uppercase:C13($1)
	: (Count parameters:C259=2)
		$0:="Bank-"+$2+"-"+Uppercase:C13($1)
End case 