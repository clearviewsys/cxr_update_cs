C_LONGINT:C283($winRef)
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Form:C1466.isCompany:=0
		$winRef:=Open form window:C675("RegistrationNew"; Movable form dialog box:K39:8)
		DIALOG:C40("RegistrationNew"; Form:C1466)
		CLOSE WINDOW:C154($winRef)
		If (Form:C1466.success)
			RAL2_Licensing(True:C214)
			//Go to licensing
			Form:C1466.success:=True:C214
			ACCEPT:C269
			
		Else 
			REJECT:C38
		End if 
		
End case 