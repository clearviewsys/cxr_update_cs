//%attributes = {}
// isSLAValid
// this method returns true if the SLA is valid  
C_BOOLEAN:C305($0)

C_DATE:C307($expiryDate)

$expiryDate:=<>SLA_ExpiryDate
If ($expiryDate>Current date:C33)  // the expiry date must be greater than today
	$0:=True:C214  // still valid
Else 
	$0:=False:C215
End if 