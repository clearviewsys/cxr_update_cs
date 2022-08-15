//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/17/20, 18:34:17
// ----------------------------------------------------
// Method: confirmationCreateEmail
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $tID)
C_TEXT:C284($2; $tTo)

C_LONGINT:C283($0; $iError)


C_TEXT:C284($tBody)

If (Count parameters:C259>=1)
	$tID:=$1
Else 
	$tID:=""
End if 

If (Count parameters:C259>=2)
	$tTo:=$2
Else 
	$tTo:="barclay"
End if 

If ([Confirmations:153]confirmationID:2=$tID)  //we have the correct record
Else 
	READ ONLY:C145([Confirmations:153])
	QUERY:C277([Confirmations:153]; [Confirmations:153]confirmationID:2=$tID)
End if 

If ([Confirmations:153]confirmationID:2=$tID)  // (Records in selection([Confirmations])=1)
	
	$tBody:="Please accept of deny this request"+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
	
	$iError:=iH_Notify_Client($tTo; [Confirmations:153]confirmationSubject:16; $tBody; -1; iH_createLinkMethod("Review Confirmation"; "confirmationDisplayConfirm"; $tID))
	
	If ($iError=0)
	Else 
		$iError:=-8  //confirmationSendHolaFailed
	End if 
Else 
	$iError:=confirmationNotFound  //confirmation not found
End if 


$0:=$iError

