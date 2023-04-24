//%attributes = {}
//from "Programming 4D - the Ultimate Guide page 305
// Record_loaded (Pointer;{Longint};{Longint}) : Boolean
// Record_loaded (->Table;{Time-out};{Alerts}) : Loaded?
//
//This function loads a record, and tells you if it succeeded.

//Alert behavior codes are:
// 0 = Don't do anything but beep.
//   1 = Open a window and show dialog
// 2 = Show dialog

//Type parameters and their labels:


C_BOOLEAN:C305($0; $Loaded)
C_POINTER:C301($1; $Table_pointer)
C_LONGINT:C283($2; $TimeToWait)
C_LONGINT:C283($3; $AlertMethod)  // Alert methods are documented in LOCKED_ALERT.

C_TIME:C306($StartTime)

$Table_pointer:=$1

If (Count parameters:C259>=2)
	$TimeToWait:=$2
Else 
	$TimeToWait:=100  //Default time-out.
End if 

If (Count parameters:C259>3)
	$AlertMethod:=$3
Else 
	$AlertMethod:=1  //Default is to show an alert when a record cannot be loaded.
End if 

If (Is record loaded:C669($Table_pointer->))  //****IBB added 3/20/2000
	//we don't need to try and load it yet
	//if we load it we will force it to unload and reload causing it to lose any chang
Else 
	UNLOAD RECORD:C212($Table_pointer->)  // 10/20/2006 -- I. Barclay Berry
	LOAD RECORD:C52($Table_pointer->)
End if 

$Loaded:=Not:C34(Locked:C147($Table_pointer->))

If (Not:C34($Loaded))
	//The record is locked, wait for it.  
	
	$StartTime:=Current time:C178
	
	While (Locked:C147($Table_pointer->) & (Current time:C178-$StartTime<$TimeToWait))
		SET CURSOR:C469(128)
		//Delay LOAD RECORD request down to once every half second.
		DELAY PROCESS:C323(Current process:C322; 10)
		SET CURSOR:C469(129)
		DELAY PROCESS:C323(Current process:C322; 10)
		SET CURSOR:C469(130)
		DELAY PROCESS:C323(Current process:C322; 10)
		UNLOAD RECORD:C212($Table_pointer->)  // 10/20/2006 -- I. Barclay Berry
		LOAD RECORD:C52($Table_pointer->)
		SET CURSOR:C469(131)
		
	End while 
	
	$Loaded:=Not:C34(Locked:C147($Table_pointer->))
	
End if   // (Not($Loaded))

If (Not:C34($Loaded))
	//The record is still locked by another process.  Call the alert system,.
	//and pass the desired alert behavior.
	//LOCKED_ALERT($Table_pointer;$AlertMethod)
End if 

SET CURSOR:C469
$0:=$Loaded
