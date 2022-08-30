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
var $isCashMOP : Boolean  // TB


C_TEXT:C284($0; $tResult)

C_TEXT:C284($tValue; $tCurrCode; $tAccountID; $tCountryCode; $tCurrFromCode; $tCustomerID)
C_TEXT:C284($tEvent; $tName; $tOrigCurrCode; $tOrigCurrFromCode; $tRateNotes; $tResult)

C_BOOLEAN:C305($bRefresh; $isSell; $bQuery)
C_REAL:C285($rAmt; $rFee; $rFromAmtTotal; $rInverseRate; $rSourceRate; $rSourceServiceFeeLocal; $rToAmount)
C_PICTURE:C286($picStatus)
C_DATE:C307($dDOB)
C_LONGINT:C283($iSwitch)

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
		
		C_LONGINT:C283($iElem)
		$iElem:=Find in array:C230($ptrNameArray->; "customers___customerid")
		If ($iElem>0)
			$tCustomerID:=$ptrValueArray->{$iElem}
		Else 
			$tCustomerID:=""
		End if 
		
	Else 
		
End case 



// THESE ARE HIDDEN FIELDS WE USE TO STORE THE CURRENCY SELECTED
$tOrigCurrCode:=WAPI_getInputValue(->[eWires:13]Currency:12)
$tOrigCurrFromCode:=WAPI_getInputValue(->[eWires:13]FromCurrency:11)
$tCurrCode:=$tOrigCurrCode
$tCurrFromCode:=$tOrigCurrFromCode
$rSourceRate:=Num:C11(WAPI_getInputValue(->[eWires:13]sourceRate:41))

$iElem:=Find in array:C230($ptrNameArray->; WAPI_getInputControlID(->[eWires:13]sourceRate:41)+"-inverse")
If ($iElem>0)
	$rInverseRate:=Num:C11($ptrValueArray->{$iElem})
End if 

If ($rInverseRate=0)
	$rInverseRate:=Round:C94(1/$rSourceRate; 5)
End if 

$rToAmount:=Num:C11(WAPI_getInputValue(->[eWires:13]ToAmount:14))  // this is the sending amount - destination - need to calc the source amt
$rSourceServiceFeeLocal:=Num:C11(WAPI_getInputValue(->[eWires:13]sourceServicefeeLocal:44))  //Manual entry by agent
$tName:=WAPI_getInputValue(->[eWires:13]BeneficiaryFullName:5)
$tCustomerID:=WAPI_getInputValue(->[eWires:13]CustomerID:15)
$isCashMOP:=Choose:C955(getKeyValue("web.customers.webewires.tomop.cash")=WAPI_getInputValue(->[eWires:13]toMOP_Code:114); True:C214; False:C215)


C_TEXT:C284($tClass)

