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
//C_BOOLEAN($2)  //dont use - this method controls this
C_LONGINT:C283($0; $iStatus)

C_LONGINT:C283($iWinRef)


$tID:=$1

//$iProcess:=Process number(Current method name)


//Case of 
//: ($iProcess=0)  //not found - so start it
//$iProcess:=New process(Current method name;0;Current method name;$tID;True)

//: (Count parameters=2)

READ ONLY:C145([Confirmations:153])
QUERY:C277([Confirmations:153]; [Confirmations:153]confirmationID:2=$tID)

If (Records in selection:C76([Confirmations:153])=1)  //<>TODO test for locked
	
	//FORM SET INPUT([Confirmations];"ConfirmCode")
	$iWinRef:=Open form window:C675([Confirmations:153]; "ConfirmCode")
	
	DIALOG:C40([Confirmations:153]; "ConfirmCode")
	
	CLOSE WINDOW:C154($iWinRef)
	
End if 


//Else 

//BRING TO FRONT($iProcess)

//End case 
LOAD RECORD:C52([Confirmations:153])  //refresh the values
$iStatus:=[Confirmations:153]status:12
UNLOAD RECORD:C212([Confirmations:153])
READ ONLY:C145([Confirmations:153])

$0:=$iStatus