//%attributes = {}
C_TEXT:C284($1; $customerID)
C_BOOLEAN:C305($0)
$customerID:=$1

If (($customerID=getWalkInCustomerID) | ($customerID=getSelfCustomerID) | (Substring:C12($customerID; 1; 3)="000"))
	$0:=True:C214
Else 
	$0:=False:C215
End if 
