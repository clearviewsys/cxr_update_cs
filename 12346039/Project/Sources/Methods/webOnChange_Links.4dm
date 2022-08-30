//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/18/18, 20:21:20
// ----------------------------------------------------
// Method: webOnChange_Links
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


C_TEXT:C284($0; $tResult)

C_TEXT:C284($tValue; $tCurrCode; $tContext)
C_BOOLEAN:C305($bRefresh; $isSell)
C_REAL:C285($rBookAmt; $rAmt; $rFee)
C_LONGINT:C283($iTable; $iMatch; $iElem)
C_BOOLEAN:C305($isEntity; $isForced)
C_TEXT:C284($sanctionCheckResult; $tClass)
C_DATE:C307($dDOB)

$tFormName:=$1
$tEvent:=$2
$tSource:=$3
$tSourceType:=$4
$ptrNameArray:=$5
$ptrValueArray:=$6

//$tFormName:=WAPI_getParameter ("form";$ptrNameArray;$ptrValueArray)

$tResult:=""

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


C_TEXT:C284($tCustomerID; $tFirstName; $tLastName; $name)
C_BOOLEAN:C305($doUpdateBanking)

$doUpdateBanking:=False:C215

Case of 
	: ($tEvent="DOMContentLoaded") | ($tEvent="onload")  //on load event
		WAPI_pushDOMVisible("aml-form-group"; False:C215)
		
		$tValue:=WAPI_getInputValue(->[Links:17]countryCode:50)
		If ($tValue="")
		Else 
			$doUpdateBanking:=True:C214
		End if 
		
		
	: ($tSource=WAPI_getInputControlID(->[Links:17]CustomerID:14))
		$tCustomerID:=WAPI_getInputValue(->[Links:17]CustomerID:14)  //;$ptrNameArray;$ptrValueArray)
		
		QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$tCustomerID)
		
		If (Records in selection:C76([Customers:3])=1)
			WAPI_pushDOMValue(WAPI_getInputControlID(->[Links:17]CustomerName:15); [Customers:3]FullName:40)
			WAPI_pushDOMAttribute(WAPI_getInputControlID(->[Links:17]CustomerName:15); "readonly"; "readonly")
			WAPI_pushDOMValue(WAPI_getInputControlID(->[Links:17]CustomerPhone:16); [Customers:3]CellPhone:13)
			WAPI_pushDOMAttribute(WAPI_getInputControlID(->[Links:17]CustomerPhone:16); "readonly"; "readonly")
			WAPI_pushDOMError(WAPI_getInputControlID(->[Links:17]CustomerID:14); "SUCCESS - Customer found."; "text-success")
			If ([Customers:3]Comments:43="")
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[Links:17]Comments:10); "readonly"; "")
			Else 
				WAPI_pushDOMValue(WAPI_getInputControlID(->[Links:17]Comments:10); [Customers:3]Comments:43)
				WAPI_pushDOMAttribute(WAPI_getInputControlID(->[Links:17]Comments:10); "readonly"; "readonly")
			End if 
			WAPI_pushDOMValue(WAPI_getInputControlID(->[Links:17]CustomerBankInfo:17); "")
			WAPI_pushDOMAttribute(WAPI_getInputControlID(->[Links:17]CustomerBankInfo:17); "readonly"; "readonly")
		Else 
			WAPI_pushDOMAttribute(WAPI_getInputControlID(->[Links:17]CustomerName:15); "readonly"; "")
			WAPI_pushDOMAttribute(WAPI_getInputControlID(->[Links:17]CustomerPhone:16); "readonly"; "")
			WAPI_pushDOMError(WAPI_getInputControlID(->[Links:17]CustomerID:14); "ERROR - Customer NOT found."; "text-danger")
			
			WAPI_pushDOMAttribute(WAPI_getInputControlID(->[Links:17]Comments:10); "readonly"; "")
			WAPI_pushDOMAttribute(WAPI_getInputControlID(->[Links:17]CustomerBankInfo:17); "readonly"; "")
		End if 
		
		
	: ($tSource=WAPI_getInputControlID(->[Links:17]FirstName:2)) | ($tSource=WAPI_getInputControlID(->[Links:17]LastName:3))\
		 | ($tSource=WAPI_getInputControlID(->[Links:17]DOB:49))
		
		$tFirstName:=WAPI_getInputValue(->[Links:17]FirstName:2)
		$tLastName:=WAPI_getInputValue(->[Links:17]LastName:3)
		$dDOB:=Date:C102(WAPI_getInputValue(->[Links:17]DOB:49)+"T00:00:00")
		
		If ($tContext="customers")  //dont check sanctions
			// check for dups and alert if a possible existe
			If ($tLastName#"") & ($tFirstName#"")  //& ($dDOB#!00-00-00!)
				C_OBJECT:C1216($entity)
				$entity:=ds:C1482.Links.query("CustomerID == :1 AND LastName == :2 AND FirstName == :3"; $tCustomerID; $tLastName; $tFirstName)
				If ($entity.length>0)
					WAPI_pushDisplayMessage("Duplicate Warning.\n\nThe following beneficiary already exists.\n\n"+\
						"First Name: "+$entity.first().FirstName+"\nLast Name: "+$entity.first().LastName+"\nBirth Date: "\
						+$entity.first().DOB+"\nCity: "+$entity.first().City+"\nCountry: "+$entity.first().Country)
					
				End if 
			End if 
			
		Else   //check sanctionlist
			
			If ($tFirstName#"") & ($tLastName#"")
				WAPI_pushDOMClass("links-lastname-label")  //clear the classes on this div
				
				C_TEXT:C284($name; $iID; $sanctionCheckResult)
				C_BOOLEAN:C305($isEntity; $isForced)
				$name:=makeFullName($tFirstName; $tLastName)
				$iTable:=Table:C252(->[Links:17])
				$isEntity:=False:C215
				$isForced:=True:C214
				$iMatch:=-9999
				
				$iID:=WAPI_getParameter(WAPI_Field2Txt(->[Links:17]LinkID:1); ""; $ptrNameArray; $ptrValueArray)
				
				START TRANSACTION:C239
				$sanctionCheckResult:=checkNameAgainstAllLists($name; ->$iMatch; $isEntity; $iTable; $iID; $isForced)  //  Force checking in sanction lists
				$tClass:=webGetSanctionListClass($iTable; $iID; $name)
				CANCEL TRANSACTION:C241  //so we dont' save sanctionlog records
				
				WAPI_pushDOMClass("links-lastname-label"; $tClass+" form-control-label")
				
				If ($sanctionCheckResult="")
					WAPI_pushDOMProperty(WAPI_getInputControlID(->[Links:17]AML_isOnHold:54); "checked"; "false")
					WAPI_pushDOMValue(WAPI_getInputControlID(->[Links:17]AML_OnHoldNotes:56); "")
					WAPI_pushDOMVisible("aml-form-group"; False:C215)
				Else 
					WAPI_pushDOMProperty(WAPI_getInputControlID(->[Links:17]AML_isOnHold:54); "checked"; "true")
					WAPI_pushDOMValue(WAPI_getInputControlID(->[Links:17]AML_OnHoldNotes:56); "Sanction check.")
					WAPI_pushDOMVisible("aml-form-group"; True:C214)
				End if 
				
				If ($tClass="sanction-warning")
					WAPI_pushDOMError(WAPI_getInputControlID(->[Links:17]LastName:3); $sanctionCheckResult; "text-danger")
				Else 
					WAPI_pushDOMError(WAPI_getInputControlID(->[Links:17]LastName:3); $sanctionCheckResult; "text-warning")
				End if 
			End if 
			
		End if 
		
	: ($tSource=WAPI_getInputControlID(->[Links:17]isCompany:43))
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				WAPI_pushDOMVisible("company-info-hidden"; True:C214)
				WAPI_pushDOMVisible("individual-info-hidden"; False:C215)
			Else 
				WAPI_pushDOMVisible("company-info-hidden"; False:C215)
				WAPI_pushDOMVisible("individual-info-hidden"; True:C214)
			End if 
		Else 
			WAPI_pushDOMVisible("company-info-hidden"; False:C215)
			WAPI_pushDOMVisible("individual-info-hidden"; True:C214)
		End if 
		
		
		
	: ($tSource=WAPI_getInputControlID(->[Links:17]CompanyName:42))
		If (True:C214)  //is company is checked
			WAPI_pushDOMClass("links-companyname-label")  //clear the classes on this div
			
			$iID:=WAPI_getParameter(WAPI_Field2Txt(->[Links:17]LinkID:1); ""; $ptrNameArray; $ptrValueArray)
			$name:=WAPI_getInputValue(->[Links:17]CompanyName:42)
			$iTable:=Table:C252(->[Links:17])
			$isEntity:=True:C214
			$isForced:=True:C214
			$iMatch:=-9999
			
			START TRANSACTION:C239
			$sanctionCheckResult:=checkNameAgainstAllLists($name; ->$iMatch; $isEntity; $iTable; $iID; $isForced)  //  Force checking in sanction lists
			$tClass:=webGetSanctionListClass($iTable; $iID; $name)
			CANCEL TRANSACTION:C241  //so we dont' save sanctionlog records
			
			WAPI_pushDOMClass("links-companyname-label"; $tClass+" form-control-label")
			
			If ($sanctionCheckResult="")
				WAPI_pushDOMProperty(WAPI_getInputControlID(->[Links:17]AML_isOnHold:54); "checked"; "false")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[Links:17]AML_OnHoldNotes:56); "")
				WAPI_pushDOMVisible("aml-form-group"; False:C215)
			Else 
				WAPI_pushDOMProperty(WAPI_getInputControlID(->[Links:17]AML_isOnHold:54); "checked"; "true")
				WAPI_pushDOMValue(WAPI_getInputControlID(->[Links:17]AML_OnHoldNotes:56); "Sanction check.")
				WAPI_pushDOMVisible("aml-form-group"; True:C214)
			End if 
			
			If ($tClass="sanction-warning")
				WAPI_pushDOMError(WAPI_getInputControlID(->[Links:17]CompanyName:42); $sanctionCheckResult; "text-danger")
			Else 
				WAPI_pushDOMError(WAPI_getInputControlID(->[Links:17]CompanyName:42); $sanctionCheckResult; "text-warning")
			End if 
		End if 
		
	: ($tSource=WAPI_getInputControlID(->[Links:17]countryCode:50))
		$doUpdateBanking:=True:C214
		
	: ($tSource="agreement-input")  //---------------- SUBMIT BUTTON AND AGFEEMENT CHECKBOX ----------------------
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				WAPI_pushJs("$('#submit-input').removeAttr('disabled');")
			Else 
				WAPI_pushJs("$('#submit-input').attr('disabled', 'disabled');")
			End if 
		Else 
			WAPI_pushJs("$('#submit-input').attr('disabled', 'disabled');")
		End if 
