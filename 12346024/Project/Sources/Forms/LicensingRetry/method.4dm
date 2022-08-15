Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Form:C1466.retry)
			OBJECT SET TITLE:C194(*; "b_licensingRetry"; "Retry")
			OBJECT SET VISIBLE:C603(*; "t_unActivated"; True:C214)
		End if 
End case 