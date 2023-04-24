//%attributes = {"shared":true,"executedOnServer":true}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 01/28/20, 21:19:54
// ----------------------------------------------------
// Method: getSystemUserName
// Description
// 
//
// Parameters
// ----------------------------------------------------



//---------- NEED TO HANDLE STANDALONE ------------
// THIS IS SET TO EXECUTE ON SERVER WHEN ON STANDALONE DON'T GET USERNAME

C_TEXT:C284($0)

C_TEXT:C284($tProcessName; $name)
C_LONGINT:C283($iProcess)

//TRACE

Case of 
	: (Application type:C494=4D Local mode:K5:1) & (Current user:C182#"designer")
		$name:=getApplicationUser
	: (Application type:C494=4D Local mode:K5:1) & (Current user:C182="designer")
		$name:=getCurrentMachineName
	: (Application type:C494=4D Remote mode:K5:5) & (Current user:C182#"designer")
		$name:=getApplicationUser
	: (Application type:C494=4D Remote mode:K5:5) & (Current user:C182="designer")
		$name:=getCurrentMachineName
	: (Sync_IsSyncProcess)
		$name:="SYNC"  // + ":"+ SYNC_requestOrigin
		
	Else   //this is a trigger or on server - better than nothing
		//TRACE
		//$tProcessName:=Current process name
		$iProcess:=Current process:C322
		
		C_OBJECT:C1216($result)
		C_COLLECTION:C1488($process)
		C_COLLECTION:C1488($processes)
		$result:=Get process activity:C1495
		$processes:=OB Get:C1224($result; "processes")
		
		$process:=$processes.query("number = :1"; $iProcess)
		
		$name:=$process[0].session.systemUserName
End case 

$0:=$name