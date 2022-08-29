//%attributes = {}
// isSLAExpiringSoon
// this method returns true if the SLA is expiring in 3 weeks  
C_BOOLEAN:C305($0; $result)
C_LONGINT:C283($diff)

$diff:=<>SLA_ExpiryDate-Current date:C33
If (($diff<21) & ($diff>0))
	$result:=True:C214  // expired
Else 
	$result:=False:C215
End if 

$0:=$result