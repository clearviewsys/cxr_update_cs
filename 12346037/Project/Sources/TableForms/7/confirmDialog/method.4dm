C_TEXT:C284(okayButtonTitle)
C_TEXT:C284(cancelButttonTitle)
C_BOOLEAN:C305(quitByTimer)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET TITLE:C194(*; "OKButton"; Form:C1466.okayButtonTitle)
		OBJECT SET TITLE:C194(*; "CancelButton"; Form:C1466.cancelButtonTitle)
		
	: (Form event code:C388=On Outside Call:K2:11)
		
		If (Not:C34(Undefined:C82(quitByTimer)))
			If (quitByTimer)
				CANCEL:C270
			End if 
		End if 
		
		
		
End case 