If ($tEvent="DOMContentLoaded") | ($tEvent="onload")  //---------- ON LOAD phase ---------
	
	Case of 
		: (webContext="customers")
			$tClass:=webGetSanctionListClass(Table:C252(->[Links:17]); [Links:17]LinkID:1; makeFullName([Links:17]FirstName:2; [Links:17]LastName:3))
			WAPI_pushDOMHTML("beneficiary-tab-status"; "["+[Links:17]FullName:4+"]")
			WAPI_pushDOMClass("beneficiary-tab-status"; $tClass)
			WAPI_pushDOMHTML("customer-tab-status"; "["+[Customers:3]FullName:40+"]")
			WAPI_pushDOMClass("customer-tab-status"; webGetSanctionListClass(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)))
			
			
			
		: (webContext="agents")
			If ($tCustomerID="")
			Else 
				QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$tCustomerID)
				
				WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); [Customers:3]FullName:40)
				WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]CustomerID:15); $tCustomerID)
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); "readonly"; "readonly")
				WAPI_pushDOMVisible("beneficiary-hidden"; False:C215)
				WAPI_pushDOMHTML("beneficiary-tab-status"; "["+[Customers:3]FullName:40+"]")
				WAPI_pushDOMClass("beneficiary-tab-status"; webGetSanctionListClass(Table:C252(->[Customers:3]); [Customers:3]CustomerID:1; makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)))
			End if 
			
			$tClass:=webGetSanctionListClass(Table:C252(->[Links:17]); [Links:17]LinkID:1; makeFullName([Links:17]FirstName:2; [Links:17]LastName:3))
			WAPI_pushDOMClass("customer-tab-status"; $tClass)
			
			If (WAPI_getInputValue(->[eWires:13]doTransferToBank:33)="on")
				WAPI_pushDOMVisible("delivery-hidden"; True:C214)
			End if 
			
			WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[eWires:13]sourceRate:41); $tCurrCode+"/"+$tCurrFromCode)  //SET THE ADDON POST -- 12/22/18 for agent
			WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[eWires:13]sourceRate:41)+"-inverse"; $tCurrFromCode+"/"+$tCurrCode)  //SET THE ADDON POST -- 12/22/18 for agent
			
			//set the sending amount currency and the total local amt due currency
			WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[eWires:13]ToAmount:14); $tCurrCode)
			WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[eWires:13]ToAmount:14); webGetFlag_Currency($tCurrCode))  //send image
			
			WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[eWires:13]amountLocal:45); $tCurrFromCode)
			WAPI_pushDOMHTML(WAPI_getInputAddonPostID(->[eWires:13]sourceServicefeeLocal:44); $tCurrFromCode)  //send image
			
			WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[eWires:13]amountLocal:45); webGetFlag_Currency($tCurrFromCode))
			WAPI_pushDOMImgSrc(WAPI_getInputAddonPreID(->[eWires:13]sourceServicefeeLocal:44); webGetFlag_Currency($tCurrFromCode))  //send image
			
		Else 
			
	End case 
	
	$bRefresh:=False:C215
End if 





If ($tFormName="ewires-form-settle")
	
	C_TEXT:C284($tSecurityCode)
	$tSecurityCode:=WAPI_getParameter(WAPI_getInputControlID(->[eWires:13]securityChallengeCode:75)+"-validator")
	
	Case of 
		: ($tSource=(WAPI_getInputControlID(->[eWires:13]securityChallengeCode:75)+"-validator"))
			Case of 
				: ($tSecurityCode="") & ($isCashMOP)  //nothing to check
				: ($tSecurityCode=[eWires:13]securityChallengeCode:75) & ($isCashMOP)  //a match
					//set the "ERROR" code to success
					WAPI_pushDOMError(WAPI_getInputControlID(->[eWires:13]securityChallengeCode:75)+"-validator"; "SUCCESS"; "text-success")
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]isSettled:23); "disabled"; "")  //pass no value to remove the attribute
					
				: ($tSecurityCode#[eWires:13]securityChallengeCode:75) & ($isCashMOP)  //cash and no Match
					WAPI_pushDOMError(WAPI_getInputControlID(->[eWires:13]securityChallengeCode:75)+"-validator"; "ERROR - Security Code Does NOT Match"; "text-danger")
					WAPI_pushDOMAttribute("submit-input"; "disabled"; "disabled")
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]isSettled:23); "checked"; "")
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]isSettled:23); "disabled"; "disabled")
					
				Else   //bank mop
					
			End case 
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]isSettled:23))  //---------------- MARKED AS SETTLED CHECKBOX ----------------------
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
			
	End case 
	
End if 




If (True:C214)
	$bRefresh:=False:C215
