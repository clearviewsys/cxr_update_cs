//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 09/03/19, 12:40:51
// ----------------------------------------------------
// Method: getRegisteredUserID
// Description
// 
//   used primarily for iH_Notify and iM_Chat....

// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)

Case of 
	: (Current user:C182="designer")
		$0:=Current user:C182+"|"+Current system user:C484
		
	: (Current user:C182="administrator")
		$0:=Current user:C182+"|"+Current system user:C484
	Else 
		$0:=<>USERID
End case 