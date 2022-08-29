//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project Method: WAPI_hookSubmitForm

//  ` This hook is called before a form is submitted.
// You can error check the fields and pass back jquery javascript to display errors

// Access: Shared

// Parameters: $1=form name - text ; t


// Go to the example database to copy the example for this method
// This method was automatically generated by WAPI on Apr 5, 2019.
// WAPI is Copyright 2018 - 2019-- IBB Consulting, LLC 
// ----------------------------------------------------

C_POINTER:C301($1; $ptrTable)
C_TEXT:C284($2; $tForm)
C_POINTER:C301($3; $ptrNameArray)
C_POINTER:C301($4; $ptrValueArray)
C_TEXT:C284($0; $tJavaScript)

C_LONGINT:C283($i; $iElem; $iType; $iCount)
C_POINTER:C301($ptrField)
C_TEXT:C284($tPanelAlert; $tFieldName; $tForm; $tJavaScript; $tPanelAlert; $tSecurityCode; $tValue)
C_TEXT:C284($fieldList; $fieldName; $condition; $tMethod; $message; $tInputControl; $addListener)
C_TEXT:C284($tInputControl; $tInputName)
C_DATE:C307($dDate)
C_OBJECT:C1216($entity)


$ptrTable:=$1
$tForm:=$2
$ptrNameArray:=$3
$ptrValueArray:=$4

$tJavaScript:=""
$fieldList:=""
$fieldName:=""


$tMethod:=Method called on error:C704
//ON ERR CALL("wapi_onerror")


//NEED TO HANDLE CONDITIONAL FIELDS... IF DEPOSIT TO BANK NOT CHECKED THEN DON'T CHECK BANK ACCOUNT NUMBER...

Case of 
	: ($tForm="login-register-@")
		
		$tValue:=WAPI_getParameter("userName")
		If ($tValue="")
			$fieldList:=$fieldList+"userName cannot be blank <br>"
		End if 
		
		$tValue:=WAPI_getParameter("userEmail")
		If ($tValue="")
			$fieldList:=$fieldList+"Email address cannot be blank <br>"
		End if 
		
		$tValue:=WAPI_getParameter("userPassword@")
		If ($tValue="")
			$fieldList:=$fieldList+"Password cannot be blank <br>"
		Else 
			If (isPasswordStrong($tValue; ->$message))
			Else 
				$fieldList:=$fieldList+$message+"<br>"
			End if 
		End if 
		
		
	: ($tForm="profile-confirm-form@")
		$iCount:=0
		
		$tValue:=WAPI_getInputValue(->[Customers:3]DOB:5)
		If (Date:C102($tValue)>!1900-01-01!)
			$iCount:=$iCount+1
		End if 
		
		$tValue:=WAPI_getInputValue(->[Customers:3]SIN_No:14)
		If ($tValue#"")
			$iCount:=$iCount+1
		End if 
		
		$tValue:=WAPI_getInputValue(->[Customers:3]SecretQuestion:83)
		If ($tValue#"")
			$iCount:=$iCount+1
		End if 
		
		$tValue:=WAPI_getInputValue(->[Customers:3]City:8)
		If ($tValue#"")
			$iCount:=$iCount+1
		End if 
		
		If ($iCount<2)
			$fieldList:="You must complete at least two of the confirmation questions."
		End if 
		
		
		
		
	: ($ptrTable=(->[eWires:13]))
		
		$tFieldName:=WAPI_getInputControlID(->[eWires:13]doTransferToBank:33)
		
		$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
		If ($iElem>0)  //if found then it is on
		Else   //remove other bank info fields b/c we don't need to check
			
			$tFieldName:=WAPI_getInputControlID(->[eWires:13]BeneficiaryBankAccountNo:66)
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
			$tFieldName:=WAPI_getInputControlID(->[eWires:13]BeneficiaryBankDetails:38)
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
			$tFieldName:=WAPI_getInputControlID(->[eWires:13]BeneficiaryBankName:76)
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
			$tFieldName:=WAPI_getInputControlID(->[eWires:13]BeneficiaryBankTransitCode:77)
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
			
		End if 
		
		
		$tFieldName:=WAPI_getInputControlID(->[eWires:13]PurposeOfTransaction:65)
		$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
		If ($iElem>0)
		Else 
			APPEND TO ARRAY:C911($ptrNameArray->; $tFieldName)
			APPEND TO ARRAY:C911($ptrValueArray->; "")
		End if 
		
		$tFieldName:=WAPI_getInputControlID(->[eWires:13]AMLsourceOfFunds:94)
		$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
		If ($iElem>0)
		Else 
			APPEND TO ARRAY:C911($ptrNameArray->; $tFieldName)
			APPEND TO ARRAY:C911($ptrValueArray->; "")
		End if 
		
		
		//-- TEST SECURITY CODE ---
		$tSecurityCode:=WAPI_getParameter(WAPI_getInputControlID(->[eWires:13]securityChallengeCode:75)+"-validator")
		
		If ($tSecurityCode=[eWires:13]securityChallengeCode:75)  //all good
		Else 
			$tPanelAlert:="$('[id="+WAPI_getInputControlID($ptrField)+"-validator]').parents('.panel-collapse').siblings('.panel-heading').children('h3').addClass('text-danger');"
			$tJavaScript:=$tJavaScript+$tPanelAlert+WAPI_setDOMError(WAPI_getInputControlID($ptrField)+"-validator"; "ERROR - Security Code does NOT MATCH."; "text-danger")
		End if 
		
		
	: ($ptrTable=(->[Links:17]))
		
		$tFieldName:=WAPI_getInputControlID(->[Links:17]isCompany:43)
		
		$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
		If ($iElem>0)  //if found then it is on
			$tFieldName:=WAPI_getInputControlID(->[Links:17]FirstName:2)  // remove from validation
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
			$tFieldName:=WAPI_getInputControlID(->[Links:17]LastName:3)  // remove from validation
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
		Else 
			$tFieldName:=WAPI_getInputControlID(->[Links:17]CompanyName:42)  // remove from validation
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
		End if 
		
	: ($ptrTable=(->[WebEWires:149]))
		$tFieldName:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_doTransferToBank)
		$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
		If ($iElem>0)  //if found then it is on - leave bank fields so they can be checked
		Else   //remove other bank info fields b/c we don't need to check
			$tFieldName:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo)
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
			$tFieldName:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Details)
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
			$tFieldName:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name)
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
			$tFieldName:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode)
			$iElem:=Find in array:C230($ptrNameArray->; $tFieldName)
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
			$iElem:=Find in array:C230($ptrNameArray->; WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Swift))
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
			
			$iElem:=Find in array:C230($ptrNameArray->; WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_RoutingCode))
			If ($iElem>0)
				DELETE FROM ARRAY:C228($ptrNameArray->; $iElem)
				DELETE FROM ARRAY:C228($ptrValueArray->; $iElem)
			End if 
		End if 
		
		
	Else 
		
