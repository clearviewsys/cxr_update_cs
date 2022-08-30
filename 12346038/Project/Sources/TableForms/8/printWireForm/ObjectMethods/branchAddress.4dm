If (Form event code:C388=On Header:K2:17)
	C_TEXT:C284($phone)
	$phone:=getBranchPhone
	handlePhoneField(->$phone)
	Self:C308->:=getBranchFullAddress+CRLF+$phone
End if 
