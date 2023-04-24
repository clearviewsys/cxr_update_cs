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
C_TEXT:C284($tBankName; $tToName; $tSanctionCheck; $delCode)
C_TEXT:C284($mop; $tCust; $tGroup; $tDoTransfer; $tDeliveryMOP; $placeholder)
C_LONGINT:C283($iElem; $i)
C_REAL:C285($rDirectRate; $rFromAmount; $rFromFee; $rDiscount)

C_TEXT:C284($tValue; $tCurrCode; $tAccountID; $tCountryCode; $tCurrFromCode; $tCustomerID)
C_TEXT:C284($tEvent; $tName; $tOrigCurrCode; $tOrigCurrFromCode; $tRateNotes; $tResult)
C_TEXT:C284($toMOP; $specificID; $groupName; $payMethod; $key)

C_BOOLEAN:C305($bRefresh; $isSell; $bQuery; $updateRates; $isBank; $isCash; $isMobileWallet)
C_REAL:C285($rAmt; $rFee; $rFromAmtTotal; $rInverseRate; $rSourceRate; $rSourceServiceFeeLocal; $rToAmount)
C_PICTURE:C286($picStatus)
C_DATE:C307($dDOB)
C_LONGINT:C283($maxLength)
C_TEXT:C284($help; $prop; $name; $div; $pattern; $title; $value)

C_COLLECTION:C1488($col)
C_OBJECT:C1216($o; $status; $request)
C_OBJECT:C1216($customer; $mg; $transaction; $deliveryOption; $required)


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
		
	: ($tContext="users")
		
	Else 
		
End case 



//---------GET INITIAL VALUES SET IN FORM ----------
If (True:C214)
	
	$status:=WAPI_sessionGet("request")  // have we started a request yet
	If ($status.success)
		$request:=$status.value
	Else 
		$request:=New object:C1471
		$request.isQuote:=False:C215
	End if 
	
	If ($request.isQuote=Null:C1517)
		$request.isQuote:=False:C215
	End if 
	
	If ($request.mgTransaction=Null:C1517)
		$transaction:=New object:C1471
		$request.mgTransaction:=$transaction
	Else 
		$transaction:=$request.mgTransaction
	End if 
	
	WAPI_inputId2Entity(->$request; $tSource)
	
	
	Case of 
		: ($tFormName="webewires-form-settle")  //<>TODO
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
			
			
			
		: ($tFormName="webewires-form@") | ($tFormName="modal-form")  // ---- GET INITIAL VALUES ALREADY SET IN THE FORM -----
			
			If ($request.isQuote)
				$tToCCY:=$request.toCCY
				$tFromCCY:=$request.fromCCY
				$rDirectRate:=$request.directRate
				$rInverseRate:=$request.inverseRate
				$rToAmount:=$request.toAmount
				$rFromAmount:=$request.fromAmount
				$rFromFee:=$request.fromFee
				$tCustomerID:=$request.CustomerID
				$payMethod:=$request.paymentInfo.paymentMethod
				$toMOP:=$request.AML_Info[AML_toMOPCode]
				$tDeliveryMOP:=$request.AML_Info[AML_toMOPCode]
				
			Else 
				// THESE ARE HIDDEN FIELDS WE USE TO STORE THE CURRENCY SELECTED
				$tToCCY:=WAPI_getInputValue(->[WebEWires:149]toCCY:11)
				$tFromCCY:=WAPI_getInputValue(->[WebEWires:149]fromCCY:5)
				$rDirectRate:=Num:C11(WAPI_getInputValue(->[WebEWires:149]directRate:13))
				$rInverseRate:=Num:C11(WAPI_getInputValue(->[WebEWires:149]inverseRate:14))
				$rToAmount:=Num:C11(WAPI_getInputValue(->[WebEWires:149]toAmount:10))
				$rFromAmount:=Num:C11(WAPI_getParameter("webewires-amount-input"))
				If ($rFromAmount=0)  //check to see if we have the field
					$rFromAmount:=Num:C11(WAPI_getInputValue(->[WebEWires:149]fromAmount:3))
				End if 
				$rFromFee:=Num:C11(WAPI_getInputValue(->[WebEWires:149]fromFee:6))
				
				$tCustomerID:=WAPI_getInputValue(->[WebEWires:149]CustomerID:21)
				$tLinkID:=WAPI_getInputValue(->[WebEWires:149]LinkID:25)
				
				$tToName:=WAPI_getInputValue(->[WebEWires:149]toParty:8; Info_FullName)
				$tBankName:=WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_Name)
				$tDoTransfer:=WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_doTransferToBank)
				
				$payMethod:=WAPI_getInputValue(->[WebEWires:149]paymentInfo:35; "paymentMethod")
				
				$toMOP:=WAPI_getInputValue(->[WebEWires:149]AML_Info:9; AML_toMOPCode)
				$tDeliveryMOP:=WAPI_getInputValue(->[WebEWires:149]AML_Info:9; AML_toMOPCode)
				
				$tSanctionCheck:=WAPI_getParameter("sanction-check")
				If ($tSanctionCheck="")
					$tSanctionCheck:="true"
				End if 
				
				$request.LinkID:=$tLinkID
				$request.directRate:=$rDirectRate
				$request.inverseRate:=$rInverseRate
				$request.toCCY:=$tToCCY
				$request.fromCCY:=$tFromCCY
				$request.toAmount:=$rToAmount
				$request.fromAmount:=$rFromAmount
				$request.fromFee:=$rFromFee
				$request.AML_Info[AML_toMOPCode]:=$toMOP
				$request.paymentInfo.paymentMethod:=$payMethod
			End if 
			
	End case 
End if 





