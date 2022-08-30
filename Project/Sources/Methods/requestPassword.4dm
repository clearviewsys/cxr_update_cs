//%attributes = {}
// requestPassword (message)-> thePassword string
// it is up to the caller to make sure it is matching or not
C_TEXT:C284(vPasswordString; vPasswordMessage; $0; $1)

vPasswordString:=""
Case of 
	: (Count parameters:C259=1)
		vPasswordMessage:=$1
	Else 
		vPasswordMessage:="Please enter the over-ride password to continue."
End case 
C_LONGINT:C283($windowRef)
$windowRef:=openFormWindow(->[CompanyInfo:7]; "requestPasswordForm"; Modal dialog box:K34:2)
CLOSE WINDOW:C154($windowRef)
$0:=vPasswordString

