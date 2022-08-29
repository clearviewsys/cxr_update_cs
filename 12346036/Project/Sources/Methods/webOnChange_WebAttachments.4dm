//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/16/18, 10:45:46
// ----------------------------------------------------
// Method: webFormOnChange_Ewires
// Description
//    AGENT - is Selling Currency

// look at rate for 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tFormName)
C_TEXT:C284($2; $tEvent)
C_TEXT:C284($3; $tSource)
C_TEXT:C284($4; $tSourceType)
C_POINTER:C301($5; $ptrNameArray)
C_POINTER:C301($6; $ptrValueArray)


C_TEXT:C284($0; $tResult)

C_TEXT:C284($tValue; $tCurrCode; $tAccountID; $tCountryCode; $tCurrFromCode; $tCustomerID)
C_TEXT:C284($tEvent; $tName; $tOrigCurrCode; $tOrigCurrFromCode; $tRateNotes; $tResult)
C_TEXT:C284($tSecurityCode)
C_LONGINT:C283($iElem)
C_BOOLEAN:C305($bRefresh; $isSell; $bQuery)
C_REAL:C285($rAmt; $rFee; $rFromAmtTotal; $rInverseRate; $rSourceRate; $rSourceServiceFeeLocal; $rToAmount)
C_PICTURE:C286($picStatus)
C_DATE:C307($dDOB)


$tFormName:=$1
$tEvent:=$2
$tSource:=$3
$tSourceType:=$4
$ptrNameArray:=$5
$ptrValueArray:=$6

$tResult:=""
$bRefresh:=False:C215

READ ONLY:C145(*)

Case of 
	: (webContext="agents")
		webSelectAgentRecord
		
	: (webContext="customers")
		webSelectCustomerRecord
		
		$iElem:=Find in array:C230($ptrNameArray->; "customers___customerid")
		If ($iElem>0)
			$tCustomerID:=$ptrValueArray->{$iElem}
		Else 
			$tCustomerID:=""
		End if 
		
	Else 
		
End case 



Case of 
		
	: ($tFormName="ewires-form-settle")
		
		$tSecurityCode:=WAPI_getInputValue(->[eWires:13]securityChallengeCode:75)  //;$ptrNameArray;$ptrValueArray)
		
		If ($tSecurityCode=[eWires:13]securityChallengeCode:75)  //a match
			//set the "ERROR" code to success
			WAPI_pushDOMError(WAPI_getInputControlID(->[eWires:13]securityChallengeCode:75); "SUCCESS"; "text-success")
			
			//---------------- MARKED AS SETTLED CHECKBOX ----------------------
			$iElem:=Find in array:C230($ptrNameArray->; WAPI_getInputControlID(->[eWires:13]isSettled:23))
			If ($iElem>0)
				If ($ptrValueArray->{$iElem}="on")
					WAPI_pushDOMAttribute("submit-input"; "disabled"; "")  //pass no value to remove the attribute
				Else 
					WAPI_pushDOMAttribute("submit-input"; "disabled"; "disabled")
				End if 
			Else 
				WAPI_pushDOMAttribute("submit-input"; "disabled"; "disabled")
			End if 
			
		Else 
			WAPI_pushDOMError(WAPI_getInputControlID(->[eWires:13]securityChallengeCode:75); "ERROR - Security Code Does NOT Match"; "text-danger")
			WAPI_pushDOMAttribute("submit-input"; "disabled"; "disabled")
		End if 
		
		
		
		
		
		
	: ($tFormName="ewires-form-create") | ($tFormName="ewires-form-update")  // ---- GET INITIAL VALUES ALREADY SET IN THE FORM -----
		
		// THESE ARE HIDDEN FIELDS WE USE TO STORE THE CURRENCY SELECTED
		$tOrigCurrCode:=WAPI_getInputValue(->[eWires:13]Currency:12)  //;$ptrNameArray;$ptrValueArray)
		$tOrigCurrFromCode:=WAPI_getInputValue(->[eWires:13]FromCurrency:11)  //;$ptrNameArray;$ptrValueArray)
		$tCurrCode:=$tOrigCurrCode
		$tCurrFromCode:=$tOrigCurrFromCode
		$rSourceRate:=Num:C11(WAPI_getInputValue(->[eWires:13]sourceRate:41))  //;$ptrNameArray;$ptrValueArray))
		
		$iElem:=Find in array:C230($ptrNameArray->; WAPI_getInputControlID(->[eWires:13]sourceRate:41)+"-inverse")
		If ($iElem>0)
			$rInverseRate:=Num:C11($ptrValueArray->{$iElem})
		End if 
		
		If ($rInverseRate=0)
			$rInverseRate:=Round:C94(1/$rSourceRate; 5)
		End if 
		
		$rToAmount:=Num:C11(WAPI_getInputValue(->[eWires:13]ToAmount:14))  //;$ptrNameArray;$ptrValueArray))  // this is the sending amount - destination - need to calc the source amt
		$rSourceServiceFeeLocal:=Num:C11(WAPI_getInputValue(->[eWires:13]sourceServicefeeLocal:44))  //;$ptrNameArray;$ptrValueArray))  //Manual entry by agent
		
		$tName:=WAPI_getInputValue(->[eWires:13]BeneficiaryFullName:5)  //;$ptrNameArray)  //;$ptrValueArray)
		$tCustomerID:=WAPI_getInputValue(->[eWires:13]CustomerID:15)  //;$ptrNameArray;$ptrValueArray)
		
		
	: ($tFormName="ewires-form-update")  //see above
		
		
End case 


If ($tEvent="onload")  //---------- ON LOAD phase ---------
	
	
End if 




Case of 
	: ($tSource=WAPI_getInputControlID(->[WebAttachments:86]CXRType:8)) | ($tSource="rateRefresh") | ($tEvent="onload")  // ---------------------  ---
		
	: ($tSource=WAPI_getInputControlID(->[WebAttachments:86]CXRType:8))  // -------------------------  ---
		
	Else 
		
End case 



If (True:C214)  //---------------- SUBMIT BUTTON AND AGFEEMENT CHECKBOX ----------------------
	If ($tSource="agreement-input")  //| ($bOnLoad)  //checkbox to agree to conditions
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				WAPI_pushDOMAttribute("submit-input"; "disabled"; "")  //pass no value to remove the attribute
			Else 
				WAPI_pushDOMAttribute("submit-input"; "disabled"; "disabled")
			End if 
		Else 
			WAPI_pushDOMAttribute("submit-input"; "disabled"; "disabled")
		End if 
	End if 
End if 



$0:=WAPI_pullJsStack  //$tResult

