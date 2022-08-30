//%attributes = {}
// getPaymentTypeEnum (string) -> {nul:0 ; received=1  ; paid=2  }:boolean


// this method returns true if payment is received

//

C_TEXT:C284($1)
C_BOOLEAN:C305($0)

//Case of 

//: ($1="Received")

//$0:=True

//: ($1="Paid")

//$0:=False

//: ($1="")

//$0:=False

//End case 


If ($1="Received")
	$0:=True:C214
Else 
	$0:=False:C215
End if 