Else   //no updating via the web currently
	Case of 
		: ($tFormName="ewires-form-settle")  //1/15/20 no updating allowed - actually now wiht webewires shouldn't need the rest of this case
			$bRefresh:=False:C215
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]AccountID:30)) | ($tSource="rateRefresh") | ($tEvent="DOMContentLoaded")  // --------------------- AGENT -  CHANGE IN DESTINATION ACCOUNT ---
			
			$tAccountID:=WAPI_getInputValue(->[eWires:13]AccountID:30)  //;$ptrNameArray;$ptrValueArray)
			If (WAPI_isDebug)
				WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]AccountID:30); $tAccountID)  //make sure all iterations are updated
			End if 
			
			QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=$tAccountID)
			$tCurrCode:=[Accounts:9]Currency:6
			
			READ ONLY:C145([Currencies:6])
			QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=[Accounts:9]CurrencyAlias:26)  //<-- CURRENCYCODE IS THE ALIAS
			
			Case of 
				: (Records in selection:C76([Currencies:6])=1)
					$tCurrFromCode:=[Currencies:6]toISO4217:32  //to currency
					$rSourceRate:=[Currencies:6]OurSellRateLocal:8
					$rInverseRate:=[Currencies:6]OurSellRateInverse:26
					
				: (Records in selection:C76([Currencies:6])>1)
					$tCurrFromCode:="ERR"
					$rSourceRate:=1
					$rInverseRate:=1
					
				Else 
					$tCurrFromCode:="ERR"
					$rSourceRate:=1
					$rInverseRate:=1
			End case 
			
			$bRefresh:=True:C214
			
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]toCountryCode:112))  // ---------------------------- CHANGE IN DESTINATION COUNTRY --- UPDATE ACCOUNT-ID OPTIONS
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
			
			
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]CounterAccountID:120))  // ------------------------- AGENT -  CHANGE IN DESTINATION ACCOUNT ---
			
			
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]CustomerID:15)) & (webContext="agents")  // ------------------------------- CHANGE IN BENEFICIARY POPUP/SELECT (CUSTOMER) ------
			$tCustomerID:=WAPI_getInputValue(->[eWires:13]CustomerID:15)  //;$ptrNameArray;$ptrValueArray)
			
			Case of 
				: ($tCustomerID="")  //shouldn't get this
					
				: ($tCustomerID="|@")  //no id assigned yet
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); Replace string:C233($tCustomerID; "|"; ""))
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]CustomerID:15); $tCustomerID)
					WAPI_pushDOMVisible("beneficiary-new"; True:C214)
					WAPI_pushDOMVisible("beneficiary-search"; False:C215)
					WAPI_pushDOMVisible("beneficiary-link"; False:C215)
					WAPI_pushDOMFocus(WAPI_getInputControlID(->[eWires:13]BeneficiaryAddress:59))
					WAPI_pushDOMHTML("beneficiary-tab-status"; "["+Replace string:C233($tCustomerID; "|"; "")+"]")
					WAPI_pushDOMClass("beneficiary-tab-status")  //remove all classes
					WAPI_pushDOMClass("beneficiary-tab-status"; "sanction-unknown")
					
					WAPI_pushDOMImgSrc("beneficiary-tab-image"; "")
					
				: ($tCustomerID="NEW")
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); "")
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]CustomerID:15); "NEW")
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); "readonly"; "")  //remove read only
					WAPI_pushDOMVisible("beneficiary-new"; True:C214)
					WAPI_pushDOMVisible("beneficiary-search"; False:C215)
					WAPI_pushDOMVisible("beneficiary-link"; False:C215)
					WAPI_pushDOMFocus(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5))
					WAPI_pushDOMHTML("beneficiary-tab-status"; "")
					WAPI_pushDOMClass("beneficiary-tab-status")  //remove all classes
					//wapi_pushDOMImgSrc ("beneficiary-tab-image";"")
					
				: ($tCustomerID="SEARCH")
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); "")  //clear the value here
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]CustomerID:15); "SEARCH")
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); "readonly"; "")  //remove read only
					WAPI_pushDOMVisible("beneficiary-search"; True:C214)
					WAPI_pushDOMVisible("beneficiary-new"; False:C215)
					WAPI_pushDOMVisible("beneficiary-link"; False:C215)
					WAPI_pushDOMFocus(WAPI_getInputControlID(->[Customers:3]CustomerID:1))
					WAPI_pushDOMHTML("beneficiary-tab-status"; "")
					WAPI_pushDOMClass("beneficiary-tab-status")  //remove all classes
					//wapi_pushDOMImgSrc ("beneficiary-tab-image";"")
					
				Else 
					QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$tCustomerID)
					
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); [Customers:3]FullName:40)
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]CustomerID:15); $tCustomerID)
					WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryCellPhone:61); [Customers:3]CellPhone:13)
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5); "readonly"; "readonly")
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
					
			End case 
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]BeneficiaryFullName:5))  // ---------------------- ADD NEW - BENEFICIARY NAME CHANGE ---
			WAPI_pushDOMHTML("beneficiary-tab-status"; "["+$tName+"]")
			WAPI_pushDOMClass("beneficiary-tab-status")  //remove all classes
			
			
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]isThirdPartyInvolved:67))  // --------------------- IS THIRD PARTY INVOVLED---
			$iElem:=Find in array:C230($ptrNameArray->; $tSource)
			If ($iElem>0)
				If ($ptrValueArray->{$iElem}="on")
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]ThirdPartyDetails:68); "readonly"; "false")
				Else 
					WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]ThirdPartyDetails:68); "readonly"; "true")
				End if 
			Else 
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]ThirdPartyDetails:68); "readonly"; "true")
			End if 
			
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]doTransferToBank:33))  // ------------------------- DIRECT DEPOSIT ------
			
			$iElem:=Find in array:C230($ptrNameArray->; $tSource)
			If ($iElem>0)
				If ($ptrValueArray->{$iElem}="on")
					
					WAPI_pushDOMVisible("delivery-hidden"; True:C214)
					
					Case of 
						: (webContext="customers")
							
						: (webContext="agents")
							QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$tCustomerID)
							
							QUERY:C277([WireTemplates:42]; [WireTemplates:42]CustomerID:2=$tCustomerID; *)
							QUERY:C277([WireTemplates:42];  & ; [WireTemplates:42]relationship:34="self")
							
							If (Records in selection:C76([WireTemplates:42])>0)
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
								WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankName:76); "readonly"; "false")
								WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankAccountNo:66); "readonly"; "false")
								WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankTransitCode:77); "readonly"; "false")
								WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankDetails:38); "readonly"; "false")
							End if 
							
						Else 
							
					End case 
					
				End if 
			Else 
				
				//ADDED PURPOST OF TRANS
				//[Customers]NatureOfBusiness=POT
				
				WAPI_pushDOMVisible("delivery-hidden"; False:C215)
				WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankName:76); "")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankAccountNo:66); "")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankTransitCode:77); "")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankDetails:38); "")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]PurposeOfTransaction:65); "")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]AMLsourceOfFunds:94); "")
				
				//turn ON read only
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankName:76); "readonly"; "true")
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankAccountNo:66); "readonly"; "true")
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankTransitCode:77); "readonly"; "true")
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[eWires:13]BeneficiaryBankDetails:38); "readonly"; "true")
				
				WAPI_pushDOMHTML("delivery-tab-status"; "")
			End if 
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]PurposeOfTransaction:65))  // --------------------- PURPOSE OF TRANSACTION  ------
			WAPI_pushDOMHTML("aml-tab-status"; "["+Substring:C12(WAPI_getInputValue(->[eWires:13]PurposeOfTransaction:65); 1; 15)+"...]")
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]Currency:12))  // --------------------------------- CHANGE IN CURRENCY ------ NOT USED - ALL BASED ON ACCOUNTS NOW
			WAPI_pushDOMHTML("destination-tab-status"; "["+String:C10($rToAmount; "###,###,##0.00")+" "+$tCurrCode+"]")
			$bRefresh:=True:C214
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]sourceServicefeeLocal:44))  // -------------------- CHANGE IN FEE ------
			$bRefresh:=True:C214
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]ToAmount:14))  // --------------------------------- CHANGE IN TO AMOUNT ------
			$bRefresh:=True:C214
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]amountLocal:45))  // ------------------------------ CHANGE IN FROM AMOUNT -- LOCAL AMOUNT------
			$bRefresh:=True:C214
			
		: ($tSource=WAPI_getInputControlID(->[eWires:13]sourceRate:41))  //-------------------------------- CHANGE IN RATE -------
			$rInverseRate:=1/$rSourceRate
			$bRefresh:=True:C214
			
		: ($tSource=(WAPI_getInputControlID(->[eWires:13]sourceRate:41)+"-inverse"))
			$rSourceRate:=1/$rInverseRate
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
		Else 
			
	End case 
