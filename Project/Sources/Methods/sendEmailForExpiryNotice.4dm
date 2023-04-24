//%attributes = {}
// sendEmailForExpiryNotice (expiryDate)

C_TEXT:C284($email; $subject; $message)
C_DATE:C307($expiryDate; $1)
If (Count parameters:C259=0)
	$expiryDate:=Current date:C33
Else 
	$expiryDate:=$1
End if 

$email:="tiran@clearviewsys.com"
$subject:="Expiry Notice: "+<>companyName
$message:="System will expire on "+String:C10($expiryDate; ISO date:K1:8)+CRLF
$message:=$message+"Worksation: "+Current machine:C483+". Owner: "+Current system user:C484+CRLF
$message:=$message+"Mac Address: "+UTIL_getMacAddress

sendEmail($email; $subject; $message)
