//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 09/12/18, 09:27:19
// ----------------------------------------------------
// Method: SYNC_statusProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $iCallingProcess)
C_BOOLEAN:C305($2)  //just to indicate a new process

C_PICTURE:C286(picStatus)
C_PICTURE:C286($Null)

If (Count parameters:C259>=1)
	$iCallingProcess:=$1
Else 
	$iCallingProcess:=Current process:C322
End if 


C_LONGINT:C283($iProcess)
$iProcess:=Process number:C372("$SYNC_Status"; *)  //server process

Case of 
	: ($iProcess=0)
		C_LONGINT:C283($pid)
		//$pid:=New process("SYNC_statusProcess";0;"$SYNC_Status";$iCallingProcess;True;*)
		$pid:=Execute on server:C373("SYNC_statusProcess"; 0; "$SYNC_Status"; $iCallingProcess; True:C214; *)
		
	: (Count parameters:C259=2)  //this is a new process so init
		
		If (Sync_Is_Status_On("enabled"))
			Repeat 
				picStatus:=Sync_Get_RemoteStatus
				
				If (Current user:C182="designer")
					DELAY PROCESS:C323(Current process:C322; 60*60)  //every minute
				Else 
					DELAY PROCESS:C323(Current process:C322; 60*60*10)  //every ten minutes
				End if 
				
			Until (<>SHELL_QUIT)
		End if 
		
		
	Else   //this is existing so update
		
		GET PROCESS VARIABLE:C371($iProcess; picStatus; SYNC_picStatus)
		
End case 
