C_TEXT:C284($ret)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (Form:C1466.ClientCode#"")
			$ret:=RAL2_emailClientKey(Form:C1466.ClientCode; False:C215)
			If ($ret="0")
				myAlert("Cient Key and Code have been sent to the email associated with this account.")
			Else 
				RAL2_handleErrors($ret)
			End if 
		Else 
			myAlert("Please enter your Client Code."+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+"If you do not know your Client Code, or do not have an account, please register a new client. If an account is found with matching details, the credentials will be emailed to you.")
		End if 
End case 