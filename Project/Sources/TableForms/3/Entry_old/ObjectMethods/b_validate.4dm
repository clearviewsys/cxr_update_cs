
C_TEXT:C284($resetCode; $toNumber)
C_OBJECT:C1216($form)
$form:=New object:C1471()

$toNumber:=[Customers:3]CellPhone:13
$resetCode:=Substring:C12(Generate digest:C1147("CustomerSalt"+String:C10(Random:C100); SHA256 digest:K66:4); 0; 8)

If (sendPhoneValidationCode($resetCode; $toNumber))
	$form.number:=$toNumber
	$form.resetCode:=$resetCode
	
	C_LONGINT:C283($win)
	$win:=Open form window:C675([Customers:3]; "ValidatePhone"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40([Customers:3]; "ValidatePhone"; $form)
	CLOSE WINDOW:C154($win)
	
End if 