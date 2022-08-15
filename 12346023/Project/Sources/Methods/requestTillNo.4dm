//%attributes = {}
// requestTillNo(message) -> text
// returns the cash registerID that is picked by the user

C_TEXT:C284($0)
C_TEXT:C284($1; vMessageLabel)
C_LONGINT:C283($winRef)

If (Count parameters:C259=1)
	vMessageLabel:=$1
Else 
	vMessagelabel:="Please pick a till:"
End if 
ARRAY TEXT:C222(arrTillNo; 0)

$winRef:=openFormWindow(->[CashRegisters:33]; "pickTill"; Modal dialog box:K34:2)
If ((OK=1) & (arrTillNo>0))
	$0:=[CashRegisters:33]CashRegisterID:1
End if 
CLOSE WINDOW:C154($winRef)