//---------- ON LOAD phase ---------
Case of 
	: ($tEvent="DOMContentLoaded") | ($tEvent="readystatechange") | ($tEvent="onload")
		
		Case of 
			: ($tContext="agents")
				
				$tClass:=webGetSanctionListClass(Table:C252(->[Links:17]); [Links:17]LinkID:1; makeFullName([Links:17]FirstName:2; [Links:17]LastName:3))
				WAPI_pushDOMClass("customer-tab-status"; $tClass)  //SENDER PARTY
				
				If ([WebEWires:149]CustomerID:21="")
				Else 
					QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[WebEWires:149]CustomerID:21)
					$tClass:=webGetSanctionListClass(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4))
					WAPI_pushDOMClass("beneficiary-tab-status"; $tClass)
					WAPI_pushDOMHTML("beneficiary-tab-status"; "["+[Customers:3]FullName:40+"]")
				End if 
				
				If ($tFormName="webewires-form-update")
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]CustomerID:21); "disabled"; "disabled")
				End if 
				
				$bRefresh:=True:C214
				
				
			: ($tContext="customers")
				
				$tLinkID:=WAPI_getInputValue(->[WebEWires:149]LinkID:25)
				If ($tLinkID=[Links:17]LinkID:1)
				Else 
					QUERY:C277([Links:17]; [Links:17]LinkID:1=$tLinkID; *)
					QUERY:C277([Links:17];  & ; [Links:17]CustomerID:14=$tCustomerID)
				End if 
				
				WAPI_pushDOMHTML("beneficiary-tab-status"; "["+[Links:17]FullName:4+"]")
				
				If ($tSanctionCheck="true")
					$tClass:=webGetSanctionListClass(Table:C252(->[Links:17]); [Links:17]LinkID:1; makeFullName([Links:17]FirstName:2; [Links:17]LastName:3))
					WAPI_pushDOMClass("beneficiary-tab-status"; $tClass)
					$tClass:=webGetSanctionListClass(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4))
					WAPI_pushDOMClass("customer-tab-status"; $tClass)
				End if 
				
				WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[WebEWires:149]directRate:13); $tToCCY+"/"+$tFromCCY)
				WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[WebEWires:149]inverseRate:14); $tFromCCY+"/"+$tToCCY)
				WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[WebEWires:149]toAmount:10); $tToCCY)
				WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[WebEWires:149]fromFee:6); $tFromCCY)
				WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[WebEWires:149]fromAmount:3); webGetFlag_Currency($tFromCCY))
				WAPI_pushDOMImgSrc("webewires-amount-addon-pre"; webGetFlag_Currency($tFromCCY))
				WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[WebEWires:149]toAmount:10); webGetFlag_Currency($tToCCY))
				WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[WebEWires:149]fromFee:6); webGetFlag_Currency($tFromCCY))  //send image
				
				Case of 
					: ($tDeliveryMOP="D")  //cash -- leave as is
						// -- GET PICKUP LOCATIONS 
						$help:=getKeyValue("web.customers.module.quotes.help."+$request.toCountryCode)
						WAPI_pushDOMHelp(WAPI_getInputControlID(->[WebEWires:149]AML_Info:9; "toMOP"); $help; "form-control-label small")
						
					: ($tDeliveryMOP="N")  // bank
						WAPI_pushDOMVisible("delivery-bank-hidden"; True:C214)
					: ($tDeliveryMOP="N-M")  //wallet
						WAPI_pushDOMVisible("delivery-mobilewallet-hidden"; True:C214)
						// -- GET PICKUP LOCATIONS 
						$help:=getKeyValue("web.customers.module.quotes.help."+$request.toCountryCode)
						WAPI_pushDOMHelp(WAPI_getInputControlID(->[WebEWires:149]AML_Info:9; "toMOP"); $help; "form-control-label small")
						
					: ($tDeliveryMOP="MG")  //moneygram
						WAPI_pushDOMVisible("delivery-moneygram-hidden"; True:C214)
					Else 
						
				End case 
				
				
				WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[WebEWires:149]fromAmount:3); $tFromCCY)
				WAPI_pushDOMHTML("webewires-amount-addon-post"; $tFromCCY)
				WAPI_pushDOMValue("webewires-amount-input"; String:C10($rFromAmount-$rFromFee))
				
				
				ARRAY TEXT:C222($atSelectName; 0)
				ARRAY TEXT:C222($atSelectValue; 0)
				APPEND TO ARRAY:C911($atSelectName; "Cash Pickup")
				APPEND TO ARRAY:C911($atSelectValue; "D")
				APPEND TO ARRAY:C911($atSelectName; "Mobile Wallet")
				APPEND TO ARRAY:C911($atSelectValue; "N-M")
				APPEND TO ARRAY:C911($atSelectName; "Bank Transfer")
				APPEND TO ARRAY:C911($atSelectValue; "N")
				WAPI_pushDOMSelectOptions("delivery-mg"; ->$atSelectName; ->$atSelectValue; ->$atSelectName; [WebEWires:149]paymentInfo:35.deliveryMethod2)
				
				
				If ([WebEWires:149]paymentInfo:35.paymentMethod#"")
					//WAPI_pushDOMClass (Replace string([WebEWires]paymentInfo.paymentMethod;"dash-quote-";"webewires-");"btn-primary";"add")  // highlight the payment method/ POLI/EFTPOS/other
					WAPI_pushDOMClass("webewires-pay-method-"+$payMethod; "btn-primary"; "add")
				End if 
				
				
				
				$bRefresh:=False:C215
				
				
				
			Else 
				
		End case 
		
		
		If ($tDoTransfer="")
			WAPI_pushDOMHTML("delivery-tab-status"; "[NONE]")
		Else 
			WAPI_pushDOMVisible("delivery-hidden"; True:C214)
			WAPI_pushDOMHTML("delivery-tab-status"; "["+WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_Name)+"]")
		End if 
		
		If (WAPI_getInputValue(->[WebEWires:149]toThirdParty:23; Info_DoSendToThirdParty)="on")
			WAPI_pushDOMVisible("thirdparty-hidden"; True:C214)
			WAPI_pushDOMHTML("thirdparty-tab-status"; "["+WAPI_getInputValue(->[WebEWires:149]toThirdParty:23; Info_LastName)+"]")
		Else 
			WAPI_pushDOMHTML("thirdparty-tab-status"; "[NONE]")
		End if 
		
		
End case 





