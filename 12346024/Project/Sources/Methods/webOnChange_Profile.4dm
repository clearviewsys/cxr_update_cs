//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/12/18, 14:23:56
// ----------------------------------------------------
// Method: webFormOnChange_profile
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

C_TEXT:C284($tValue; $tCurrCode)
C_BOOLEAN:C305($bRefresh; $isSell)
C_REAL:C285($rBookAmt; $rAmt; $rFee)
C_BOOLEAN:C305($bOnLoad)
C_TEXT:C284($tSection; $help; $alert)
C_COLLECTION:C1488($col)


$tFormName:=$1
$tEvent:=$2
$tSource:=$3
$tSourceType:=$4
$ptrNameArray:=$5
$ptrValueArray:=$6

$tResult:=""
$bRefresh:=False:C215
$bOnLoad:=False:C215


If ($tEvent="DOMContentLoaded") | ($tEvent="onload")  //ON LOAD phase
	$bOnLoad:=True:C214
End if 


Case of 
	: ($tSource=WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15))
		
		$col:=Split string:C1554(getKeyValue("web.customers.profile.id.requires.multiple.list"); ","; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
		
		If ($col.indexOf(WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15)))>=0)  //
			//If (WAPI_getParameter (WAPI_getInputControlID (->[Customers]PictureID_TemplateID))="DL")
			WAPI_pushDOMVisible("profile-id-extra-group"; True:C214)
			$help:=webGetKeyValue("web.customers.profile.id.multiple.help"; "*** This type of ID REQUIRES an additional document ***")
			$alert:=webGetKeyValue("web.customers.profile.id.multiple.alert"; "*** This type of ID REQUIRES an additional document ***")
		Else 
			$help:=""
			$alert:=""
			WAPI_pushDOMVisible("profile-id-extra-group"; False:C215)
		End if 
		
		WAPI_pushDOMHelp(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15); $help; "text-danger small")
		WAPI_pushDOMHTML("profile-id-extra-alert"; $alert)
		
	: ($tSource="edit-button@")
		
		$tSection:=Replace string:C233($tSource; "edit-button-"; "")
		
		//enable all fields for editing
		WAPI_pushJs(WAPI_setAllInputReadOnly(False:C215))
		WAPI_pushDOMVisible("edit-button-"+$tSection; False:C215)
		WAPI_pushDOMVisible("cancel-button-"+$tSection; True:C214)
		WAPI_pushDOMVisible("save-button-"+$tSection; True:C214)
		
		
		If ($tSection="id")
			WAPI_pushDOMVisible("customers-pictureid_image-file"; True:C214)
		End if 
		
	: ($tSource="cancel-button@")  //hide cancel/save and show edit
		
		$tSection:=Replace string:C233($tSource; "cancel-button-"; "")
		
		//  ------ NEED TO UPDATE VALUES BASED ON SAVED IN CASE USER MADE ANY CHANGES --- <>TODO
		//disable all fields for editing
		WAPI_pushJs(WAPI_setAllInputReadOnly(True:C214))
		WAPI_pushDOMVisible("edit-button-"+$tSection; True:C214)
		WAPI_pushDOMVisible("cancel-button-"+$tSection; False:C215)
		WAPI_pushDOMVisible("save-button-"+$tSection; False:C215)
		
		
		If ($tSection="id")
			WAPI_pushDOMVisible("customers-pictureid_image-file"; False:C215)
		End if 
		
		
	: ($tSource="save-button@")
		
		$tSection:=Replace string:C233($tSource; "save-button-"; "")
		
		
		//---------------- SUBMIT BUTTON AND AGFEEMENT CHECKBOX ----------------------
	: ($tSource="agreement-input")  //checkbox to agree to conditions
		C_REAL:C285($iElem)
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				WAPI_pushJs("$('#submit-new-input').removeAttr('disabled');")
			Else 
				WAPI_pushJs("$('#submit-new-input').attr('disabled', 'disabled');")
			End if 
		Else 
			WAPI_pushJs("$('#submit-new-input').attr('disabled', 'disabled');")
		End if 
		
		
		//--- OPT IN CHECKBOX ----
	: ($tSource="optin-input")  //checkbox to optin  to marketing
		C_REAL:C285($iElem)
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				
			Else 
				
			End if 
		Else 
			
		End if 
		
		
	: ($tSource="profile-existing-input")
		If (WAPI_getParameter("profile-existing-input")="on")
			WAPI_pushDOMProperty("profile-new-input"; "checked"; "false")
			WAPI_pushDOMVisible("profile-create-row"; False:C215)
			WAPI_pushDOMVisible("profile-existing-submit"; True:C214)
		Else 
			WAPI_pushDOMProperty("profile-new-input"; "checked"; "true")
			WAPI_pushDOMVisible("profile-create-row"; True:C214)
			WAPI_pushDOMVisible("profile-existing-submit"; False:C215)
		End if 
		
	: ($tSource="profile-new-input")
		If (WAPI_getParameter("profile-new-input")="on")
			WAPI_pushDOMProperty("profile-existing-input"; "checked"; "false")
			WAPI_pushDOMVisible("profile-create-row"; True:C214)
			WAPI_pushDOMVisible("profile-existing-submit"; False:C215)
		Else 
			WAPI_pushDOMProperty("profile-existing-input"; "checked"; "true")
			WAPI_pushDOMVisible("profile-create-row"; False:C215)
			WAPI_pushDOMVisible("profile-existing-submit"; True:C214)
		End if 
		
		
		
	Else 
		
End case 




$0:=WAPI_pullJsStack  //$tResult
