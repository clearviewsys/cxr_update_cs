//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 07/16/13, 23:10:22
// ----------------------------------------------------
// Method: display_eWireRemoteRecords
// Description
// 
//
// Parameters
// ----------------------------------------------------




C_BOOLEAN:C305($1)  //just to indicate a new process
C_TEXT:C284($sProcessName; $sFormName)
C_LONGINT:C283($iProcess)


//We use a dummy parameter to indicate that we want to run the method, not start a
//process. When called from the menubar it will start the process.

$sProcessName:="eWire Remote List"
$sFormName:="eWireRemoteList"

$iProcess:=Process number:C372($sProcessName)

Case of 
	: ($iProcess=0)
		C_LONGINT:C283($pid)
		
		$pid:=New process:C317(Current method name:C684; 0; $sProcessName; True:C214; *)  // changed by BARCLAY's instruction on Jan 19, 2014
		
		BRING TO FRONT:C326($pid)
		
		
	: (Count parameters:C259=1)  //this is a new process so init
		
		//*** change to run in own process
		If (isUserAllowedToViewAgentPanel)
			SET MENU BAR:C67(1)
			C_LONGINT:C283($winRef)
			$winRef:=openFormWindow(->[eWires:13]; $sFormName)
		Else 
			myAlert("Sorry you are not authorized to access this panel. Ask the Administrator to grant you access.")
		End if 
		
	Else   //this is existing so update
		BRING TO FRONT:C326($iProcess)
End case 