//------------- SOURCE CHANGE IN VALUES ------------------
Case of 
	: ($tSource="rateRefresh")
		$updateRates:=True:C214
		
	: ($tEvent="click") & ($tSource="method-type-@")
		WAPI_pushDOMClass("method-type-*"; "btn-primary"; "remove")
		WAPI_pushDOMClass($tSource; "btn-primary"; "add")
		WAPI_pushDOMValue("webewires-method-type"; Replace string:C233($tSource; "method-type-"; ""))
		
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]fromFee:6))  // ---------------------------------- CHANGE IN FEE ------
		$bRefresh:=True:C214
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]toAmount:10))  // --------------------------------- CHANGE IN TO AMOUNT ------
		$bRefresh:=True:C214
		$updateRates:=True:C214
		
	: ($tSource="webewires-amount-input")  // ------------------------------- CHANGE IN FROM AMOUNT -- LOCAL AMOUNT NO FEE------
		$bRefresh:=True:C214
		$updateRates:=True:C214
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]fromAmount:3))  // ------------------------------- CHANGE IN FROM AMOUNT -- LOCAL AMOUNT WITH FEES------
		$bRefresh:=True:C214
		$updateRates:=True:C214
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]directRate:13))  //-------------------------------- CHANGE IN DIRECT RATE -------
		$rInverseRate:=1/$rSourceRate
		$bRefresh:=True:C214
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]inverseRate:14))  //-------------------------------- CHANGE IN INVERSE RATE -------
		$rSourceRate:=1/$rInverseRate
		$bRefresh:=True:C214
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]AML_Info:9; "toMOPCode"))
		$isBank:=False:C215
		$isCash:=False:C215
		$isMobileWallet:=False:C215
		
		Case of 
			: ($toMOP=getKeyValue("web.customers.webewires.tomop.bank"))
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; "doTransferToBank"); "on")
				$isBank:=True:C214
				
			: ($toMOP=getKeyValue("web.customers.webewires.tomop.mobilewallet"))  //fiji
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; "doTransferToBank"); "")
				$isMobileWallet:=True:C214
				
			: ($toMOP=getKeyValue("web.customers.webewires.tomop.cash"))
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; "doTransferToBank"); "")
				$isCash:=True:C214
				
			Else   //assume cash
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; "doTransferToBank"); "")
				$isCash:=True:C214
		End case 
		
		
		If ($isBank)  //is bank
			WAPI_pushDOMVisible("delivery-bank-hidden"; True:C214)
			Case of 
				: (webContext="customers")
					QUERY:C277([Links:17]; [Links:17]LinkID:1=$tLinkID; *)
					QUERY:C277([Links:17];  & ; [Links:17]CustomerID:14=$tCustomerID)
					
					If ([Links:17]BankName:28="")
					Else 
						$tBankName:=[Links:17]BankName:28
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name); $tBankName)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo); [Links:17]BankAccountNo:31)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode); [Links:17]BankTransitCode:29)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Swift); [Links:17]BankSwift:62)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_RoutingCode); [Links:17]BankTransitCode:29)  //<>TODO don't have routing code????
						
						WAPI_pushDOMHTML("delivery-tab-status"; [Links:17]BankName:28)
					End if 
					
				: (webContext="agents")
					QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$tCustomerID)  //customer is the beneficiary
					
					QUERY:C277([WireTemplates:42]; [WireTemplates:42]CustomerID:2=$tCustomerID; *)
					QUERY:C277([WireTemplates:42];  & ; [WireTemplates:42]relationship:34="self")
					
					Case of 
						: (Records in selection:C76([WireTemplates:42])>1)
							ARRAY TEXT:C222($atSelectName; 0)
							ARRAY TEXT:C222($atSelectValue; 0)
							webGetChoiceListWireTemplates(->$atSelectName; ->$atSelectValue)
							WAPI_pushDOMSelectOptions("wiretemplates-select"; ->$atSelectName; ->$atSelectValue; ->$atSelectName)  //<-- SHOULD WE HAVE AN OPTION TO SELECT BASED ON VALUE PASSED IN??
							
						: (Records in selection:C76([WireTemplates:42])=1)
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankName:76); [WireTemplates:42]BankName:3)
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankAccountNo:66); [WireTemplates:42]AccountNo:6)
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankTransitCode:77); [WireTemplates:42]BranchTransitNo:5)
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankDetails:38); [WireTemplates:42]BankAddress:10+" "+[WireTemplates:42]BankCity:11+", "+[WireTemplates:42]BankState:22+" "+[WireTemplates:42]BankZIPCode:23+" "+[WireTemplates:42]BankCountry:12)
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]PurposeOfTransaction:65); [Customers:3]AML_POT_EFT:105)
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]AMLsourceOfFunds:94); [Customers:3]AML_SOF_SOW:38)  //[WireTemplates]Remarks)
							WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankDetails:38); "readonly"; "false")
							WAPI_pushDOMHTML("delivery-tab-status"; "["+[WireTemplates:42]BankName:3+"]")
						Else 
							//turn off read only
							WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name); "readonly"; "false")
							WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo); "readonly"; "false")
							WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode); "readonly"; "false")
							WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Details); "readonly"; "false")
					End case 
					
				Else 
					
			End case 
			
		Else 
			WAPI_pushDOMVisible("delivery-bank-hidden"; False:C215)
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name); "")
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo); "")
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode); "")
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_RoutingCode); "")
			WAPI_pushDOMHTML("delivery-tab-status"; "")
		End if 
		
		
		If ($isMobileWallet)
			WAPI_pushDOMVisible("delivery-mobilewallet-hidden"; True:C214)
		Else 
			WAPI_pushDOMVisible("delivery-mobilewallet-hidden"; False:C215)
		End if 
		
		
		If ($isCash)
			
		Else 
			
		End if 
		
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; "doTransferToBank")) | ($tSource="webewires-do-cash-pickup")  // ------------------------- DIRECT DEPOSIT ------
		//--------- THIS IS REPLACED. BY THE ABOVE ----------
		
		If ($tDoTransfer="") | ($tSource="webewires-do-cash-pickup")  // no bank -- this i scash
			
			WAPI_pushDOMVisible("delivery-bank-hidden"; False:C215)
			
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name); "")
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo); "")
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode); "")
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_RoutingCode); "")
			
			WAPI_pushDOMHTML("delivery-tab-status"; "")
			
			WAPI_pushDOMProperty("webewires-do-cash-pickup"; "checked"; "true")
			WAPI_pushDOMProperty(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; "doTransferToBank"); "checked"; "false")
		Else 
			WAPI_pushDOMProperty(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; "doTransferToBank"); "checked"; "true")
			WAPI_pushDOMProperty("webewires-do-cash-pickup"; "checked"; "false")
			WAPI_pushDOMVisible("delivery-bank-hidden"; True:C214)
			
			Case of 
				: (webContext="customers")
					QUERY:C277([Links:17]; [Links:17]LinkID:1=$tLinkID; *)
					QUERY:C277([Links:17];  & ; [Links:17]CustomerID:14=$tCustomerID)
					
					If ([Links:17]BankName:28="")
					Else 
						$tBankName:=[Links:17]BankName:28
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name); $tBankName)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo); [Links:17]BankAccountNo:31)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode); [Links:17]BankTransitCode:29)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Swift); [Links:17]BankTransitCode:29)  //links do not have swift code
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_RoutingCode); "")  //<>TODO don't have routing code????
						
						WAPI_pushDOMHTML("delivery-tab-status"; [Links:17]BankName:28)
					End if 
					
				: (webContext="agents")
					QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$tCustomerID)  //customer is the beneficiary
					
					QUERY:C277([WireTemplates:42]; [WireTemplates:42]CustomerID:2=$tCustomerID; *)
					QUERY:C277([WireTemplates:42];  & ; [WireTemplates:42]relationship:34="self")
					
					Case of 
						: (Records in selection:C76([WireTemplates:42])>1)
							ARRAY TEXT:C222($atSelectName; 0)
							ARRAY TEXT:C222($atSelectValue; 0)
							webGetChoiceListWireTemplates(->$atSelectName; ->$atSelectValue)
							WAPI_pushDOMSelectOptions("wiretemplates-select"; ->$atSelectName; ->$atSelectValue; ->$atSelectName)  //<-- SHOULD WE HAVE AN OPTION TO SELECT BASED ON VALUE PASSED IN??
							
							
						: (Records in selection:C76([WireTemplates:42])=1)
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankName:76); [WireTemplates:42]BankName:3)
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankAccountNo:66); [WireTemplates:42]AccountNo:6)
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankTransitCode:77); [WireTemplates:42]BranchTransitNo:5)
							
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankDetails:38); [WireTemplates:42]BankAddress:10+" "+[WireTemplates:42]BankCity:11+", "+[WireTemplates:42]BankState:22+" "+[WireTemplates:42]BankZIPCode:23+" "+[WireTemplates:42]BankCountry:12)
							
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]PurposeOfTransaction:65); [Customers:3]AML_POT_EFT:105)
							WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]AMLsourceOfFunds:94); [Customers:3]AML_SOF_SOW:38)  //[WireTemplates]Remarks)
							
							WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankDetails:38); "readonly"; "false")
							WAPI_pushDOMHTML("delivery-tab-status"; "["+[WireTemplates:42]BankName:3+"]")
						Else 
							//turn off read only
							WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name); "readonly"; "false")
							WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo); "readonly"; "false")
							WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode); "readonly"; "false")
							WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Details); "readonly"; "false")
					End case 
					
				Else 
					
			End case 
			
		End if 
		
		
	: ($tSource="wiretemplates-select")  //-----------------------  WIRE TEMPLATE SELECT MENU --------------------
		$tSelect:=WAPI_getParameter("wiretemplates-select")
		
		QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=$tSelect)
		
		If (Records in selection:C76([WireTemplates:42])=1) & ([WireTemplates:42]CustomerID:2=$tCustomerID)
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name); [WireTemplates:42]BankName:3)
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo); [WireTemplates:42]AccountNo:6)
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode); [WireTemplates:42]BranchTransitNo:5)
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_RoutingCode); [WireTemplates:42]RoutingCode:7)
			
			WAPI_pushDOMHTML("delivery-tab-status"; "["+WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_Name)+"]")
			
		End if 
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name))
		WAPI_pushDOMHTML("delivery-tab-status"; "["+WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_Name)+"]")
		
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]toThirdParty:23; "doSendThirdParty"))  // --------------------- IS THIRD PARTY INVOVLED---
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				WAPI_pushDOMVisible("thirdparty-hidden"; True:C214)
			Else 
				WAPI_pushDOMVisible("thirdparty-hidden"; False:C215)
			End if 
		Else 
			WAPI_pushDOMVisible("thirdparty-hidden"; False:C215)
		End if 
		
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]toThirdParty:23; "lastName"))
		WAPI_pushDOMHTML("thirdparty-tab-status"; "["+WAPI_getInputValue(->[WebEWires:149]toThirdParty:23; "lastName")+"]")
		
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]toCountryCode:12))  // ---------------------------- CHANGE IN DESTINATION COUNTRY --- UPDATE ACCOUNT-ID OPTIONS
		//update account popup
		ARRAY TEXT:C222($atAccounts; 0)
		
		$tCountryCode:=WAPI_getInputValue(->[eWires:13]toCountryCode:112)  //;$ptrNameArray;$ptrValueArray)
		QUERY:C277([Accounts:9]; [Accounts:9]CountryCode:39=$tCountryCode)
		
		If (webContext="agents")
			QUERY SELECTION:C341([Accounts:9]; [Accounts:9]AgentID:16=""; *)
			QUERY SELECTION:C341([Accounts:9];  | ; [Accounts:9]AgentID:16=[Agents:22]AgentID:1)
		End if 
		
		DISTINCT VALUES:C339([Accounts:9]AccountID:1; $atAccounts)
		SORT ARRAY:C229($atAccounts; >)
		
		//----------------- ACCOUNTID IS THE DESITINATION CURRENCY AND BASIS FOR THE RATE -------
		
		If (Size of array:C274($atAccounts)>0)
			WAPI_pushDOMSelectOptions(WAPI_getInputControlID(->[eWires:13]AccountID:30); ->$atAccounts)  //<-- SHOULD WE HAVE AN OPTION TO SELECT BASED ON VALUE PASSED IN??
			
			QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$atAccounts{1})
			$tCurrCode:=[Accounts:9]Currency:6
			QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=[Accounts:9]CurrencyAlias:26)
			
			$tCurrFromCode:=[Currencies:6]toISO4217:32  //to currency
			$rSourceRate:=[Currencies:6]OurSellRateLocal:8  //direct rate
			$rInverseRate:=[Currencies:6]OurSellRateInverse:26
		End if 
		
		$bRefresh:=True:C214
		
		
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]LinkID:25))  //------------ CUSTOMER BENEFICIARY -----
		$tLinkID:=WAPI_getInputValue(->[WebEWires:149]LinkID:25)
		WAPI_pushDOMVisible("beneficary-create-group"; True:C214)
		
		If ($tLinkID="")
		Else 
			QUERY:C277([Links:17]; [Links:17]LinkID:1=$tLinkID; *)
			QUERY:C277([Links:17];  & ; [Links:17]CustomerID:14=$tCustomerID)
			
			If (Records in selection:C76([Links:17])=1)
				If ([Links:17]AML_isOnHold:54=False:C215)
					
					If ([Links:17]isCompany:43)
						$request.toParty[Info_isCompany]:="true"
						$request.toParty[Info_CompanyName]:=[Links:17]CompanyName:42
					End if 
					
					$request.toParty[Info_FirstName]:=[Links:17]FirstName:2
					$request.toParty[Info_LastName]:=[Links:17]LastName:3
					$request.toParty[Info_FullName]:=[Links:17]FullName:4
					$request.toParty[Info_Address]:=[Links:17]Address:19
					$request.toParty[Info_City]:=[Links:17]City:11
					$request.toParty[Info_State]:=[Links:17]Province:60
					$request.toParty[Info_PostalCode]:=[Links:17]PostalCode:61
					$request.toParty[Info_CellPhone]:=[Links:17]MainPhone:8
					$request.toParty[Info_CountryCode]:=[Links:17]countryCode:50
					$request.toParty[Info_Relationship]:=[Links:17]Relationship:26
					
					$request.toCountryCode:=[Links:17]countryCode:50
					$request.LinkID:=$tLinkID
					
					If ($request.AML_Info.toMOPCode="N")  //bank transfer
						$request.toBankingInfo[Bank_doTransferToBank]:=True:C214
						$request.toBankingInfo[Bank_Name]:=[Links:17]BankName:28
						$request.toBankingInfo[Bank_Address]:=[Links:17]BankAddress:30
						$request.toBankingInfo[Bank_AccountNo]:=[Links:17]BankAccountNo:31
						$request.toBankingInfo[Bank_Swift]:=[Links:17]BankSwift:62
						$request.toBankingInfo[Bank_TransitCode]:=[Links:17]BankTransitCode:29
						$request.toBankingInfo[Bank_RoutingCode]:=[Links:17]BankTransitCode:29  //there isn't another field for routing code
						$request.toBankingInfo[Bank_Details]:=[Links:17]BankingDetails:9
						
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name); [Links:17]BankName:28)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Address); [Links:17]BankAddress:30)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo); [Links:17]BankAccountNo:31)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Swift); [Links:17]BankSwift:62)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode); [Links:17]BankTransitCode:29)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_RoutingCode); [Links:17]BankTransitCode:29)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Details); [Links:17]BankingDetails:9)
					End if 
					
					$tToName:=[Links:17]FullName:4
					WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_FullName); $tToName)
					WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]CustomerID:21); $tCustomerID)
					WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]LinkID:25); $tLinkID)
					WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_CellPhone); [Links:17]MainPhone:8)
					WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_CountryCode); [Links:17]countryCode:50)
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_FullName); "readonly"; "readonly")
					WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_Relationship); [Links:17]Relationship:26)
					WAPI_pushDOMVisible("beneficiary-link"; True:C214)
					WAPI_pushDOMVisible("beneficiary-new"; False:C215)
					WAPI_pushDOMVisible("beneficiary-search"; False:C215)
					
					//---- GET BENEFICIARY COUNTRY CODE AND CCY ----
					WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toCountryCode:12); [Links:17]countryCode:50)
					
					If ($request.isQuote)  //dont change the ccy
					Else 
						$tToCCY:=getCurrencyCodeByCountryCode([Links:17]countryCode:50)
						WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toCCY:11); $tToCCY)
					End if 
					
					
					WAPI_pushDOMVisible("beneficary-create-group"; False:C215)
					
					$tSelect:=WAPI_getInputControlID(->[WebEWires:149]AML_Info:9; "tomopcode")  //"webewires-aml_info-tomop-input"
					If ([Links:17]countryCode:50="FJ")
						WAPI_pushJs("$('#"+$tSelect+" option[value=\""+getKeyValue("web.customers.webewires.tomop.mobilewallet")+"\"]').removeAttr('disabled');")
					Else 
						WAPI_pushJs("$('#"+$tSelect+" option[value=\""+getKeyValue("web.customers.webewires.tomop.mobilewallet")+"\"]').attr('disabled', 'disabled');")
					End if 
					
					//if from quote then don't update
					$updateRates:=True:C214
					
				Else 
					//<>TODO link on hold so let the customer know
				End if 
				
			End if 
			
			If ($status.success) & ($request.paymentInfo.deliveryMethod="MG")  // if MG transaction need to get additional fields
				
				// get required fields for the transaction
				// NOTE: FROM data is coming from agent id
				//. TransferSendAmount = fromAmount before fromFee
				//. TransferCurrency = toCCY
				//. Country = toCountry
				//. DeliveryOptionCode = MG code ie. WILL_CALL...
				
				$delCode:=$request.paymentInfo.deliveryMethod2Code
				
				$deliveryOption:=New object:C1471("TransferSendAmount"; $request["fromAmount"]-$request["fromFee"]; "TransferCurrency"; \
					mgCurrencyCode2CurrencyID($request["toCCY"]); "Country"; mgCountryCode2CountryID($request["toCountryCode"]); \
					"DeliveryOptionCode"; $delCode; "TransferSendCurrency"; mgCurrencyCode2CurrencyID($request.fromCCY); \
					"TransferToPointId"; $request.paymentInfo.transferToPointId)
				
				$required:=mgGetSendRequestMethodInfo($deliveryOption)
				
				If ($required.success)  // list of all required data elements we need to complete the transaction
					// list of existing parameter that we have - just use $request a copy of [webewires]
					$customer:=ds:C1482.Customers.query("CustomerID == :1"; $request.CustomerID)
					$mg:=mgNewTransactionByCustomer("send"; $customer.first())  // create MG data object for current customer info
					
					//now add additional data needed to complete the MG request - currently using the profix naming
					$mg.object.senderOccupation:=""  //$customer.first().OccupationCode  // need to see about mappiing these??
					$mg.object.mgiRewardsNumber:=""
					$mg.object.receiverCountry:=mgCountryCode2CountryID($request.toCountryCode)
					
					If ($request.toParty[Info_LastName].length>30)
						$col:=New collection:C1472
						$col:=Split string:C1554($request.toParty[Info_LastName]; " "; sk trim spaces:K86:2+sk ignore empty strings:K86:1)
						If ($col.length>1)
							$mg.object.receiverLastName:=Substring:C12($col[0]; 1; 30)  // NEED TO SPLIT INTO 2 FIELDS - 
							$mg.object.receiverLastName2:=Substring:C12($col[1]; 1; 30)
						Else 
							$mg.object.receiverLastName:=Substring:C12($request.toParty[Info_LastName]; 1; 30)  // NEED TO SPLIT INTO 2 FIELDS - 
							$mg.object.receiverLastName2:=Substring:C12($request.toParty[Info_LastName]; 21; 30)
						End if 
					Else 
						$mg.object.receiverLastName:=$request.toParty[Info_LastName]
					End if 
					
					If ($request.toParty[Info_FirstName].length>20)
						$col:=New collection:C1472
						$col:=Split string:C1554($request.toParty[Info_LastName]; " "; sk trim spaces:K86:2+sk ignore empty strings:K86:1)
						If ($col.length>1)
							$mg.object.receiverFirstName:=Substring:C12($col[0]; 1; 20)  //20 char limit
							$mg.object.receiverMiddleName:=Substring:C12($col[1]; 1; 20)  //20 char limit
						Else 
							$mg.object.receiverFirstName:=Substring:C12($request.toParty[Info_FirstName]; 1; 20)  //20 char limit
							$mg.object.receiverMiddleName:=Substring:C12($request.toParty[Info_FirstName]; 21; 20)  // middle name
						End if 
					Else 
						$mg.object.receiverFirstName:=$request.toParty[Info_FirstName]
					End if 
					
					$mg.object.receiverAddress:=$request.toParty[Info_Address]
					$mg.object.receiverCity:=$request.toParty[Info_City]
					$mg.object.receiverState:=$request.toParty[Info_State]
					$mg.object.receiverZipCode:=$request.toParty[Info_PostalCode]
					$mg.object.receiverPhone:=$request.toParty[Info_CellPhone]
					$mg.object.receiverPhoneCountryCode:="1"  //optional
					$mg.object.receiverMiddleName:=""  //optional
					$mg.object.senderRelationship:=$request.toParty[Info_Relationship]  // need to convert to MG 
					
					$status:=mgValidateTransaction($mg.object)  // here before converting it to format suitable for SendRequest @milan
					// question - at this point we don't have all data elements .. ie missing params -- milan what do you think?
					
					If ($status.success)
						$transaction:=mgBuildSendRequestTransaction($mg.object; $deliveryOption; $required)  //combine all data elements and convert to soap nameing
						If (True:C214)
							$transaction.PromotionCode:=$request.paymentInfo.promotionCode
						End if 
						$transaction.FormFreeStaging:="true"
						
						// what parameters do we NOT have - compare - $required.response is xml
						C_OBJECT:C1216($missingAllValidated)
						$missingAllValidated:=mgHndlSendRequestMissingParams($required.response; $transaction; $request.CustomerID; True:C214; False:C215)
						
						// if any missing we need to send to web page for user to complete
						If ($missingAllValidated.success=False:C215)
							$request.isComplete:=False:C215
							$request.mgMissing:=$missingAllValidated
							
							
							C_OBJECT:C1216($field)
							For each ($field; $missingAllValidated.missing)  // add each missing element to the AML tab
								// $field.Name -- what other properties are available?
								// Name
								// Caption
								//Type ie. CurrencyAmount, string, integer
								// MaxLength
								// isRequired 
								//Enumerated (true/false
								// EnumeratedValues (object)
								//       EnumberatedValues.EnumeratedValuesInfo.[0] {EnumeratedValue:"ADMIN", EnumeratedLabel:"Administrative"}
								//
								
								OB SET:C1220($transaction; $field.Name; "")  // add to trans obj
								
								Case of 
									: ($field.Enumerated="true")  // SELECT MENU
										C_COLLECTION:C1488($options)
										C_OBJECT:C1216($item)
										
										$options:=New collection:C1472
										
										If (Value type:C1509($field.EnumeratedValues.EnumeratedValuesInfo)=Is object:K8:27)
											$options.push(New object:C1471("value"; $field.EnumeratedValues.EnumeratedValuesInfo.EnumeratedValue; "label"; $field.EnumeratedValues.EnumeratedValuesInfo.EnumeratedLabel))
										Else 
											
											For each ($item; $field.EnumeratedValues.EnumeratedValuesInfo)
												$options.push(New object:C1471("value"; $item.EnumeratedValue; "label"; $item.EnumeratedLabel))
											End for each 
											
										End if 
										
										Case of 
											: (($field.Name="@bank@") | ($field.Name="accountnumber@"))  //put on delivery tab
												$div:="webewires-delivery-mg-required"
											Else 
												$div:="webewires-aml-mg-required"
										End case 
										
										WAPI_pushFormGroup(New object:C1471("div"; $div; "id"; "mg-required-"+$field.Name; "type"; "select"; "label"; $field.Caption; \
											"required"; True:C214; "options"; $options; "onchange"; "wapiObjectMethod(event)"))
										
									Else   // TEXT INPUT
										$pattern:=""
										
										Case of 
											: (($field.Name="@bank@") | ($field.Name="accountnumber@"))  //put on delivery tab
												$div:="webewires-delivery-mg-required"
												If ($field.MaxLength=Null:C1517)
													$placeholder:="Please enter "+$field.Name+" here."
													$title:=""
												Else 
													$placeholder:="Please enter "+$field.Name+" here. Max Length: "+String:C10($field.MaxLength)
													$pattern:="^(.|){1,"+String:C10($field.MaxLength)+"}$"
													$title:="The maximum length is "+String:C10($field.MaxLength)
												End if 
												
												Case of 
													: ($field.Name="accountNumber@")
														$value:=ds:C1482.Links.query("LinkID == :1"; $tLinkID).first().BankAccountNo
													: ($field.Name="receiverBankIdentifier@")
														$value:=ds:C1482.Links.query("LinkID == :1"; $tLinkID).first().BankTransitCode
													Else 
														$value:=""
												End case 
												
											Else 
												$div:="webewires-aml-mg-required"
												$placeholder:="Please enter "+$field.Name+" here."
										End case 
										
										WAPI_pushFormGroup(New object:C1471("div"; $div; "id"; "mg-required-"+$field.Name; "type"; "text"; "label"; $field.Caption; \
											"placeholder"; $placeholder; "required"; True:C214; "onchange"; "wapiObjectMethod(event)"; "pattern"; $pattern; "value"; $value; "title"; $title))
										
										
								End case 
								
							End for each 
							
							// ---  ADD ANY FIELDS THAT ARE NOT FORMATTED CORRECTLY AND MAKE USER REDO
							If ($missingAllValidated.formatting.length>0)
								For each ($field; $missingAllValidated.formatting)
									$maxLength:=Num:C11(OB Get:C1224($field; "MaxLength"))
									
									$value:=Substring:C12(OB Get:C1224($transaction; $field.Name; Is text:K8:3); 1; $maxLength)
									
									If ($maxLength>0)
										$help:="Maximum length for "+$field.Name+" is "+String:C10($maxLength)+" characters."
										$pattern:="^(.|){1,"+String:C10($field.MaxLength)+"}$"
									Else 
										$pattern:=""
									End if 
									
									Case of 
										: ($field.Enumerated="true") & ($field.EnumeratedValues.EnumeratedValuesInfo.length>0)  // need a select
											C_COLLECTION:C1488($options)
											C_OBJECT:C1216($item)
											
											$options:=New collection:C1472
											For each ($item; $field.EnumeratedValues.EnumeratedValuesInfo)
												$options.push(New object:C1471("value"; $item.EnumeratedValue; "label"; $item.EnumeratedLabel))
											End for each 
											
											Case of 
												: ($field.Name="@bank@") | ($field.Name="accountnumber@")  //put on delivery tab
													$div:="webewires-delivery-mg-required"
												Else 
													$div:="webewires-aml-mg-required"
											End case 
											
											WAPI_pushFormGroup(New object:C1471("div"; $div; "id"; "mg-required-"+$field.Name; "type"; "select"; "label"; $field.Caption; \
												"required"; True:C214; "options"; $options; "onchange"; "wapiObjectMethod(event)"))
											
										Else 
											
											Case of 
												: ($field.Name="@bank@") | ($field.Name="accountnumber@")  //put on delivery tab
													$div:="webewires-delivery-mg-required"
												Else 
													$div:="webewires-aml-mg-required"
											End case 
											
											
											If ($pattern="")
												WAPI_pushFormGroup(New object:C1471("div"; $div; "id"; "mg-required-"+$field.Name; "type"; "text"; "label"; $field.Caption; \
													"placeholder"; "Please enter "+$field.Name+" here"; "required"; True:C214; "value"; $value; "help"; $help; "onchange"; "wapiObjectMethod(event)"))
											Else 
												WAPI_pushFormGroup(New object:C1471("div"; $div; "id"; "mg-required-"+$field.Name; "type"; "text"; "label"; $field.Caption; \
													"placeholder"; "Please enter "+$field.Name+" here"; "required"; True:C214; "value"; $value; "help"; $help; "onchange"; \
													"wapiObjectMethod(event)"; "pattern"; $pattern))
											End if 
											
									End case 
								End for each 
							End if 
							
						End if 
						
						
						If (True:C214)  //--- MAKE $TRANSACTION ONLY HAVE REQUIRED PARAMETERS SO WE DON'T HAVE FORMATTING ISSUES
							
							$col:=New collection:C1472
							$col:=$missingAllValidated.required.distinct("Name")
							For each ($prop; $transaction)  //$missingAllValidated.required)
								Case of 
									: ($col.indexOf($prop)>=0)
										//If (OB Is defined($missingAllValidated.required;$field.Name))
										//this is a required field/property - leave it here
									: ($prop="FormFreeStaging")
									: ($prop="PromotionCode")
									: ($prop="@ZipCode@")  //make this required"
									Else   //not required so remove
										OB REMOVE:C1226($transaction; $prop)
								End case 
								
							End for each 
						End if 
						
					Else   // error wiht validation
						//send back an error
						C_OBJECT:C1216($error)
						For each ($error; $status.errors)
							$tResult:=JSON Stringify:C1217($error)+"\n"
						End for each 
						
						WAPI_pushDisplayMessage("Error validating MG transaction.\n\n"+$tResult)
						$status.success:=False:C215
					End if 
					
					
				Else 
					$request.LinkID:=""
					WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]LinkID:25); "")
					WAPI_pushDOMVisible("beneficiary-link"; False:C215)
					// WAPI_pushDisplayMessage ("MoneyGram Error";"Required fields could NOT be retrieved.<br>Please try again later.")
					WAPI_pushDisplayMessage("MoneyGram Error"; "Required fields could NOT be retrieved. MoneyGram returned:<br>"+$required.mgerrormsg.message\
						+" OperationalID = "+$required.mgerrormsg.operationalID+"<br>Please try again later.")
				End if 
				
			End if 
			
		End if 
		
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]CustomerID:21))  //& (webContext="agents")  // ------------------------------- CHANGE IN BENEFICIARY POPUP/SELECT (CUSTOMER) ------
		$tCustomerID:=WAPI_getInputValue(->[WebEWires:149]CustomerID:21)
		
		Case of 
			: ($tCustomerID="")  //shouldn't get this
				
			: ($tCustomerID="|@")  //no id assigned yet
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_FullName); Replace string:C233($tCustomerID; "|"; ""))
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]CustomerID:21); $tCustomerID)
				WAPI_pushDOMVisible("beneficiary-new"; True:C214)
				WAPI_pushDOMVisible("beneficiary-search"; False:C215)
				WAPI_pushDOMVisible("beneficiary-link"; False:C215)
				WAPI_pushDOMFocus(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_Address))
				WAPI_pushDOMHTML("beneficiary-tab-status"; "["+Replace string:C233($tCustomerID; "|"; "")+"]")
				WAPI_pushDOMClass("beneficiary-tab-status")  //remove all classes
				WAPI_pushDOMClass("beneficiary-tab-status"; "sanction-unknown")
				
				WAPI_pushDOMImgSrc("beneficiary-tab-image"; "")
				
			: ($tCustomerID="NEW")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_FullName); "")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]CustomerID:21); "NEW")
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_FullName); "readonly"; "")  //remove read only
				WAPI_pushDOMVisible("beneficiary-new"; True:C214)
				WAPI_pushDOMVisible("beneficiary-search"; False:C215)
				WAPI_pushDOMVisible("beneficiary-link"; False:C215)
				WAPI_pushDOMFocus(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_FullName))
				WAPI_pushDOMHTML("beneficiary-tab-status"; "")
				WAPI_pushDOMClass("beneficiary-tab-status")  //remove all classes
				//wapi_pushDOMImgSrc ("beneficiary-tab-image";"")
				
			: ($tCustomerID="SEARCH")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_FullName); "")  //clear the value here
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]CustomerID:21); "SEARCH")
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_FullName); "readonly"; "")  //remove read only
				WAPI_pushDOMVisible("beneficiary-search"; True:C214)
				WAPI_pushDOMVisible("beneficiary-new"; False:C215)
				WAPI_pushDOMVisible("beneficiary-link"; False:C215)
				WAPI_pushDOMFocus(WAPI_getInputControlID(->[Customers:3]CustomerID:1))
				WAPI_pushDOMHTML("beneficiary-tab-status"; "")
				WAPI_pushDOMClass("beneficiary-tab-status")  //remove all classes
				//wapi_pushDOMImgSrc ("beneficiary-tab-image";"")
				
			Else 
				QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$tCustomerID)
				
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_FullName); [Customers:3]FullName:40)
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]CustomerID:21); $tCustomerID)
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_CellPhone); [Customers:3]CellPhone:13)
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_CountryCode); [Customers:3]CountryOfResidenceCode:114)
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_FullName); "readonly"; "readonly")
				WAPI_pushDOMVisible("beneficiary-link"; True:C214)
				WAPI_pushDOMVisible("beneficiary-new"; False:C215)
				WAPI_pushDOMVisible("beneficiary-search"; False:C215)
				If (True:C214)
					WAPI_pushDOMHTML("beneficiary-tab-status"; "["+[Customers:3]FullName:40+"]")
					WAPI_pushDOMClass("beneficiary-tab-status")  //remove all classes
					$tClass:=webGetSanctionListClass(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4))
					WAPI_pushDOMClass("beneficiary-tab-status"; $tClass)
				Else 
					WAPI_pushDOMHTML("beneficiary-tab-status"; "["+[Customers:3]FullName:40+"]")
					getLatestCheckLogStatusIcon(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; ->$picStatus; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4))
					WAPI_pushDOMImgSrc("beneficiary-tab-image"; WAPI_pict2Base64(->$picStatus))
				End if 
				
				$tToCCY:=getCurrencyCodeByCountryCode([Customers:3]CountryOfResidenceCode:114)
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toCCY:11); $tToCCY)
				
				$tSelect:=WAPI_getInputControlID(->[WebEWires:149]AML_Info:9; "tomop")  //"webewires-aml_info-tomop-input"
				If ([Customers:3]CountryOfResidenceCode:114="FJ")
					WAPI_pushJs("$('#"+$tSelect+" option[value=\""+getKeyValue("web.customers.webewires.tomop.mobilewallet")+"\"]').removeAttr('disabled');")
				Else 
					WAPI_pushJs("$('#"+$tSelect+" option[value=\""+getKeyValue("web.customers.webewires.tomop.mobilewallet")+"\"]').attr('disabled', 'disabled');")
				End if 
				
				
				$updateRates:=True:C214
		End case 
		
	: ($tSource=WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5))  // ---------------------- ADD NEW - BENEFICIARY NAME CHANGE --- 
		WAPI_pushDOMHTML("beneficiary-tab-status"; "["+$tName+"]")
		WAPI_pushDOMClass("beneficiary-tab-status")  //remove all classes
		
		
	: ($tSource=WAPI_getInputControlID(->[WebEWires:149]AML_Info:9; "purposeOfTransaction"))  // --------------------- PURPOSE OF TRANSACTION  ------
		WAPI_pushDOMHTML("aml-tab-status"; "["+Substring:C12(WAPI_getInputValue(->[WebEWires:149]AML_Info:9; "purposeOfTransaction"); 1; 15)+"...]")
		
	: ($tSource=WAPI_getInputControlID(->[eWires:13]Currency:12))  // --------------------------------- CHANGE IN CURRENCY ------ NOT USED - ALL BASED ON ACCOUNTS NOW
		WAPI_pushDOMHTML("destination-tab-status"; "["+String:C10($rToAmount; "###,###,##0.00")+" "+$tCurrCode+"]")
		$bRefresh:=True:C214
		
		
		
	: ($tSource=WAPI_getInputControlID(->[Customers:3]CustomerID:1)) | ($tSource=WAPI_getInputControlID(->[Customers:3]FullName:40)) | ($tSource=WAPI_getInputControlID(->[Customers:3]DOB:5))  //lookup existing
		If (webContext="agents")
			$bQuery:=True:C214  //assume a query
			$tCustomerID:=WAPI_getInputValue(->[Customers:3]CustomerID:1)  //;$ptrNameArray;$ptrValueArray)
			$tName:=WAPI_getInputValue(->[Customers:3]FullName:40)  //;$ptrNameArray;$ptrValueArray)
			$dDOB:=Date:C102(WAPI_getInputValue(->[Customers:3]DOB:5))  //;$ptrNameArray;$ptrValueArray)+"T00:00:00")
			
			Case of 
				: ($tCustomerID#"") & ($tName#"")  // & ($tFirstName#"")  //query
					QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$tCustomerID; *)
					//QUERY([Customers]; & ;[Customers]FirstName=$tFirstName;*)
					QUERY:C277([Customers:3];  & ; [Customers:3]FullName:40=$tName)
					
					If (Records in selection:C76([Customers:3])=0)  //check for company
						QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$tCustomerID; *)
						QUERY:C277([Customers:3];  & ; [Customers:3]CompanyName:42=$tName)
					End if 
					
				: ($dDOB>!1920-01-01!) & ($tName#"")  //& ($tFirstName#"")  //query
					QUERY:C277([Customers:3]; [Customers:3]DOB:5=$dDOB; *)
					//QUERY([Customers]; & ;[Customers]FirstName=$tFirstName;*)
					QUERY:C277([Customers:3];  & ; [Customers:3]FullName:40=$tName)
					
				Else 
					$bQuery:=False:C215
			End case 
			
			If ($bQuery)
				If (Records in selection:C76([Customers:3])=1)  //all good
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); [Customers:3]FullName:40)
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]CustomerID:15); Uppercase:C13($tCustomerID))
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); "readonly"; "readonly")
					WAPI_pushDOMVisible("beneficiary-link"; True:C214)
					WAPI_pushDOMVisible("beneficiary-new"; False:C215)
					WAPI_pushDOMVisible("beneficiary-search"; False:C215)
					
					WAPI_pushDOMHTML("beneficiary-tab-status"; "["+[Customers:3]FullName:40+"]")
					If ([Customers:3]isCompany:41)
						WAPI_pushDOMClass("beneficiary-tab-status"; webGetSanctionListClass(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; [Customers:3]CompanyName:42))
					Else 
						WAPI_pushDOMClass("beneficiary-tab-status"; webGetSanctionListClass(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)))
					End if 
					
					WAPI_pushDOMError(WAPI_getInputControlID(->[Customers:3]CustomerID:1); ""; "")
				Else   //error
					WAPI_pushDOMError(WAPI_getInputControlID(->[Customers:3]FullName:40); "NOT FOUND - The search combination was not found."; "text-danger")
				End if 
				
			Else 
				
				Case of 
					: ($tSource=WAPI_getInputControlID(->[Customers:3]CustomerID:1)) & ($tCustomerID#"")
						WAPI_pushDOMVisible(WAPI_getInputControlID(->[Customers:3]DOB:5); False:C215)
						WAPI_pushDOMVisible(WAPI_getInputLabelID(->[Customers:3]DOB:5); False:C215)
						WAPI_pushDOMFocus(WAPI_getInputControlID(->[Customers:3]FullName:40))
						
					: ($tSource=WAPI_getInputControlID(->[Customers:3]DOB:5)) & ($dDOB>!1920-01-01!)
						WAPI_pushDOMVisible(WAPI_getInputControlID(->[Customers:3]CustomerID:1); False:C215)
						WAPI_pushDOMVisible(WAPI_getInputLabelID(->[Customers:3]CustomerID:1); False:C215)
						WAPI_pushDOMFocus(WAPI_getInputControlID(->[Customers:3]FullName:40))
						
					Else 
						WAPI_pushDOMVisible(WAPI_getInputControlID(->[Customers:3]DOB:5); True:C214)
						WAPI_pushDOMVisible(WAPI_getInputLabelID(->[Customers:3]DOB:5); True:C214)
						WAPI_pushDOMVisible(WAPI_getInputControlID(->[Customers:3]CustomerID:1); True:C214)
						WAPI_pushDOMVisible(WAPI_getInputLabelID(->[Customers:3]CustomerID:1); True:C214)
				End case 
				
			End if 
		End if 
		
		
		
		
	: ($tSource="webewires-isconfirmed-input")  // ------------- CONFIRMATION TO FINALIZE EWIRE REQUEST ----
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				WAPI_pushDOMVisible("payment-details-hidden"; True:C214)
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]status:16); "20")
				WAPI_pushDOMVisible("terms-hidden"; True:C214)
				WAPI_pushDOMValue("submit-input"; "Confirm eWire")
			Else 
			End if 
		Else 
			WAPI_pushDOMVisible("payment-details-hidden"; False:C215)
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]status:16); "10")
			WAPI_pushDOMVisible("terms-hidden"; False:C215)
			WAPI_pushDOMValue("submit-input"; "Save eWire")
		End if 
		
		
	: ($tSource="cancel-webewire-input")
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]status:16); "-10")
				WAPI_pushDOMValue("submit-input"; "Cancel eWire")
				WAPI_pushDOMAttribute("submit-input"; "disabled"; "")
				WAPI_pushDOMAttribute("submit-draft"; "disabled"; "disabled")
			Else 
			End if 
		Else 
			WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]status:16); "10")
			WAPI_pushDOMValue("submit-input"; "Save eWire")
			WAPI_pushDOMAttribute("submit-input"; "disabled"; "disabled")
			WAPI_pushDOMAttribute("submit-draft"; "disabled"; "")
		End if 
		
	: ($tSource="webewires-pay-method-@")
		$payMethod:=Replace string:C233($tSource; "webewires-pay-method-"; "")
		WAPI_pushDOMClass("webewires-pay-*"; "btn-primary"; "remove")
		WAPI_pushDOMClass($tSource; "btn-primary"; "add")
		WAPI_pushDOMValue("webewires-pay-method"; $payMethod)
		WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]paymentInfo:35; "paymentMethod"); $payMethod)
		$request.paymentInfo.paymentMethod:=$payMethod
		
	: ($tSource="agreement-input")  //-------------------------- SUBMIT BUTTON AND AGFEEMENT CHECKBOX ----------------------
		
		// test to see if we have all data elements and ok to submit
		$request.isComplete:=False:C215
		
		Case of 
			: ($request.CustomerID="")
			: ($request.LinkID="")
				$tResult:="Beneficiary Not Specified "
			: ($request.paymentInfo.paymentMethod="") & (webUsePaymentGateway)
				$tResult:="Payment Method Not Specified "
			: ($request.AML_Info[AML_toMOPCode]="")
				$tResult:="Method of Payout Not Specified "
			: ($request.directRate=0)
				$tResult:="Exchange Rate Not Specified "
			: ($request.fromAmount=0)
				$tResult:="From Amount is $0.00"
			: ($request.fromCCY="")
				$tResult:="From Currency Not Specifed"
			: ($request.toAmount=0)
				$tResult:="To Amount is $0.00"
			: ($request.toCCY="")
				$tResult:="To Currency Not Specifed"
			Else 
				$request.isComplete:=True:C214
		End case 
		
		
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0) & ($request.isComplete)
			If ($ptrValueArray->{$iElem}="on")  //& ($rDirectRate#0)
				WAPI_pushDOMAttribute("submit-input"; "disabled"; "")  //pass no value to remove the attribute
			Else 
				WAPI_pushDOMAttribute("submit-input"; "disabled"; "disabled")
			End if 
		Else 
			WAPI_pushDOMAttribute("submit-input"; "disabled"; "disabled")
			WAPI_pushDOMAttribute($tSource; "checked"; "")
			WAPI_pushDisplayMessage("Required Fields"; "Not all required fields have been completed.<br>"+$tResult)
		End if 
		
		
	Else 
		
		
