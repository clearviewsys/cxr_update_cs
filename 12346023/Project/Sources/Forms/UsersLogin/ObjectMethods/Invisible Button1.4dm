Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If ((Macintosh option down:C545) & (Macintosh command down:C546) & (Caps lock down:C547) & (Shift down:C543))
			If (Not:C34(isDesignerEnabled(False:C215)))
				resetDesignerAttempts
				notifyAlert("Account"; "Account lock has been reset"; 5)
				sendDesignerResetEmail
			End if 
		End if 
End case 