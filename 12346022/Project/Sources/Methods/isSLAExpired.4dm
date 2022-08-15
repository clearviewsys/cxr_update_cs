//%attributes = {}
// isSLAExpired
// this method returns true if the SLA is expired  
C_BOOLEAN:C305($0)

C_DATE:C307($expiryDate)

$expiryDate:=<>SLA_ExpiryDate
If ($expiryDate<=Current date:C33)
	$0:=True:C214  // expired
Else 
	$0:=False:C215
End if 