//%attributes = {}
// myconfirm(message; OK;Cancel;subject)

C_TEXT:C284($1; confirmMessage)
C_TEXT:C284($2; okayButtonTitle)
C_TEXT:C284($3; cancelButttonTitle)
C_TEXT:C284($4; confirmSubject)
C_OBJECT:C1216($oForm)

$oForm:=New object:C1471("confirmMessage"; ""; "okayButtonTitle"; "OK"; "cancelButtonTitle"; "Cancel"; "confirmSubject"; "")


Case of 
	: (Count parameters:C259=1)
		$oForm.confirmMessage:=$1
		
	: (Count parameters:C259=2)
		$oForm.confirmMessage:=$1
		$oForm.okayButtonTitle:=$2
		
	: (Count parameters:C259=3)
		$oForm.confirmMessage:=$1
		$oForm.okayButtonTitle:=$2
		$oForm.cancelButtonTitle:=$3
		
	: (Count parameters:C259=4)
		$oForm.confirmMessage:=$1
		$oForm.okayButtonTitle:=$2
		$oForm.cancelButtonTitle:=$3
		$oForm.confirmSubject:=$4
	Else 
		assert_old(False:C215; "Invalid no of params (myConfirm)")
End case 

If ((Application type:C494#4D Server:K5:6) & ($oForm.confirmMessage#""))
	//if(confirmMessage#"")
	C_LONGINT:C283($winRef)
	$winRef:=Open form window:C675([CompanyInfo:7]; "confirmDialog"; Sheet form window:K39:12; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40([CompanyInfo:7]; "confirmDialog"; $oForm)
	CLOSE WINDOW:C154($winRef)
End if 