End case 


If ($doUpdateBanking)
	$tValue:=WAPI_getInputValue(->[Links:17]countryCode:50)
	WAPI_pushDOMVisible("banking-iban"; Choose:C955(webIsBankFieldRequired($tValue; "iban"); True:C214; False:C215))
	WAPI_pushDOMVisible("banking-account"; Choose:C955(webIsBankFieldRequired($tValue; "iban"); False:C215; True:C214))  //if not iban then account
	WAPI_pushDOMVisible("banking-transit"; Choose:C955(webIsBankFieldRequired($tValue; "transit"); True:C214; False:C215))
	WAPI_pushDOMVisible("banking-swift"; Choose:C955(webIsBankFieldRequired($tValue; "swift"); True:C214; False:C215))
	WAPI_pushDOMVisible("banking-ifsc"; Choose:C955(webIsBankFieldRequired($tValue; "ifsc"); True:C214; False:C215))
	WAPI_pushDOMVisible("banking-aba"; Choose:C955(webIsBankFieldRequired($tValue; "aba"); True:C214; False:C215))
End if 



If (False:C215)  //---------------- SUBMIT BUTTON AND AGFEEMENT CHECKBOX ----------------------
	If ($tSource="agreement-input")  //| ($bOnLoad)  //checkbox to agree to conditions
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				WAPI_pushJs("$('#submit-input').removeAttr('disabled');")
			Else 
				WAPI_pushJs("$('#submit-input').attr('disabled', 'disabled');")
			End if 
		Else 
			WAPI_pushJs("$('#submit-input').attr('disabled', 'disabled');")
		End if 
	End if 
End if 




$0:=WAPI_pullJsStack  //$tResult