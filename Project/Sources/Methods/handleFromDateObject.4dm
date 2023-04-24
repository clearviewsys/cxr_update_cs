//%attributes = {}

// handles the fromDate objects
// EVENTS : On Load ; On Data Change; On Before Keystroke
// 
// call this method for any vFromDate field


C_DATE:C307(vFromDate; <>fromDate)
C_POINTER:C301($1)

If (Form event code:C388=On Load:K2:1)
	$1->:=<>fromDate
End if 

If (Form event code:C388=On Data Change:K2:15)
	<>fromDate:=$1->
End if 

handleDateWidget($1)