//%attributes = {}
// handles the toDate objects (self)
// EVENTS : On Load ; On Data Change, On Before KS
// 
// call this method for any vtoDate field
C_POINTER:C301($1)
C_DATE:C307(vToDate)

If (Form event code:C388=On Load:K2:1)
	$1->:=<>toDate
End if 

If (Form event code:C388=On Data Change:K2:15)
	<>toDate:=$1->
End if 

handleDateWidget($1)