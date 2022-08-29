//%attributes = {}
// makeChequeAcountID (currencySymbol; {bool: isPayable})

// if one parameter is sent make it only checkReceivable but otherwise look at the second parameter

// to determine

// cheque receivable account ID


C_TEXT:C284($1; $0)
C_BOOLEAN:C305($2)

Case of 
		
	: (Count parameters:C259=1)
		$0:=makeChequeReceivable($1)
		
	: (Count parameters:C259=2)
		If ($2)
			$0:=makeChequePayable($1)
		Else 
			$0:=makeChequeReceivable($1)
		End if 
		
End case 