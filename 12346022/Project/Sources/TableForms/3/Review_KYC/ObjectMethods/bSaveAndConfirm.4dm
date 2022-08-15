// Save and Confirm

C_POINTER:C301($cbCompanyPtr; $cbContactPtr; $cbAddressPtr; $cbPictureIDPtr; $cbSignedPtr)
C_POINTER:C301($notesPtr)
C_BOOLEAN:C305($allOK; $skipped)
If (Form event code:C388=On Clicked:K2:4)
	$notesPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "Description")
	$cbCompanyPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "cbCompanyOK")
	$cbContactPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "cbContactOK")
	$cbAddressPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "cbAddressOK")
	$cbPictureIDPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "cbPictureIDOK")
	$cbSignedPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "cbSigned")  // signed 
	
	$allOK:=($cbCompanyPtr->=1) & ($cbContactPtr->=1) & ($cbAddressPtr->=1) & ($cbPictureIDPtr->=1)
	$skipped:=($cbCompanyPtr->=0) | ($cbContactPtr->=0) | ($cbAddressPtr->=0) | ($cbPictureIDPtr->=0)
	
	checkInit
	validateCustomers(True:C214)
	If (($allOK=False:C215) & ($notesPtr->=""))
		checkIfNullString($notesPtr; "Review Notes")
	End if   //If (OK=1)
	
	
	checkAddErrorIf($skipped; "Make sure all sections are checked (either reviewed or not availabe)")
	
	If (isValidationConfirmed)
		[Customers:3]ReviewDate:97:=Current date:C33
		[Customers:3]ReviewedByUser:98:=getApplicationUser
		createRecordKYC_ReviewLog([Customers:3]CustomerID:1; $notesPtr->; $cbCompanyPtr->; $cbContactPtr->; $cbPictureIDPtr->; $cbAddressPtr->; $cbSignedPtr->)
		SAVE RECORD:C53([Customers:3])  // customer record needs to be saved. 
	Else 
		REJECT:C38
	End if 
End if 
applyFocusRect("focusRect2")
