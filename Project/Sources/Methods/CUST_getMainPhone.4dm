//%attributes = {}
C_TEXT:C284($0)
If ([Customers:3]isCompany:41)
	$0:=getFirstNonEmptyString([Customers:3]HomeTel:6; [Customers:3]WorkTel:12; [Customers:3]CellPhone:13)
Else 
	$0:=getFirstNonEmptyString([Customers:3]HomeTel:6; [Customers:3]CellPhone:13; [Customers:3]WorkTel:12)
End if 