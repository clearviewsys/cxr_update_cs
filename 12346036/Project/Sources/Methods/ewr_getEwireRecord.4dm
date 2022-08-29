//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/21/15, 08:13:23
// ----------------------------------------------------
// Method: ewr_retreiveEwire
// Description
// 
//     ERRORS 
//          1 = Fail security
//          2 = Fail - record not found
//          3 = Fail - multiple records found
//          4 = Fail - 
//          5 = Fail - record is locked
//          6 = Fail - unknown error
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $sEwireID)
C_TEXT:C284($1; $sChallenge)

C_LONGINT:C283($0; $iError)



$iError:=0

If (Count parameters:C259>=1)
	$sEwireID:=$1
Else 
	$sEwireID:=Request:C163("Enter the eWire ID.")
End if 

If (Count parameters:C259>=2)
	$sChallenge:=$2
Else 
	If ($sEwireID="")
	Else 
		$sChallenge:=Request:C163("Answer the challenge question here.")
	End if 
End if 


Case of 
	: ($sChallenge="")
		//must have challenge question answer
	: ($sEwireID="")
		//must have eWire ID
	Else 
		
		$iError:=WS_Remote_Record_Load(Table:C252(->[eWires:13]); Field:C253(->[eWires:13]eWireID:1); $sEwireID; <>branchPrefix; $sChallenge; <>eWireServerURL)
		
End case 


If ($iError=0)
Else 
	//ALERT(String($iError)+" error.")
End if 

$0:=$iError