End case 


If (Not:C34(Is nil pointer:C315($ptrTable)))
	
	For ($i; 1; Size of array:C274($ptrNameArray->))
		
		$ptrField:=WAPI_getControlID2Field($ptrNameArray->{$i})
		
		If (Is nil pointer:C315($ptrField))  //not a field
		Else 
			$entity:=ds:C1482.FieldConstraints.query("TableNo == :1 AND FieldNo == :2 AND isMandatory == :3 AND isWebConstraint < :4"; Table:C252($ptrTable); Field:C253($ptrField); True:C214; 2)
			
			If ($entity.length>0)
				
				$condition:=$entity.first().condition
				
				If ($condition="")
					isTrue:=True:C214
				Else 
					EXECUTE FORMULA:C63("isTrue:="+$condition)
				End if 
				
				If (isTrue)
					$fieldName:=Field name:C257($ptrField)
					$tValue:=$ptrValueArray->{$i}  //get value to eval
					$iType:=Type:C295($ptrField->)
					$tInputControl:=WAPI_getInputControlID($ptrField)
					
					//-------- NEED TO INJECT SOMETHING IN THE ACCORDIAN TAB TO INDICATE ERROR MIGHT BE HIDDEN ------
					If (False:C215)
						$tPanelAlert:="$('[id="+WAPI_getInputControlID($ptrField)+"]').parents('.panel-collapse').siblings('.panel-heading').children('h3').addClass('text-danger');"
					Else 
						If ($tPanelAlert="")
							$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"
							$tPanelAlert:=$tPanelAlert+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
						End if 
						
					End if 
					
					//NEED TO ADD SOMETHIGN TO THE TAB
					// method to get tab id for the field ???
					
					
					If (True:C214)
						Case of 
							: (Table:C252($ptrField)#(Table:C252($ptrTable)))  //2 different tables
								//don't check this
								
							: ($iType=Is alpha field:K8:1) | ($iType=Is text:K8:3)
								If ($tValue="")
									WAPI_pushJs($tPanelAlert)
									WAPI_pushDOMError($tInputControl; "* "+$fieldName+" is Mandatory."; "text-danger")
									WAPI_pushEventListener($tInputControl; "keypress"; "clear-error")
									
									$fieldList:=$fieldList+"<br>"+$fieldName
								End if 
								
							: ($iType=Is date:K8:7)
								$dDate:=Date:C102($tValue)
								If ($dDate=nullDate)
									WAPI_pushJs($tPanelAlert)
									WAPI_pushDOMError($tInputControl; "* "+$fieldName+" must have a valid date."; "text-danger")
									WAPI_pushEventListener($tInputControl; "keypress"; "clear-error")
									$fieldList:=$fieldList+"<br>"+$fieldName
								End if 
								
							: ($iType=Is real:K8:4) | ($iType=Is longint:K8:6) | ($iType=Is integer:K8:5)
								If (Num:C11($tValue)=0)
									WAPI_pushDOMError($tInputControl; "* "+$fieldName+" must not be zero."; "text-danger")
									WAPI_pushEventListener($tInputControl; "keypress"; "clear-error")
									$fieldList:=$fieldList+"<br>"+$fieldName
								End if 
								
							: ($iType=Is picture:K8:10)
								
							: ($iType=Is BLOB:K8:12)
								
							Else 
								
						End case 
						
						
					End if 
					
				End if 
			End if 
		End if 
		
	End for 
	
End if 


Case of 
	: ($ptrTable=(->[WebEWires:149]))  //above doesn't work with object fields
		//TRACE
		If (WAPI_getInputValue(->[WebEWires:149]paymentInfo:35; "deliveryMethod")="MG")  //moneyGram
			If (True:C214)  // check for MG required
				For ($i; 1; Size of array:C274($ptrNameArray->))
					$tInputControl:=$ptrNameArray->{$i}
					$tInputName:=Replace string:C233($tInputControl; "mg-required-"; "")
					If ($tInputControl="mg-required-@")
						If ($ptrValueArray->{$i}="")
							$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"\
								+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
							
							WAPI_pushJs($tPanelAlert)
							WAPI_pushDOMError($tInputControl; "* "+$tInputName+" must be provided."; "text-danger")
							WAPI_pushEventListener($tInputControl; "keypress"; "clear-error"; True:C214)
							
							$fieldList:=$fieldList+"<br>"+$tInputName
						End if 
					End if 
				End for 
			End if 
		Else 
			
			If (getKeyValue("web.customers.webewires.tomop.bank")=WAPI_getInputValue(->[WebEWires:149]AML_Info:9; AML_toMOPCode))
				
				$tInputControl:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Name)
				$tValue:=WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_Name)
				If ($tValue="")
					$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"
					$tPanelAlert:=$tPanelAlert+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
					
					WAPI_pushJs($tPanelAlert)
					WAPI_pushDOMError($tInputControl; "* Bank Name must be provided."; "text-danger")
					WAPI_pushEventListener($tInputControl; "keypress"; "clear-error"; True:C214)
					
					$fieldList:=$fieldList+"<br>"+"Bank Name"
				End if 
				
				
				$tInputControl:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo)
				$tValue:=WAPI_getInputValue(->[WebEWires:149]toBankingInfo:24; Bank_AccountNo)
				If ($tValue="")
					$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"
					$tPanelAlert:=$tPanelAlert+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
					
					WAPI_pushJs($tPanelAlert)
					WAPI_pushEventListener($tInputControl; "keypress"; "clear-error"; True:C214)
					
					If (webIsBankFieldRequired([WebEWires:149]toCountryCode:12; "iban"))
						WAPI_pushDOMError($tInputControl; "* IBAN must be provided."; "text-danger")
						$fieldList:=$fieldList+"<br>"+"IBAN"
					Else   // account
						WAPI_pushDOMError($tInputControl; "* Account number must be provided."; "text-danger")
						$fieldList:=$fieldList+"<br>"+"Bank Account Number"
					End if 
				End if 
				
				
				If (webIsBankFieldRequired([WebEWires:149]toCountryCode:12; "transit"))
					If ([WebEWires:149]toBankingInfo:24[Bank_TransitCode]="")
						$tInputControl:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_TransitCode)
						$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"
						$tPanelAlert:=$tPanelAlert+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
						
						WAPI_pushJs($tPanelAlert)
						WAPI_pushEventListener($tInputControl; "keypress"; "clear-error"; True:C214)
						WAPI_pushDOMError($tInputControl; "* Transit Code must be provided."; "text-danger")
						$fieldList:=$fieldList+"<br>"+"Transit Code"
					End if 
				End if 
				
				If (webIsBankFieldRequired([WebEWires:149]toCountryCode:12; "swift"))
					If ([WebEWires:149]toBankingInfo:24[Bank_Swift]="")
						$tInputControl:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Swift)
						$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"
						$tPanelAlert:=$tPanelAlert+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
						
						WAPI_pushJs($tPanelAlert)
						WAPI_pushEventListener($tInputControl; "keypress"; "clear-error"; True:C214)
						WAPI_pushDOMError($tInputControl; "* SWIFT Code must be provided."; "text-danger")
						$fieldList:=$fieldList+"<br>"+"SWIFT Code"
					End if 
				End if 
				
				If (webIsBankFieldRequired([WebEWires:149]toCountryCode:12; "ifsc"))
					If ([WebEWires:149]toBankingInfo:24[Bank_Swift]="")
						$tInputControl:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_Swift)
						$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"
						$tPanelAlert:=$tPanelAlert+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
						
						WAPI_pushJs($tPanelAlert)
						WAPI_pushEventListener($tInputControl; "keypress"; "clear-error"; True:C214)
						WAPI_pushDOMError($tInputControl; "* IFSC Code must be provided."; "text-danger")
						$fieldList:=$fieldList+"<br>"+"IFSC Code"
					End if 
				End if 
				
				If (webIsBankFieldRequired([WebEWires:149]toCountryCode:12; "aba"))
					If ([WebEWires:149]toBankingInfo:24[Bank_RoutingCode]="")
						$tInputControl:=WAPI_getInputControlID(->[WebEWires:149]toBankingInfo:24; Bank_RoutingCode)
						$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"
						$tPanelAlert:=$tPanelAlert+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
						
						WAPI_pushJs($tPanelAlert)
						WAPI_pushEventListener($tInputControl; "keypress"; "clear-error"; True:C214)
						WAPI_pushDOMError($tInputControl; "* ABA Routing Code must be provided."; "text-danger")
						$fieldList:=$fieldList+"<br>"+"ABA Routing Code"
					End if 
				End if 
				
				
			End if 
			
			If (getKeyValue("web.customers.webewires.tomop.mobilewallet")=WAPI_getInputValue(->[WebEWires:149]AML_Info:9; AML_toMOPCode))
				$tInputControl:=WAPI_getInputControlID(->[WebEWires:149]toParty:8; Info_CellPhone)
				$tValue:=WAPI_getInputValue(->[WebEWires:149]toParty:8; Info_CellPhone)
				If ($tValue="")
					$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"
					$tPanelAlert:=$tPanelAlert+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
					
					WAPI_pushJs($tPanelAlert)
					WAPI_pushDOMError($tInputControl; "* Mobile number must be provided."; "text-danger")
					WAPI_pushEventListener($tInputControl; "keypress"; "clear-error"; True:C214)
					
					$fieldList:=$fieldList+"<br>"+"Mobile Number"
				End if 
				
			End if 
			
			If (WAPI_getInputValue(->[WebEWires:149]AML_Info:9; AML_sourceOfFunds)="")  //this is required so send error back
				$tInputControl:=WAPI_getInputControlID(->[WebEWires:149]AML_Info:9; AML_sourceOfFunds)
				$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"
				$tPanelAlert:=$tPanelAlert+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
				
				WAPI_pushJs($tPanelAlert)
				WAPI_pushDOMError($tInputControl; "* Source of funds must be provided."; "text-danger")
				WAPI_pushEventListener($tInputControl; "keypress"; "clear-error"; True:C214)
				
				$fieldList:=$fieldList+"<br>"+"Source of Funds"
			End if 
			
			If (WAPI_getInputValue(->[WebEWires:149]AML_Info:9; AML_purposeOfTransaction)="")  //this is required so send error back
				$tInputControl:=WAPI_getInputControlID(->[WebEWires:149]AML_Info:9; AML_purposeOfTransaction)
				$tPanelAlert:="theID = $('[id="+$tInputControl+"]').parents('.tab-pane').attr('id');"\
					+"$('.nav-pills a[href=\"#'+theID+'\"]').tab('show');"  //can i make this a click
				
				WAPI_pushJs($tPanelAlert)
				WAPI_pushDOMError($tInputControl; "* Purpose of transaction must be provided."; "text-danger")
				WAPI_pushEventListener($tInputControl; "keypress"; "clear-error"; True:C214)
				
				$fieldList:=$fieldList+"<br>"+"Purpose of transaction"
			End if 
		End if 
		
		
	Else 
		
End case 


If ($tJavaScript="") & ($fieldList="")
	$0:=WAPI_pullJsStack
Else 
	$0:=WAPI_pullJsStack+WAPI_displayMessage("Please complete the following:"; "Review and correct the following errors: <br>"+$fieldList)
End if 

