//%attributes = {}
checkInit
// getbuild
validateCustomers(True:C214)  // it's during a review

If ([Customers:3]isOnHold:52)
	checkIfNullString(->[Customers:3]AML_OnHoldNotes:127; "Reason why Customer is put on Hold")
End if 

If ([Customers:3]AML_isSuspicious:49)
	checkIfNullString(->[Customers:3]AML_SuspiciousNotes:125; "Reason why customer is Suspicious")
End if 

If ([Customers:3]AML_ignoreKYC:35)
	checkIfNullString(->[Customers:3]AML_omitKYCNotes:128; "Reason for 'Omit KYC Checks'")
End if 

If ([Customers:3]AML_isWhitelisted:131)
	checkIfNullString(->[Customers:3]AML_WhitelistNotes:126; "Reason for whitelisting customer")
	checkIfDateIsAfter(->[Customers:3]AML_WhitelistExpiryDate:130; True:C214; Current date:C33; "Whitelist Expiry Date")
End if 

If ([Customers:3]AML_isMatchFalsePositive:93)
	checkIfNullString(->[Customers:3]AML_falsePositiveNotes:129; "False Positive Notes")
End if 

If ([Customers:3]AML_isInBusinessRelation:115=1)  // 1: established
	checkIfDateIsFilled(->[Customers:3]AML_BusinessRelationStarted:119; True:C214; "Date of start of Busines Relationship")
	checkIfNullString(->[Customers:3]AML_NatureofBusRelationship:39; "Purpose and Intended Nature of Business Relationship (PIN)")
End if 



//C_POINTER($reviewNotesPtr)
//$reviewNotesPtr:=OBJECT Get pointer(Object named;"reviewNotes")
C_TEXT:C284(VDESCRIPTION)
checkIfNullString(->VDESCRIPTION; "Review Notes")

C_BOOLEAN:C305($isProfileOK; $isActivityOK; $isRiskOK; $isSigned; $allChecked)
$isProfileOK:=numToBoolean(OBJECT Get pointer:C1124(Object named:K67:5; "cb_verifiedClientProfile")->)
$isActivityOK:=numToBoolean(OBJECT Get pointer:C1124(Object named:K67:5; "cb_verifiedClientActivity")->)
$isRiskOK:=numToBoolean(OBJECT Get pointer:C1124(Object named:K67:5; "cb_verifiedClientRisk")->)
$isSigned:=numToBoolean(OBJECT Get pointer:C1124(Object named:K67:5; "cb_Signed")->)

$allChecked:=$isProfileOK | $isActivityOK | $isRiskOK
checkAddErrorIf(Not:C34($allChecked); "You need to verify either Profile, Activity, or Customer Risk")

checkAddErrorIf(Not:C34($isSigned); "You need to accept the disclaimer and sign the review!")