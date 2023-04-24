//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/21/20, 20:53:43
// ----------------------------------------------------
// Method: confirmationGetStatusText
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1; $iStatus)

C_TEXT:C284($0; $tStatus)


$iStatus:=$1
$tStatus:="UNKNOWN"


Case of 
	: ($iStatus=confirmationUnknown)
		$tStatus:="NOT REVIEWED"
		
	: ($iStatus=confirmationApprove)
		$tStatus:="APPROVED"
		
	: ($iStatus=confirmationDeny)
		$tStatus:="DENIED"
		
	: ($iStatus=confirmationTimeOut)
		$tStatus:="TIMEOUT-NO RESPONSE"
		
	: ($iStatus=confirmationNotFound)
		$tStatus:="RECORD NOT FOUND"
		
	: ($iStatus=confirmationInterrupted)
		$tStatus:="INTERRUPTED BY USER"
		
	Else 
		
End case 


$0:=$tStatus