//%attributes = {}
// createRecordAML_ReviewLog (customer; description; profileOk; clientActivityOK; clientRiskOK; signed)
// PRE: Customers record must be loaded
// getbuild

C_TEXT:C284($customerID; $1)
C_TEXT:C284($description; $2)
C_BOOLEAN:C305($isClientProfileOK; $isClientActivityOK; $isClientRiskOK; $isSigned; $3; $4; $5; $6)


Case of 
	: (Count parameters:C259=0)
		pickCustomer(->$customerID)  // pick a customer
		$description:="test"
		
	: (Count parameters:C259=1)
		$customerID:=$1
		
	: (Count parameters:C259=2)
		$customerID:=$1
		$description:=$2
		
	: (Count parameters:C259=6)
		$customerID:=$1
		$description:=$2
		$isClientProfileOK:=$3  // KYC Profile is checked
		$isClientActivityOK:=$4  // Client Activity Checked
		$isClientRiskOK:=$5  // Client Risk Checked
		$isSigned:=$6  // Client Signed
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
ASSERT:C1129($customerID#""; "Customer ID cannot be blank")

READ WRITE:C146([AML_ReviewLog:125])
CREATE RECORD:C68([AML_ReviewLog:125])
[AML_ReviewLog:125]CustomerID:2:=$customerID
[AML_ReviewLog:125]ReviewDate:3:=Current date:C33
[AML_ReviewLog:125]ReviewerID:4:=getApplicationUser
[AML_ReviewLog:125]ReviewNotes:5:=$description

[AML_ReviewLog:125]isHighRisk:10:=[Customers:3]AML_HighRisk:24
[AML_ReviewLog:125]RiskRating:11:=[Customers:3]AML_RiskRating:75
[AML_ReviewLog:125]isSuspicious:9:=[Customers:3]AML_isSuspicious:49
[AML_ReviewLog:125]isONHold:8:=[Customers:3]isOnHold:52

[AML_ReviewLog:125]isClientProfileVerified:13:=$isClientProfileOK
[AML_ReviewLog:125]isClientActivityVerified:15:=$isClientActivityOK
[AML_ReviewLog:125]isClientRiskVerified:14:=$isClientRiskOK

[AML_ReviewLog:125]isSignedByReviewer:12:=$isSigned

C_TEXT:C284($autoComment)
// 
// appendToString (->$autoComment;getFieldChangeNotes (->[Customers]isOnHold;"On Hold"))
// appendToString (->$autoComment;getFieldChangeNotes (->[Customers]AML_isSuspicious;"Suspicous"))
// appendToString (->$autoComment;getFieldChangeNotes (->[Customers]AML_RiskRating;"Risk Rating"))
appendToStringOnCondition(isFieldValueChanged(->[Customers:3]AML_HighRisk:24); ->$autoComment; "The 'Hi Risk Checkbox' set to "+getHighRiskString([Customers:3]AML_HighRisk:24); True:C214)
appendToStringOnCondition(isFieldValueChanged(->[Customers:3]AML_RiskRating:75); ->$autoComment; "Risk Index set to "+getRiskIndexString([Customers:3]AML_RiskRating:75); True:C214)
appendToStringOnCondition(isFieldValueChanged(->[Customers:3]AML_BasisOfRiskRating:106); ->$autoComment; "Basis of Risk Determination set to "+[Customers:3]AML_BasisOfRiskRating:106; True:C214)
appendToStringOnCondition(isFieldValueChanged(->[Customers:3]AML_RiskGroup:107); ->$autoComment; "Risk Group set to "+[Customers:3]AML_RiskGroup:107; True:C214)

appendToStringOnCondition(isFieldValueChanged(->[Customers:3]AML_NatureofBusRelationship:39); ->$autoComment; "Purpose and intended Nature of Business Relationship (PIN) changed to "+[Customers:3]AML_NatureofBusRelationship:39; True:C214)
appendToStringOnCondition(isFieldValueChanged(->[Customers:3]AML_POT:45); ->$autoComment; "General Purpose of Transaction set to "+[Customers:3]AML_POT:45; True:C214)
appendToStringOnCondition(isFieldValueChanged(->[Customers:3]AML_POT_EFT:105); ->$autoComment; "Purpose of Transaction for EFT set to "+[Customers:3]AML_POT_EFT:105; True:C214)
appendToStringOnCondition(isFieldValueChanged(->[Customers:3]AML_SOF_SOW:38); ->$autoComment; "Source of Fund/Wealth set to "+[Customers:3]AML_SOF_SOW:38; True:C214)

appendToStringOnCondition(isCheckBoxSwitchedOn(->[Customers:3]isOnHold:52); ->$autoComment; "Put ON hold. Reason:"+[Customers:3]AML_OnHoldNotes:127; True:C214)
appendToStringOnCondition(isCheckBoxSwitchedOn(->[Customers:3]AML_isSuspicious:49); ->$autoComment; "Flagged as Suspicious. Reason:"+[Customers:3]AML_SuspiciousNotes:125; True:C214)
appendToStringOnCondition(isCheckBoxSwitchedOff(->[Customers:3]isOnHold:52); ->$autoComment; "Taken Off hold. Reason:"+[Customers:3]AML_OnHoldNotes:127; True:C214)
appendToStringOnCondition(isCheckBoxSwitchedOff(->[Customers:3]AML_isSuspicious:49); ->$autoComment; "Customer not flagged as suspicious anymore. "+[Customers:3]AML_SuspiciousNotes:125; True:C214)


[AML_ReviewLog:125]autoRevisionNotes:16:=$autoComment

SAVE RECORD:C53([AML_ReviewLog:125])
UNLOAD RECORD:C212([AML_ReviewLog:125])
READ ONLY:C145([AML_ReviewLog:125])