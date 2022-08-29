//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/12/15, 07:56:40
// ----------------------------------------------------
// Method: geteWireStatusRemotely(eWire; security code)
// Description
//    
//     This is a web service call that will return general information about an ewire s
//     we send eWire and security code and the remote site will return the following in
//
//     Sent Date:
//     Sender Name
//     Beneficiary Name:
//     From Amount:
//     To Amount:
//     Currency
//     From Country:
//     To Country:
//     isSettled
//     Visible Remarks:
//     isFetched:
//     fetchDate:
//     fetchLocation:
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $sID)
C_TEXT:C284($2; $tSecurityCode; $tServerURL; $tXML)

C_POINTER:C301($sentDatePtr; $3)

C_POINTER:C301($sentByPtr; $4)
C_POINTER:C301($beneficiaryPtr; $5)

C_POINTER:C301($fromAmountPtr; $6)
C_POINTER:C301($toAmountPtr; $7)
C_POINTER:C301($currencyPtr; $8)

C_POINTER:C301($fromCountryPtr; $9)
C_POINTER:C301($toCountryPtr; $10)
C_POINTER:C301($isSettledPtr; $11)
C_POINTER:C301($commentsPtr; $12)

C_POINTER:C301($isFetchedPtr; $13)
C_POINTER:C301($fetchDatedPtr; $14)
C_POINTER:C301($fetchLocationPtr; $15)

C_POINTER:C301($beneficiaryAmendedPtr; $16)

C_LONGINT:C283($iError; $iField; $iTable)
C_BLOB:C604($xRecord)
Case of 
	: (Count parameters:C259=16)
		$sID:=$1
		$tSecurityCode:=$2
		$sentDatePtr:=$3
		$sentByPtr:=$4
		$beneficiaryPtr:=$5
		$fromAmountPtr:=$6
		$toAmountPtr:=$7
		$currencyPtr:=$8
		$fromCountryPtr:=$9
		$toCountryPtr:=$10
		$isSettledPtr:=$11
		$commentsPtr:=$12
		$isFetchedPtr:=$13
		$fetchDatedPtr:=$14
		$fetchLocationPtr:=$15
		$beneficiaryAmendedPtr:=$16
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$iTable:=Table:C252(->[eWires:13])
$iField:=Field:C253(->[eWires:13]eWireID:1)
$tServerURL:=<>eWireServerURL

$iError:=WS_Remote_Record_Status($iTable; $iField; $sID; ""; $tSecurityCode; $tServerURL; ->$xRecord)


Case of 
	: ($iError=0)
		
	: ($iError=-1)
		myAlert("Failed to Fetch- Security Code Incorrect")
	: ($iError=-2)
		myAlert("Failed to Fetch- eWire not found on server")
		
	: ($iError=-3)
		myAlert("Failed to Fetch- Several records with conflicting IDs found on server.")
		
	: ($iError=-20)
		myAlert("Failed to Fetch- eWire is already fetched.")
		
	Else   //unknown error
		myAlert("Failed to Fetch- Unknown Error Code.")
		
End case 


$tXML:=XB_BlobToBag($xRecord)


If (True:C214)
	$sentDatePtr->:=XB_GetDate($tXML; Field name:C257(->[eWires:13]SendDate:2))  // sent date
	$sentByPtr->:=XB_GetText($tXML; Field name:C257(->[eWires:13]SenderName:7))  // sent by
	$beneficiaryPtr->:=XB_GetText($tXML; Field name:C257(->[eWires:13]BeneficiaryFullName:5))  // beneficiary full name 
	
	$fromAmountPtr->:=XB_GetReal($tXML; Field name:C257(->[eWires:13]FromAmount:13))  // from Amount
	$toAmountPtr->:=XB_GetReal($tXML; Field name:C257(->[eWires:13]ToAmount:14))  // to Amount
	$currencyPtr->:=XB_GetText($tXML; Field name:C257(->[eWires:13]Currency:12))  // currency
	
	$fromCountryPtr->:=XB_GetText($tXML; Field name:C257(->[eWires:13]fromCountryCode:111))  // fromCountry
	$toCountryPtr->:=XB_GetText($tXML; Field name:C257(->[eWires:13]toCountryCode:112))  // toCountry
	$isSettledPtr->:=XB_GetBoolean($tXML; Field name:C257(->[eWires:13]isSettled:23))  // isSettled
	$commentsPtr->:=XB_GetText($tXML; Field name:C257(->[eWires:13]comments_Visible:48))  // comments
	
	$isFetchedPtr->:=XB_GetBoolean($tXML; Field name:C257(->[eWires:13]isLocked:79))  // isFetched
	$fetchDatedPtr->:=XB_GetDate($tXML; Field name:C257(->[eWires:13]lockedDate:80))  // fetch Date
	$fetchLocationPtr->:=XB_GetText($tXML; Field name:C257(->[eWires:13]lockedSite:83))  // fetchedSite
	
	$beneficiaryAmendedPtr->:=XB_GetText($tXML; Field name:C257(->[eWires:13]BeneficiaryAmendedName:119))  // beneficiary full name 
	
End if 