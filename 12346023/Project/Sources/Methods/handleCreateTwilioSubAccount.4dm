//%attributes = {}
C_TEXT:C284($error; $accountId)
C_POINTER:C301($pError)
$pError:=->$error

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		OBJECT SET ENABLED:C1123(*; "b_Send"; False:C215)
		OBJECT SET ENABLED:C1123(*; "f_accountName"; False:C215)
		OBJECT SET ENABLED:C1123(*; "f_setCurrent"; False:C215)
		
		
		$accountId:=twilioCreateSubAccount($pError; Form:C1466.accountName)
		
		If ($error#"")
			OBJECT SET ENABLED:C1123(*; "b_Send"; True:C214)
			OBJECT SET ENABLED:C1123(*; "f_accountName"; True:C214)
			OBJECT SET ENABLED:C1123(*; "f_setCurrent"; True:C214)
			myAlert($error)
		Else 
			
			OBJECT SET VISIBLE:C603(*; "h_accountSid"; True:C214)
			OBJECT SET VISIBLE:C603(*; "f_accountSid"; True:C214)
			Form:C1466.accountSid:=$accountId
			Form:C1466.returnedSid:=$accountId
			
			
			If (Form:C1466.setCurrent=1)
				twilioSetSubAccount($accountId)
			End if 
			
			If (Form:C1466.fromSelect)
				ACCEPT:C269
			End if 
		End if 
End case 