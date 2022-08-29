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


$tFormName:=$1
$tEvent:=$2
$tSource:=$3
$tSourceType:=$4
$ptrNameArray:=$5
$ptrValueArray:=$6

$tResult:=""
$bRefresh:=False:C215
C_BOOLEAN:C305($bOnLoad)
C_TEXT:C284($tSection)
C_LONGINT:C283($i)
$bOnLoad:=False:C215


If ($tEvent="DOMContentLoaded") | ($tEvent="onload")  //ON LOAD phase
	$bOnLoad:=True:C214
End if 


Case of 
	: ($tSource="edit-button@")
		
		$tSection:=Replace string:C233($tSource; "edit-button-"; "")
		
		//enable all fields for editing
		For ($i; 1; Size of array:C274($ptrNameArray->))
			If ($ptrNameArray->{$i}="@-input")  //these are fields
				WAPI_pushDOMAttribute($ptrNameArray->{$i}; "readonly"; "false")
			End if 
		End for 
		
		WAPI_pushDOMVisible("edit-button-"+$tSection; False:C215)
		WAPI_pushDOMVisible("cancel-button-"+$tSection; True:C214)
		WAPI_pushDOMVisible("save-button-"+$tSection; True:C214)
		
		
		If ($tSection="id")
			WAPI_pushDOMVisible("agents-picture-file"; True:C214)
		End if 
		
	: ($tSource="cancel-button@")  //hide cancel/save and show edit
		
		$tSection:=Replace string:C233($tSource; "cancel-button-"; "")
		
		//  ------ NEED TO UPDATE VALUES BASED ON SAVED IN CASE USER MADE ANY CHANGES --- <>TODO
		//disable all fields for editing
		For ($i; 1; Size of array:C274($ptrNameArray->))
			If ($ptrNameArray->{$i}="@-input")  //these are fields
				WAPI_pushDOMAttribute($ptrNameArray->{$i}; "readonly"; "true")
			End if 
		End for 
		
		WAPI_pushDOMVisible("edit-button-"+$tSection; True:C214)
		WAPI_pushDOMVisible("cancel-button-"+$tSection; False:C215)
		WAPI_pushDOMVisible("save-button-"+$tSection; False:C215)
		
		
		If ($tSection="id")
			WAPI_pushDOMVisible("agents-picture-file"; False:C215)
		End if 
		
		
	: ($tSource="save-button@")
		
		$tSection:=Replace string:C233($tSource; "save-button-"; "")
		
	Else 
		
End case 


$0:=WAPI_pullJsStack  //$tResult
