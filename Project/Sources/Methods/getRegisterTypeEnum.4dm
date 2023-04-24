//%attributes = {}
// getregisterTypeEnum (string) -> {transfer = 0; cash=1  ; cheque=2  ; wire=3 }:integer

// transfer = 0

// cash =1

// cheque, draft, =2

// wire = 3


// this method returns 1 2 or 3 depending on the type of payable

//

C_TEXT:C284($1)
C_LONGINT:C283($0)
$0:=2  // default is cheque category


Case of 
	: ($1="")
		$0:=-1
		
	: ($1="Transfer")
		$0:=0
		
	: ($1="Cash")
		$0:=1
		
	: (($1="Wire") | ($1="eWire") | ($1="Debit Card") | ($1="Credit Card") | ($1="Western Union") | ($1="Money Gram"))
		$0:=3
		
End case 

//If (($1#"") & ($1#"Cash") & ($1#"Wire") & ($1#"Transfer"))  ` cheque category

//$0:=2  ` it is a draft, money order, certifier, etc...

//End if 