End case 



If ($updateRates) & ($request.isQuote=False:C215)  //need to talk to tiran how to handle to vs from amts to get rates
	//don't update if we are using a quote
	C_OBJECT:C1216($o)
	C_REAL:C285($rBase; $rMargin)
	//mop=ewire so we can have an untiered  rate
	//pass in $0.00 b/c we don't know if from or to amoutn b/c cust can enter either
	//<>TODO agents will need to do something different
	
	Case of 
		: ($tContext="agents")
			$specificID:=[Agents:22]AgentID:1
			$groupName:=""
			
		: ($tContext="customers")
			$specificID:=[Customers:3]CustomerID:1
			$groupName:=[Customers:3]GroupName:90
		Else 
			$specificID:=[Customers:3]CustomerID:1
			$groupName:=[Customers:3]GroupName:90
	End case 
	
	Case of 
		: ($tSource="webewires-amount-input")  //no fee
			//this is for change in from amt
			$o:=getTieredRate($tToCCY; $tFromCCY; $rFromAmount; $isSell=True:C214; $groupName; $specificID; "ewire")
		: ($tSource=WAPI_getInputControlID(->[WebEWires:149]fromAmount:3))  //fee included
			$o:=getTieredRate($tToCCY; $tFromCCY; $rFromAmount; $isSell=True:C214; $groupName; $specificID; "ewire")
		Else   //this is for change in TO amt
			$o:=getTieredRate($tToCCY; $tFromCCY; $rToAmount; $isSell=True:C214; $groupName; $specificID; "ewire")
	End case 
	
	//customer ccy is the base/denomonitor - always calc in the local currency
	// direct rate is the price of the product
	$rDirectRate:=$o.rate
	$rBase:=$o.base
	$rFromFee:=$o.fee
	$rMargin:=$o.margin
	$tGroup:=$o.group
	$tCust:=$o.customer
	$mop:=$o.mop
	
	
	//---<>TODO -- DO WE NEED A SETTING TO SET THE ROUNDING PLACES -----
	$rDirectRate:=Round:C94($rDirectRate; 6)
	$rBase:=Round:C94($rBase; 6)
	$rInverseRate:=1/$rDirectRate
	$rInverseRate:=Round:C94($rInverseRate; 6)
	
	$tRateNotes:=$tToCCY+"->"+$tFromCCY+"  Rate Rule: "+$tCust+" | "+$tGroup+" | Base: "+String:C10($rBase)+" Margin: "+String:C10($rMargin)+" Fee: "+String:C10($rFromFee)
	
	If ($rDirectRate=0)  //error
		WAPI_pushDisplayMessage("Rate Error"; "There was an error retrieving the rate. Please try again later.")
	End if 
	
	$bRefresh:=True:C214
