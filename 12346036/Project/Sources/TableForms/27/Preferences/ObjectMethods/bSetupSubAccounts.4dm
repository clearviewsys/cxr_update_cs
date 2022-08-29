C_LONGINT:C283($winRef)

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (isUserDesigner | isUserSupport | isUserSuperAdmin)
			$winRef:=Open form window:C675("TwilioSelectSubaccount"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
			DIALOG:C40("TwilioSelectSubaccount")
			CLOSE WINDOW:C154($winRef)
		Else 
			myAlert("This ability is restricted to CXR Admin only."+\
				String:C10(Carriage return:K15:38)+\
				"If you wish to set up twilio billing through CXR, please contact a CXR admin")
		End if 
End case 
