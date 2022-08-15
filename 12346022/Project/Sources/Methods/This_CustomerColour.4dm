//%attributes = {}

C_LONGINT:C283($0)

If (([Customers:3]isOnHold:52) | ([Customers:3]AML_RiskRating:75>3))
	//calcRGB (255;0;0)
	$0:=(255 << 16)
Else 
	$0:=0
End if 