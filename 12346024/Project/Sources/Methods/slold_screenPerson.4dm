//%attributes = {}
// handleCustomerNameCompliance
// $isForce    check no matter what or check only as server prefs
// $fullname   name of customer
// $logIdPtr   the id field ie. [Customer]CustomerId
// $resultIcon result icon
// $query      if not for all (not usuable for Version 1)
// $resultPtr  the pointer to store result string

// Author by: Wai-Kin Chau

C_TEXT:C284($sanctionCheckResult; $fullName; $tip)
C_LONGINT:C283($match)
C_BOOLEAN:C305($1; $isForced)
C_TEXT:C284($2; $fullName)
C_POINTER:C301($3; $logIdPtr; $resultIcon)
C_LONGINT:C283($0; $match)
C_OBJECT:C1216($4; $more; $options; $pointers)
$logIdPtr:=->[Customers:3]CustomerID:1
$resultIcon:=->latestCheckStatus1
C_TEXT:C284($resultText; $query)
$resultText:=""
$query:=""

$fullName:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)

$options:=sl_createDefaultOptionsObject($isForced)
Case of 
		
	: (Count parameters:C259=0)
		$isForced:=False:C215
		
		
	: (Count parameters:C259=1)
		$isForced:=$1
		
	: (Count parameters:C259=2)
		$isForced:=$1
		$fullName:=$2
		
	: (Count parameters:C259=3)
		$isForced:=$1
		$fullName:=$2
		$logIdPtr:=$3
		
	: (Count parameters:C259=4)
		$isForced:=$1
		$fullName:=$2
		$logIdPtr:=$3
		$options:=utils_setupObjectProperties($options; $4)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//$tip:=""
//clearPictureField ($resultIcon)
//OBJECT SET HELP TIP(*;"latestCheckStatus1";$tip)

//C_TEXT($resultWithoutPEP)
//$resultWithoutPEP:=""

var $runCheck : Boolean

$runCheck:=$isForced | <>doCheckSanctionLists

If ($runCheck)
	$runCheck:=stringHasMinimumLength($fullName; 3)
End if 

If ($runCheck)
	$runCheck:=utils_getValueFromObject($options; True:C214; "options"; "namePartsFilled")
End if 

If ($runCheck)
	// We must make sure that sanction List checks don't apply for customers that are on Whitelist unless the Whitelisting is expired.
	If ($logIdPtr#Null:C1517)
		$runCheck:=sl_isCustomerSubjectToScreening($logIdPtr->)
	End if 
End if 

var $data : Collection
If ($runCheck)
	$data:=slold_pickSanctionCheckLists($fullName; True:C214; $logIdPtr; $options)
	If ($data.length=0)
		
	Else 
		$0:=slo_displaySanctionListResult(\
			ds:C1482.SanctionCheckLog.fromCollection($data); \
			$options.options.interface; $options.pointers.resultIconPtr; \
			$options.pointers.resultTextPtr; $logIdPtr)
		
		If (utils_getValueFromObject($options; False:C215; "options"; "comfirmReject"))
			If ($0#0)
				myConfirm("Sanction check produces a match. Do you want to fix the issue?"; "Ignore and continue"; "Return and Edit")
				If (OK#1)
					REJECT:C38
				End if 
			End if 
		End if 
		If ($logIdPtr#Null:C1517)
			QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=Table:C252($logIdPtr); *)
			QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=$logIdPtr->)
		End if 
		
	End if 
End if 
