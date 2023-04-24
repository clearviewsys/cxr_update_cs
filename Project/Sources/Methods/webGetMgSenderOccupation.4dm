//%attributes = {"shared":true}
C_TEXT:C284($0)


If ([WebEWires:149]paymentInfo:35.soap.passed.SenderOccupation=Null:C1517)
	$0:=""
Else 
	$0:=[WebEWires:149]paymentInfo:35.soap.passed.SenderOccupation
End if 