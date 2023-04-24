handleTristateCheckBox(Self:C308; ->[AML_Alerts:137]status:8; "Not Resolved"; "Resolved ✔"; "Undecided")

If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	Case of 
		: ([AML_Alerts:137]status:8=1)
			[AML_Alerts:137]resolutionDate:11:=Current date:C33
			[AML_Alerts:137]resolvedByUserID:13:=getApplicationUser
			
		: ([AML_Alerts:137]status:8=2)
			[AML_Alerts:137]resolvedByUserID:13:=getApplicationUser
			
		Else 
			[AML_Alerts:137]resolutionDate:11:=!00-00-00!
			[AML_Alerts:137]resolvedByUserID:13:=""
	End case 
	
End if 