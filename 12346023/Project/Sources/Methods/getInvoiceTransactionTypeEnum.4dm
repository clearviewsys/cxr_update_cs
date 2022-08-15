//%attributes = {}
//   ` getInvoiceTransactionTypeEnum (string) -> {buy=1  ; sell=2  ; cross=3; none =0 }:integer


// this method returns 1 2 or 3 depending on the type of payable

//

C_TEXT:C284($1)
C_LONGINT:C283($0)

Case of 
	: ($1="Buy")
		$0:=1
	: ($1="Sell")
		$0:=2
	: ($1="Cross")
		$0:=3
	: ($1="Charge")
		$0:=4
	: ($1="")
		$0:=0
End case 