//%attributes = {}
HandleEntryForm(Current form table:C627; ->[Customers:3]CreatedByUserID:58; ->[Customers:3]ModifiedByUserID:59; ->[Customers:3]BranchID:86; ->[Customers:3]modBranchID:111)

C_POINTER:C301($cbCompanyPtr; $cbContactPtr; $cbAddressPtr; $cbPictureIDPtr; $cbSignedPtr)
C_POINTER:C301($notesPtr)
C_BOOLEAN:C305($allOK; $skipped; $isSigned)

$notesPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "Description")
$cbCompanyPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "cbCompanyOK")
$cbContactPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "cbContactOK")
$cbAddressPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "cbAddressOK")
$cbPictureIDPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "cbPictureIDOK")
$cbSignedPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "cbSigned")

C_BOOLEAN:C305($cond)
$allOK:=($cbCompanyPtr->=1) & ($cbContactPtr->=1) & ($cbAddressPtr->=1) & ($cbPictureIDPtr->=1)
$skipped:=($cbCompanyPtr->=0) | ($cbContactPtr->=0) | ($cbAddressPtr->=0) | ($cbPictureIDPtr->=0)

If (Form event code:C388=On Load:K2:1)
	UNLOAD RECORD:C212([KYC_ReviewLog:124])  // we don't want any values in the fields
	
	highlightMissingFieldsInCustKYC
	relateMany(->[KYC_ReviewLog:124]; ->[KYC_ReviewLog:124]CustomerID:2; ->[Customers:3]CustomerID:1)
	
	
End if 


If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4))
	checkInit
	validateCustomerKYC(True:C214)
	//vErrorAndWarnings:=checkGetErrorString+checkGetWarningString
	C_BOOLEAN:C305($preSigned)
	$preSigned:=(Not:C34(checkErrorExist) & $allOK & (Not:C34(checkWarningExist)))
	$isSigned:=($cbSignedPtr->=1)
	setVisibleIff($preSigned; "cbSigned")
	
	stampText("stamp_OK"; "Review 100% ✔"; "green"; $isSigned & $preSigned)
	handleCustomerRedFlagSigns
	
	If ((checkErrorExist) | (checkWarningExist))
		OBJECT SET TITLE:C194(*; "errorMessage"; <>CHECKERRORS+CRLF+<>CHECKWARNINGS)
	Else 
		OBJECT SET TITLE:C194(*; "errorMessage"; "")
	End if 
End if 

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	highlightMissingFieldsInCustKYC
	VPROGRESSBAR:=Num:C11($cbCompanyPtr->=1)+Num:C11($cbContactPtr->=1)+Num:C11($cbAddressPtr->=1)+Num:C11($cbPictureIDPtr->=1)+Num:C11($cbSignedPtr->=1)
	// [Customers];"View"
End if 

