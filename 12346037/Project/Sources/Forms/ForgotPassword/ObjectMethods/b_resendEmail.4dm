C_TEXT:C284($resetCode)
C_TIME:C306($expiryTime)
C_DATE:C307($expiryDate)
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		//check if code is valid
		If (forgotPasswordCodeValid(Form:C1466.resetCode; Form:C1466.resetCodeExpiryTime; Date:C102(Form:C1466.resetCodeExpiryDate)))
			//if valid
			////resend same code
			forgotPasswordEmail(Form:C1466.resetCode; Form:C1466.email)
			myAlert("Reset code sent to "+Form:C1466.email)
			
			//else
		Else 
			////generate new code, save to user
			QUERY:C277([Users:25]; [Users:25]UserID:1=Form:C1466.userId)
			If (Records in selection:C76([Users:25])=1)
				
				$resetCode:=Substring:C12(Generate digest:C1147("this is my salt"+String:C10(Random:C100); SHA256 digest:K66:4); 0; 8)
				//////Generate code expiry date (now + 15 mins)
				$expiryTime:=Current time:C178+Time:C179("00:15:00")
				
				$expiryDate:=Current date:C33
				If ($expiryTime<Time:C179("00:15:00"))
					$expiryDate:=Add to date:C393($expiryDate; 0; 0; 1)
				End if 
				
				forgotPasswordEmail($resetCode; [Users:25]email:39)
				myAlert("Reset code sent to "+Form:C1466.email)
				
				[Users:25]resetCode:37:=$resetCode
				[Users:25]resetCodeExpiryTime:38:=$expiryTime
				[Users:25]resetCodeExpiryDate:40:=$expiryDate
				
			End if 
			//end if
		End if 
		
End case 