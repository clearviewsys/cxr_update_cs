//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/26/19, 15:26:07
// ----------------------------------------------------
// Method: webOnChange_WebEwires
// Description
//
//
// Parameters
// ----------------------------------------------------





C_TEXT:C284($1; $tFormName)
C_TEXT:C284($2; $tEvent)
C_TEXT:C284($3; $tSource)
C_TEXT:C284($4; $tSourceType)
C_POINTER:C301($5; $ptrNameArray)
C_POINTER:C301($6; $ptrValueArray)


C_TEXT:C284($0)

C_TEXT:C284($tContext; $tSecurityCode; $tToCCY; $tFromCCY; $tContext; $tClass; $tLinkID; $tSelect; $tReceipt)
C_TEXT:C284($tBankName; $tToName; $tSanctionCheck)
C_TEXT:C284($mop; $tCust; $tGroup; $tDoTransfer)
C_LONGINT:C283($iElem)
C_REAL:C285($rDirectRate; $rFromAmount; $rFromFee; $rDiscount)

C_TEXT:C284($tValue; $tCurrCode; $tAccountID; $tCountryCode; $tCurrFromCode; $tCustomerID)
C_TEXT:C284($tEvent; $tName; $tOrigCurrCode; $tOrigCurrFromCode; $tRateNotes; $tResult)

C_BOOLEAN:C305($bRefresh; $isSell; $bQuery; $updateRates)
C_REAL:C285($rAmt; $rFee; $rFromAmtTotal; $rInverseRate; $rSourceRate; $rSourceServiceFeeLocal; $rToAmount)
C_PICTURE:C286($picStatus)
C_DATE:C307($dDOB)
C_OBJECT:C1216($o)



$tFormName:=$1
$tEvent:=$2
$tSource:=$3
$tSourceType:=$4
$ptrNameArray:=$5
$ptrValueArray:=$6

$tResult:=""
$tReceipt:=""
$bRefresh:=False:C215

$tContext:=WAPI_getSession("context")

READ ONLY:C145(*)

Case of 
	: ($tContext="agents")
		webSelectAgentRecord
		
	: ($tContext="customers")
		webSelectCustomerRecord
		$tCustomerID:=[Customers:3]CustomerID:1
		
	Else 
		
End case 


//---------GET INITIAL VALUES SET IN FORM ----------
If (True:C214)
	// THESE ARE HIDDEN FIELDS WE USE TO STORE THE CURRENCY SELECTED
	$tToCCY:=WAPI_getInputValue(->[Invoices:5]toCurrency:8)
	$tFromCCY:=WAPI_getInputValue(->[Invoices:5]fromCurrency:3)
	
	$rToAmount:=Num:C11(WAPI_getInputValue(->[Invoices:5]toAmount:26))
	$rFromAmount:=Num:C11(WAPI_getInputValue(->[Invoices:5]fromAmount:25))
	$rFromFee:=Num:C11(WAPI_getInputValue(->[Invoices:5]feeLocal:6))
	
	$tCustomerID:=WAPI_getInputValue(->[Invoices:5]CustomerID:2)
End if 



//---------- ON LOAD phase ---------
If ($tEvent="DOMContentLoaded") | ($tEvent="readystatechange") | ($tEvent="onload")
	
	Case of 
		: ($tContext="customers")
			$bRefresh:=True:C214
			
		: ($tContext="agents")
			
		Else 
			
	End case 
	
End if 


If ($bRefresh)
	
	If (WAPI_isDebug)  //show all decimal places
		WAPI_pushDOMValue(WAPI_getInputControlID(->[Invoices:5]toAmount:26); String:C10($rToAmount))
		WAPI_pushDOMValue(WAPI_getInputControlID(->[Invoices:5]fromAmount:25); String:C10($rFromAmount))
		WAPI_pushDOMValue(WAPI_getInputControlID(->[Invoices:5]feeLocal:6); String:C10($rFromFee))
		//WAPI_pushDOMHTML ("destination-tab-status";"["+String($rToAmount)+"]")
	Else 
		WAPI_pushDOMValue(WAPI_getInputControlID(->[Invoices:5]toAmount:26); String:C10($rToAmount; "###############0.00"))
		WAPI_pushDOMValue(WAPI_getInputControlID(->[Invoices:5]fromAmount:25); String:C10($rFromAmount; "###############0.00"))
		WAPI_pushDOMValue(WAPI_getInputControlID(->[Invoices:5]feeLocal:6); String:C10($rFromFee; "###############0.00"))
		//WAPI_pushDOMHTML ("destination-tab-status";"["+String($rToAmount;"###,###,##0.00")+"]")
	End if 
	
	WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[Invoices:5]fromAmount:25); $tFromCCY)
	WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[Invoices:5]toAmount:26); $tToCCY)
	WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[Invoices:5]feeLocal:6); $tFromCCY)
	
	WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[Invoices:5]fromAmount:25); webGetFlag_Currency($tFromCCY))
	WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[Invoices:5]toAmount:26); webGetFlag_Currency($tToCCY))
	WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[Invoices:5]feeLocal:6); webGetFlag_Currency($tFromCCY))  //send image
	
End if 


$0:=WAPI_pullJsStack

