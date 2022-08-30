//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/21/20, 14:30:48
// ----------------------------------------------------
// Method: confirmationGetResult
// Description
// 
//.  return the accept or deny status (1 or 2)

//   1 = accept
//.  2 = deny
//  -1 = timeout
//  -9999 = confirmation record not found

//.  waits until that is set - if no confirmation record is found return -1
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tID)
C_LONGINT:C283($0; $iStatus)

C_LONGINT:C283($iTimeout; $iTimeRemain; $iProgress; $iError)
C_TIME:C306($hWaitTil)


$tID:=$1

$iStatus:=confirmationNotFound  //not found
$iTimeout:=Num:C11(getKeyValue("confirmation.wait.timeout"; "2"))*60  //60*2
$iTimeRemain:=$iTimeout

$hWaitTil:=Current time:C178+$iTimeout

READ ONLY:C145([Confirmations:153])

QUERY:C277([Confirmations:153]; [Confirmations:153]confirmationID:2=$tID)

If (Records in selection:C76([Confirmations:153])=1)
	
	$iProgress:=Progress New
	Progress SET ICON($iProgress; <>CompanyLogo)
	Progress SET TITLE($iProgress; "Requesting Confirmation")
	Progress SET MESSAGE($iProgress; "Waiting for "+String:C10($iTimeout)+" seconds(s)")
	Progress SET BUTTON ENABLED($iProgress; True:C214)
	
	
	Repeat 
		
		LOAD RECORD:C52([Confirmations:153])
		
		If ([Confirmations:153]status:12=confirmationUnknown)  //nothing has been done - go to sleep
		Else 
			$iStatus:=[Confirmations:153]status:12
		End if 
		
		UNLOAD RECORD:C212([Confirmations:153])
		
		DELAY PROCESS:C323(Current process:C322; 120)  //2 seconds about
		
		$iTimeRemain:=$iTimeRemain-2
		
		If ($iTimeRemain>=0)
			Progress SET PROGRESS($iProgress; -1; "Waiting for "+String:C10($iTimeout)+" seconds(s): "+String:C10($iTimeRemain)+" remaining")
		End if 
		
		If (Progress Stopped($iProgress))
			$iStatus:=confirmationInterrupted  //create constant
		End if 
		
		
	Until (Current time:C178>$hWaitTil) | ($iStatus=confirmationDeny) | ($iStatus=confirmationApprove) | ($iStatus=confirmationInterrupted)
	
	If ($iStatus=confirmationNotFound)
		$iStatus:=confirmationTimeOut  //time out
	End if 
	
	Progress QUIT($iProgress)
	
	Case of 
		: ($iStatus=confirmationTimeOut)
			//update [confirmation] record
			$iError:=confirmationSetStatus($tID; $iStatus; getSystemUserName; confirmationGetStatusText($iStatus))
			
		: ($iStatus=confirmationInterrupted)
			//present option for teller to use confirmation code
			$iStatus:=confirmationDisplayCode($tID)
			
	End case 
	
Else 
	$iStatus:=confirmationNotFound  //-9999  //not found
End if 


$0:=$iStatus