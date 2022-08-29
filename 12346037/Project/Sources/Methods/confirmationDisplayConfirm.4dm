//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/21/20, 21:48:24
// ----------------------------------------------------
// Method: confirmationDisplayConfirm
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tID)
C_BOOLEAN:C305($2)  //dont use - this method controls this

C_LONGINT:C283($iProcess; $iWinRef)

$tID:=$1

$iProcess:=Process number:C372(Current method name:C684)


Case of 
	: ($iProcess=0)  //not found - so start it
		$iProcess:=New process:C317(Current method name:C684; 0; Current method name:C684; $tID; True:C214)
		
	: (Count parameters:C259=2)
		
		READ WRITE:C146([Confirmations:153])
		QUERY:C277([Confirmations:153]; [Confirmations:153]confirmationID:2=$tID)
		
		If (Records in selection:C76([Confirmations:153])=1)
			FORM SET INPUT:C55([Confirmations:153]; "Confirm")
			$iWinRef:=Open form window:C675([Confirmations:153]; "Confirm")
			
			MODIFY RECORD:C57([Confirmations:153]; *)
			
			CLOSE WINDOW:C154($iWinRef)
			
		End if 
		
		UNLOAD RECORD:C212([Confirmations:153])
		READ ONLY:C145([Confirmations:153])
		
	Else 
		
		BRING TO FRONT:C326($iProcess)
		
End case 