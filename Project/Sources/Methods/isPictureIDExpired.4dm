//%attributes = {}
// isPictureIDExpired (expDate)

C_DATE:C307($date; $1)
$date:=$1

C_BOOLEAN:C305($0)

If (($date<=Current date:C33) & ($date#!00-00-00!))
	$0:=True:C214
Else 
	$0:=False:C215
End if 

