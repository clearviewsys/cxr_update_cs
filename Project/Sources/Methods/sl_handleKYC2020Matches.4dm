//%attributes = {}
#DECLARE($objectPtr : Pointer; $formEvent : Integer)

If (Count parameters:C259<1)
	$objectPtr:=OBJECT Get pointer:C1124(Object current:K67:2)
End if 

If (Count parameters:C259<2)
	$formEvent:=Form event code:C388
End if 

If (Count parameters:C259>=3)
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 


var $mustMatch : Text
$mustMatch:=""
If (Form:C1466.KYC2020.mustMatchName)
	$mustMatch:="1"
End if 

If (Form:C1466.KYC2020.mustMatchAddress)
	$mustMatch:=$mustMatch+($mustMatch="" ? "" : "#")+"2"
End if 


If (Form:C1466.KYC2020.mustMatchID)
	$mustMatch:=$mustMatch+($mustMatch="" ? "" : "#")+"3"
End if 

[SanctionLists:113]Details:13.KYC2020.mustMatch:=$mustMatch