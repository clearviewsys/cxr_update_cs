//%attributes = {"shared":true}
C_REAL:C285(vCashReceived; $0; vCashReceivable; $1; vChangePayable)

If (Count parameters:C259=1)
	vCashReceived:=$1
	vCashReceivable:=$1
	vChangePayable:=0
Else 
	vCashReceived:=202.2
	vCashReceivable:=202.2
	vChangePayable:=0
End if 

openFormWindow(->[Invoices:5]; "ReceiveCashLCForm"; Plain dialog box:K34:4)

$0:=vCashReceived