End if 

If ($bRefresh)
	
	If ($tDoTransfer="")
	Else 
		$rDiscount:=Num:C11(getKeyValue("web.customers.webewires.bank.discount"))
		$rFee:=$rFee-$rDiscount
	End if 
	
	Case of 
		: ($tSource="webewires-amount-input")  //no fee
			$rToAmount:=$rFromAmount*$rInverseRate
		: ($tSource=WAPI_getInputControlID(->[WebEWires:149]fromAmount:3))
			$rToAmount:=($rFromAmount-$rFromFee)*$rInverseRate
		Else 
			$rFromAmount:=roundToBase($rToAmount*$rDirectRate)  //fromAmt = local amt
	End case 
	
	
	If (WAPI_isDebug)
		$tRateNotes:="Inverse rate: "+String:C10($rInverseRate; "###0.000000")
		WAPI_pushDOMHTML(WAPI_getInputHelpID(->[WebEWires:149]inverseRate:14); $tRateNotes)
	Else 
		
	End if 
	
	
	
	If (WAPI_isDebug)  //show all decimal places
		WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]fromAmount:3); String:C10($rFromAmount+$rFromFee))
		WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toAmount:10); String:C10($rToAmount))
		WAPI_pushDOMValue("webewires-amount-input"; String:C10($rFromAmount))
		WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]fromFee:6); String:C10($rFromFee))
		WAPI_pushDOMHTML("destination-tab-status"; "["+String:C10($rToAmount)+"]")
	Else 
		WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]fromAmount:3); String:C10($rFromAmount+$rFromFee; "###############0.00"))
		WAPI_pushDOMValue("webewires-amount-input"; String:C10($rFromAmount; "###############0.00"))
		WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]toAmount:10); String:C10($rToAmount; "###############0.00"))
		WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]fromFee:6); String:C10($rFromFee; "###############0.00"))
		WAPI_pushDOMHTML("destination-tab-status"; "["+String:C10($rToAmount; "###,###,##0.00")+"]")
	End if 
	
	WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]directRate:13); String:C10($rDirectRate; "###############0.000000"))
	WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]inverseRate:14); String:C10($rInverseRate; "###############0.000000"))
	WAPI_pushDOMValue(WAPI_getInputControlID(->[WebEWires:149]spotRate:36); String:C10($rBase; "###############0.000000"))
	
	WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[WebEWires:149]directRate:13); $tToCCY+"/"+$tFromCCY)
	WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[WebEWires:149]inverseRate:14); $tFromCCY+"/"+$tToCCY)
	
	WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[WebEWires:149]fromAmount:3); $tFromCCY)
	WAPI_pushDOMHTML("webewires-amount-addon-post"; $tFromCCY)
	WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[WebEWires:149]toAmount:10); $tToCCY)
	WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[WebEWires:149]fromFee:6); $tFromCCY)
	
	WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[WebEWires:149]fromAmount:3); webGetFlag_Currency($tFromCCY))
	WAPI_pushDOMImgSrc("webewires-amount-addon-pre"; webGetFlag_Currency($tFromCCY))
	WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[WebEWires:149]toAmount:10); webGetFlag_Currency($tToCCY))
	WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[WebEWires:149]fromFee:6); webGetFlag_Currency($tFromCCY))  //send image
