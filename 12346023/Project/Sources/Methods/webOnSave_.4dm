//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/26/18, 08:58:31
// ----------------------------------------------------
// Method: webHandleSaveButton
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptrTable)
C_POINTER:C301($2; $ptrNameArray)
C_POINTER:C301($3; $ptrValueArray)
C_LONGINT:C283($0)

C_LONGINT:C283($iResult; $ierror; $OK; $i)
C_TEXT:C284($webErrorMessage; $tError; $tMethodName)
C_LONGINT:C283($webMessageType)
C_OBJECT:C1216($request)

$ptrTable:=$1
$ptrNameArray:=$2
$ptrValueArray:=$3


$ierror:=1
$OK:=1

//do we need/want to test for session? should already be accounted for but...
//callback for filling in default values

C_OBJECT:C1216($status)
$status:=WAPI_sessionGet("request")

If ($status.success)  // if there is a request updated with current values
	
	$request:=$status.value
	
	For ($i; 1; Size of array:C274($ptrNameArray->))
		WAPI_inputId2Entity(->$request; $ptrNameArray->{$i})
	End for 
	
	$status:=WAPI_sessionSet("request"; New object:C1471("value"; $request))
End if 

$tMethodName:="webOnSave_"+Table name:C256($ptrTable)
If (UTIL_isMethodExists($tMethodName))
	EXECUTE METHOD:C1007($tMethodName; $OK; $ptrNameArray; $ptrValueArray)
End if 

If ($OK=1)
	$webErrorMessage:=""
	$webMessageType:=0
	
	// validation for the table is done at this level
	If (webValidateTable($ptrTable))
		
		Case of 
			: ($ptrTable=(->[Links:17]))
				If (Is new record:C668([Links:17]))
					$webErrorMessage:="Your beneficiary has been added to your account."
				Else 
					$webErrorMessage:="Your beneficiary information has been updated."
				End if 
				$webMessageType:=1  //success
				
			: ($ptrTable=(->[Customers:3]))
				If (Is new record:C668([Customers:3]))
					$webErrorMessage:="Your profile has been submitted."
				Else 
					$webErrorMessage:="Your profile has been updated."
				End if 
				$webMessageType:=1  //success
				
			: ($ptrTable=(->[Bookings:50]))
				$webErrorMessage:="Your booking has been submitted."
				$webMessageType:=1  //success
				
			: ($ptrTable=(->[WebEWires:149]))
				
				Case of 
					: (Is new record:C668([WebEWires:149]))
						//not paid yet
					: (webGetWebewirePayStatus="completed")
						$webErrorMessage:=getKeyValue("web.customers.webewires.confirmation.alert")
						If ($webErrorMessage="")
							$webErrorMessage:="You have successfully completed your Send Money request.<br>We will review your transaction and send you an email<br>once payment has been processed."
						End if 
						$webErrorMessage:=$webErrorMessage+" ["+[WebEWires:149]WebEwireID:1+"]"
						$webMessageType:=1  //success
				End case 
				
			Else 
				$webErrorMessage:="Your "+Table name:C256($ptrTable)+" has been submitted."
				$webMessageType:=1  //success
		End case 
		
		If ($webErrorMessage="")
		Else 
			WAPI_setAlertMessage($webErrorMessage; $webMessageType; False:C215)
		End if 
		
		//do we need a callback for success ? ie. send email confirmations or other?
		
		$ierror:=0
	Else 
		$ierror:=1
	End if 
End if 

$0:=$ierror