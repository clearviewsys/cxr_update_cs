//%attributes = {}
C_LONGINT:C283($delayMinutes; $delayTicks; $alertWinRef)
C_TEXT:C284($alertMessage)
C_BOOLEAN:C305($endProcess; <>LOGOFFUSERPRESENT; <>AutoLogoutContinue)
C_LONGINT:C283(<>LOGOFFPID)

<>LOGOFFPID:=Current process:C322
<>LOGOFFUSERPRESENT:=False:C215
<>AutoLogoutContinue:=True:C214

Repeat 
	
	$delayMinutes:=<>AUTOLOGOUTTIME
	
	//Convert from minutes to seconds to ticks
	//DELAY PROCESS requires ticks
	$delayTicks:=$delayMinutes*60*60
	
	//Check after $delayMinutes
	ON EVENT CALL:C190("autoLogoutCheck")
	
	DELAY PROCESS:C323(<>LOGOFFPID; $delayTicks)
	If (<>autoLogoutEnabled & <>AutoLogoutContinue)
		If (<>LOGOFFUSERPRESENT)  //User present since last check
			
			<>LOGOFFUSERPRESENT:=False:C215
			ON EVENT CALL:C190("autoLogoutCheck")
			
		Else   //User has not been present since last check
			
			BEEP:C151
			BEEP:C151
			BEEP:C151
			
			$alertMessage:="Warning!"+Char:C90(Carriage return:K15:38)
			$alertMessage:=$alertMessage+"You will be logged off in 1 minute!"+Char:C90(Carriage return:K15:38)
			$alertMessage:=$alertMessage+"Please continue work or click on this window if you wish to continue"
			
			notifyAlert("Auto logoff warning"; $alertMessage; 60)
			
			ON EVENT CALL:C190("autoLogoutCheck")
			
			DELAY PROCESS:C323(<>LOGOFFPID; 1*60*60)
			
			If (<>LOGOFFUSERPRESENT)  //User came back
				
			Else 
				<>AutoLogoutContinue:=False:C215
				<>LOGOFFPID:=0  // cannot assign to nill
				lockScreen
				switchApplicationUser
			End if 
		End if 
	End if 
	
Until (Not:C34(<>AutoLogoutContinue))


