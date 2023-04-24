//%attributes = {}
C_REAL:C285(vSpotRate; vOurRate)

// Receive eWire Button
checkInit
checkifRecordExists(->[eWires:13]; ->[eWires:13]eWireID:1; ->veWireID; "eWire")
checkIfNullString(->veWireID; "Selected eWire ID")
//checkifStringsEqual ()` check if customer is the same as the invoice
checkIfAccountIDExists(->[eWires:13]AccountID:30; "Account")
checkGreaterThan(->[eWires:13]destinationAmountLocal:88; "Local Amount"; 0)
checkGreaterThan(->[eWires:13]destinationRate:87; "Our exchange rate"; 0)
checkGreaterThan(->[eWires:13]FromAmount:13; "Amount"; 0)
checkifAccountisOfCurrency([eWires:13]AccountID:30; [eWires:13]Currency:12)
// just added in the new version
checkAddErrorIf((Locked:C147([eWires:13])); "eWire Record is locked by a different user or process. Please release the record "+"before proceeding.")

//validateRatesSensibility (vCurrency;True;[eWires]sourceRate;[Currencies]OurBuyRateLocal;[Currencies]SpotRateLocal;[Currencies]OurSellRateLocal)
If (isValidationConfirmed)
	//*******OLD METHODS
	//receiveeWireForInvoice (veWireID)
	
	// reassign the register to the current invoice
	//finalizeeWireTransaction (veWireID)
	// ********* END OLD METHODS
	//QUERY([eWires];[eWires]eWireID=$1)
	//READ WRITE([eWires])
	//LOAD RECORD([eWires])  ` lock the record for modification
	[eWires:13]isSettled:23:=vbIsSettled
	
	If ([eWires:13]isSettled:23)
		[eWires:13]eWireStatus:121:=3
	End if 
	
	[eWires:13]InvoiceNumber:29:=vInvoiceNumber
	C_TEXT:C284($RegisterID; $eWireID)
	$eWireID:=[eWires:13]eWireID:1
	$RegisterID:=[eWires:13]RegisterID:24
	SAVE RECORD:C53([eWires:13])
	//UNLOAD RECORD([eWires])
	READ ONLY:C145([eWires:13])
	C_LONGINT:C283($found)
	
	//$found:=findAndReplaceString (->[Registers];->[Registers]RegisterID;$RegisterID;->[Registers]InvoiceNumber;vInvoiceNumber)
	// WE MAY NEED TO CHECK THE FIND AND REPLACE FOR RECORD LOCKING CHECKS
	
	//If ($found=0)
	//ALERT("Error occured in updating the register of eWire "+$eWireID+" [Register "+$registerID+" not found]")
	//Else 
	createRegisterOfeWire
	// MAY NEED TO BE MOVED TO TRIGGER
	//End if 
Else 
	REJECT:C38
End if 