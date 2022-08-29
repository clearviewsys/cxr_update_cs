//%attributes = {}
C_TEXT:C284($userName; $resetCode; $1)
C_TIME:C306($expiryTime; $dif; $now)
C_DATE:C307($expiryDate)
C_OBJECT:C1216($form)
C_LONGINT:C283($winRef)

C_TEXT:C284($sUser; $sSessionUser; $sProcessName)
C_LONGINT:C283($iProcess)

$form:=New object:C1471()


Case of 
	: (Count parameters:C259=1)
		$userName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

QUERY:C277([Users:25]; [Users:25]UserName:3=$userName)

If (Records in selection:C76([Users:25])=1)
	
	If ([Users:25]email:39#"")
		
		If (forgotPasswordCodeValid([Users:25]resetCode:37; [Users:25]resetCodeExpiryTime:38; [Users:25]resetCodeExpiryDate:40))
			
			
			$form.userId:=[Users:25]UserID:1
			$form.email:=[Users:25]email:39
			$form.resetCode:=[Users:25]resetCode:37
			$form.resetCodeExpiryTime:=[Users:25]resetCodeExpiryTime:38
			$form.resetCodeExpiryDate:=[Users:25]resetCodeExpiryDate:40
			
			$winRef:=Open form window:C675("ForgotPassword"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
			DIALOG:C40("ForgotPassword"; $form)
			CLOSE WINDOW:C154($winRef)
			
		Else 
			
			//////Generate new code
			$resetCode:=Substring:C12(Generate digest:C1147("this is my salt"+String:C10(Random:C100); SHA256 digest:K66:4); 0; 8)
			//////Generate code expiry date (now + 15 mins)
			$expiryTime:=Current time:C178+Time:C179("00:15:00")
			
			$expiryDate:=Current date:C33
			If ($expiryTime<Time:C179("00:15:00"))
				$expiryDate:=Add to date:C393($expiryDate; 0; 0; 1)
			End if 
			
			If (Locked:C147([Users:25]))
				LOCKED BY:C353([Users:25]; $iProcess; $sUser; $sSessionUser; $sProcessName)
				myAlert(Table name:C256(->[Users:25])+" is LOCKED by User: "+$sUser+" Session User: "+$sSessionUser+" Process Name: "+$sProcessName+\
					" Please ensure the record is not being edited on the system before trying again")
			Else 
				
				forgotPasswordEmail($resetCode; [Users:25]email:39)
				myAlert("Reset code sent to "+[Users:25]email:39)
				
				
				[Users:25]resetCode:37:=$resetCode
				[Users:25]resetCodeExpiryTime:38:=$expiryTime
				[Users:25]resetCodeExpiryDate:40:=$expiryDate
				
				
				$form.userId:=[Users:25]UserID:1
				$form.email:=[Users:25]email:39
				$form.resetCode:=[Users:25]resetCode:37
				$form.resetCodeExpiryTime:=[Users:25]resetCodeExpiryTime:38
				$form.resetCodeExpiryDate:=[Users:25]resetCodeExpiryDate:40
				
				SAVE RECORD:C53([Users:25])
				UNLOAD RECORD:C212([Users:25])
				
				$winRef:=Open form window:C675("ForgotPassword"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
				DIALOG:C40("ForgotPassword"; $form)
				CLOSE WINDOW:C154($winRef)
				
			End if 
			//////Open form to get code
		End if 
		
	Else 
		myAlert("No email associated with account for password reset"+Char:C90(Carriage return:K15:38)+"Please contact system administrator"; "Error")
	End if 
	
Else 
	//Error: Account does not exist with user name: $userName
	myAlert("Error: No account with user name: "+$userName+" exists, Please contact your system administrator"; "Error")
End if 

