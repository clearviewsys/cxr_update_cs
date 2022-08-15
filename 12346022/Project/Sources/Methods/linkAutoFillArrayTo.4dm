//%attributes = {}
// linkAutoFillArrayTo(self; ->field | ->variable)

// call this method from your autoFillArray

C_POINTER:C301($1; $2)

If (Form event code:C388=On Load:K2:1)
	OBJECT SET VISIBLE:C603($1->; False:C215)
End if 
If (Form event code:C388=On Clicked:K2:4)
	$2->:=$1->{$1->}
End if 
