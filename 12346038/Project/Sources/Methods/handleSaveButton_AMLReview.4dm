//%attributes = {}
// validateCustomerKYC
//validateCustomers
// getBuild

C_BOOLEAN:C305($isProfileOK; $isActivityOK; $isRiskOK; $isSigned)
C_TEXT:C284(VDESCRIPTION)

validateCustomers_AMLReview

//If (OK=1)
If (isValidationConfirmed)
	$isProfileOK:=numToBoolean((OBJECT Get pointer:C1124(Object named:K67:5; "cb_verifiedClientProfile"))->)  // get the pointer 
	$isActivityOK:=numToBoolean((OBJECT Get pointer:C1124(Object named:K67:5; "cb_verifiedClientActivity"))->)
	$isRiskOK:=numToBoolean((OBJECT Get pointer:C1124(Object named:K67:5; "cb_verifiedClientRisk"))->)
	$isSigned:=numToBoolean((OBJECT Get pointer:C1124(Object named:K67:5; "cb_signed"))->)
	
	[Customers:3]LastAMLReviewDate:123:=Current date:C33
	createRecordAML_ReviewLog([Customers:3]CustomerID:1; VDESCRIPTION; $isProfileOK; $isActivityOK; $isRiskOK; $isSigned)
	SAVE RECORD:C53([Customers:3])  // customer record needs to be saved. 
Else 
	REJECT:C38
End if 