End if 


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

C_REAL:C285($percentFee)

If ($bRefresh)
	
	If ($tCurrCode="")
		$tCurrCode:="?"
	End if 
	
	If ($tCurrFromCode="")
		$tCurrFromCode:="?"
	End if 
	
	C_REAL:C285($rAmountLocal; $PercentFeeLocal; $TotalFees; $amountLocal_BF)
	//$feeLocal:=$rSourceServiceFeeLocal
	$rAmountLocal:=Num:C11(WAPI_getInputValue(->[eWires:13]amountLocal:45))  //;$ptrNameArray;$ptrValueArray))
	
	//$inverseRate:=$rInverseRate
	//$rate:=$rSourceRate
	//$amount:=$rToAmount  //to amount
	//$currency:=$tCurrCode  //to currency
	$percentFee:=0
	$PercentFeeLocal:=0
	$TotalFees:=$rSourceServiceFeeLocal
	$amountLocal_BF:=0
	
	
	If ($tSource=WAPI_getInputControlID(->[eWires:13]amountLocal:45))
		//switch = 1 = toamount
		//switch = 5 = from amount
		$iSwitch:=1
	Else 
		$iSwitch:=5
	End if 
	
	calculateFieldsInInvoiceRows($iSwitch; False:C215; $tCurrCode; ->$rToAmount; ->$rSourceRate; ->$percentFee; ->$rSourceServiceFeeLocal; ->$rAmountLocal; ->$amountLocal_BF; ->$PercentFeeLocal; ->$TotalFees; ->$rInverseRate)
	
	
	WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]ToAmount:14); String:C10($rToAmount; "###############0.00"))
	WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]amountLocal:45); String:C10($rAmountLocal; "###############0.00"))
	
	WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]Currency:12); $tCurrCode)  //hidden field in header
	WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]FromCurrency:11); $tCurrFromCode)  //hidden field in header
	WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]sourceRate:41); String:C10($rSourceRate))
	WAPI_pushDOMValue(WAPI_getInputControlID(->[eWires:13]sourceRate:41)+"-inverse"; String:C10($rInverseRate))
	WAPI_pushDOMValue(WAPI_getInputControlID(->[Currencies:6]OurSellRateInverse:26); String:C10($rInverseRate))  //hidden field in header
	
	$tRateNotes:="Inverse Rate: "+String:C10($rInverseRate)
	WAPI_pushDOMHTML("ewires-currency-rate-inverse"; $tRateNotes)  //SET THE INVERSE RATE TEXT
	WAPI_pushDOMHTML("ewires-currency-rate-updated"; "Updated: "+String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178))
	
	//wapi_pushDOMValue (WAPI_getInputControlID (->[eWires]sourceServicefeeLocal);String($rSourceServiceFeeLocal;"######0.00")) ` THIS IS A MANUAL ENTRY
End if 


//webInitRecordSelection   //reduce selection to 0 for all tables -- CAN REMOVE THIS WITH WAPI_COMPONENT UPDATE

$0:=WAPI_pullJsStack  //$tResult