End if 


If ($tEvent="onload")  // don't need to update receipt
	
Else   //--------- RECEIPT -----------
	$tReceipt:=$tReceipt+"<hr>"
	
	If ($request.paymentInfo.deliveryMethod="MG")
		$tReceipt:=$tReceipt+"MoneyGram <br>"
		$tReceipt:=$tReceipt+WAPI_getInputValue(->[WebEWires:149]paymentInfo:35; "deliveryMethod2")+"<br>"
	Else 
		$tReceipt:=$tReceipt+WAPI_getInputValue(->[WebEWires:149]AML_Info:9; "toMOP")+"<br>"
	End if 
	
	$tReceipt:=$tReceipt+"<hr>"
	
	$tReceipt:=$tReceipt+"Send: "+String:C10($rToAmount; "###,###,##0.00")+" "+$tToCCY+"<br>"
	$tReceipt:=$tReceipt+"To: "+WAPI_getInputValue(->[WebEWires:149]toParty:8; Info_FullName)+"<hr>"
	
	$tReceipt:=$tReceipt+"Purpose: "+WAPI_getInputValue(->[WebEWires:149]AML_Info:9; AML_purposeOfTransaction)+" "+"<br>"
	$tReceipt:=$tReceipt+"Source: "+WAPI_getInputValue(->[WebEWires:149]AML_Info:9; AML_sourceOfFunds)+" "+"<br>"
	
	If ($request.paymentInfo.deliveryMethod="MG")
		$tReceipt:=$tReceipt+"<hr>MoneyGram:<br>"
		//loop thru all MG required
		For ($i; 1; Size of array:C274($ptrNameArray->))
			$name:=$ptrNameArray->{$i}
			If ($name="mg-required-@")
				$tReceipt:=$tReceipt+Replace string:C233($name; "mg-required-"; "")+": "+WAPI_getParameter($name)+" "+"<br>"
			End if 
		End for 
		
		$tReceipt:=$tReceipt+"<hr>"
		$tReceipt:=$tReceipt+"Amount Due: "+String:C10($rFromAmount; "###,###,##0.00")+" "+$tFromCCY+"<br>"
		
	Else 
		Case of 
			: ($toMOP=getKeyValue("web.customers.webewires.tomop.bank"))
				$tReceipt:=$tReceipt+"<hr>"
				$tReceipt:=$tReceipt+"Bank: "+WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_Name)+" "+"<br>"
				
				If (webIsBankFieldRequired($request.toCountryCode; "iban"))
					$tReceipt:=$tReceipt+"IBAN: "+WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo)+" "+"<br>"
				Else 
					$tReceipt:=$tReceipt+"Account: "+WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo)+" "+"<br>"
				End if 
				
				If (webIsBankFieldRequired($request.toCountryCode; "transit"))
					$tReceipt:=$tReceipt+"Transit Code: "+WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode)+" "+"<br>"
				End if 
				
				If (webIsBankFieldRequired($request.toCountryCode; "swift"))
					$tReceipt:=$tReceipt+"SWIFT: "+WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_Swift)+" "+"<br>"
				End if 
				
				If (webIsBankFieldRequired($request.toCountryCode; "ifsc"))
					$tReceipt:=$tReceipt+"IFSC: "+WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_Swift)+" "+"<br>"
				End if 
				
				If (webIsBankFieldRequired($request.toCountryCode; "aba"))
					$tReceipt:=$tReceipt+"Routing Code: "+WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_RoutingCode)+" "+"<br>"
				End if 
				
			: ($toMOP=getKeyValue("web.customers.webewires.tomop.mobilewallet"))  //fiji
				$tReceipt:=$tReceipt+"Mobile Wallet: "+WAPI_getInputValue(->[WebEWires:149]toParty:8; Info_CellPhone)+" <br>"
				
			: ($toMOP=getKeyValue("web.customers.webewires.tomop.cash"))
				$tReceipt:=$tReceipt+"Cash Pickup <br>"
				
			Else   //assume cash
				$tReceipt:=$tReceipt+"Cash Pickup <br>"
		End case 
		
		//$tReceipt:=$tReceipt+"<hr>"
		//$tReceipt:=$tReceipt+"Purpose: "+WAPI_getInputValue (->[WebEWires]AML_Info;AML_purposeOfTransaction)+" "+"<br>"
		//$tReceipt:=$tReceipt+"Source: "+WAPI_getInputValue (->[WebEWires]AML_Info;AML_sourceOfFunds)+" "+"<br>"
		
		$tResult:=WAPI_getInputValue(->[WebEWires:149]toThirdParty:23; Info_FullName)
		If ($tResult="")
		Else 
			$tReceipt:=$tReceipt+"<hr>"
			$tReceipt:=$tReceipt+"Third Party: "+$tResult+" "+"<br>"
		End if 
		
		$tReceipt:=$tReceipt+"<hr>"
		$tReceipt:=$tReceipt+"You Send: "+String:C10($request.fromAmount-$request.fromFee; "###,###,##0.00")+"<br>"
		$tReceipt:=$tReceipt+"Rate: "+String:C10($request.inverseRate; "###,###,##0.0000")+"<br>"
		$tReceipt:=$tReceipt+"Fee: "+String:C10($request.fromFee; "###,###,##0.00")+"<br>"
		$tReceipt:=$tReceipt+"Amount Due: "+String:C10($request.fromAmount; "###,###,##0.00")+" "+$tFromCCY+"<br>"
		
	End if 
	
	WAPI_pushDOMHTML("webewire-receipt"; $tReceipt)
End if 




$request.mgTransaction:=$transaction  // store so we can just use in the onSave

$status:=WAPI_sessionSet("request"; New object:C1471("value"; $request))
If ($status.success)
Else 
	TRACE:C157
End if 

WAPI_pushJs("wapiShowProcessing(false)")

$0:=WAPI_pullJsStack


